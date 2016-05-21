#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "dirent.h"
#include "uart.h"
#include "sd.h"
#include "fs.h"

struct fat_fs {
	struct fs b;
	int fat_type;
	uint32_t total_sectors;
	uint32_t sectors_per_cluster;
	uint32_t bytes_per_sector;
	char *vol_label;
	uint32_t first_fat_sector;
	uint32_t first_data_sector;
	uint32_t sectors_per_fat;
	uint32_t root_dir_entries;
	uint32_t root_dir_sectors;
	uint32_t first_non_root_sector;
    uint32_t root_dir_cluster;
};

// FAT32 extended fields
//http://wiki.osdev.org/FAT#FAT_32
struct fat_extBS_32{
	uint32_t		table_size_32;
	uint16_t		extended_flags;
	uint16_t		fat_version;
	uint32_t		root_cluster;
	uint16_t		fat_info;
	uint16_t		backup_BS_sector;
	uint8_t			reserved_0[12];
	uint8_t			drive_number;
	uint8_t			reserved_1;
	uint8_t			boot_signature;
	uint32_t		volume_id;
	char			volume_label[11];
	uint8_t			fat_type_label[8];
};

// FAT 12/16 extended fields
struct fat_extBS_16{
	uint8_t			bios_drive_num;
	uint8_t			reserved1;
	uint8_t			boot_signature;
	uint32_t		volume_id;
	char			volume_label[11];
	uint8_t			fat_type_label[8];
};



// Generic FAT fields
struct fat_BS{
	uint8_t			bootjmp[3];
	uint8_t			oem_name[8];
	uint16_t		bytes_per_sector;
	uint8_t			sectors_per_cluster;
	uint16_t		reserved_sector_count;
	uint8_t			table_count;
	uint16_t		root_entry_count;
	uint16_t		total_sectors_16;
	uint8_t			media_type;
	uint16_t		table_size_16;
	uint16_t		sectors_per_track;
	uint16_t		head_side_count;
	uint32_t		hidden_sector_count;
	uint32_t		total_sectors_32;

	union
	{
		struct fat_extBS_32	fat32;
		struct fat_extBS_16	fat16;
	} ext;
};

void copy_to_fat16(struct fat_extBS_16* b, uint8_t *buf){
    memcpy(&(b->bios_drive_num), buf + 36, 1);
    memcpy(&(b->boot_signature), buf + 38, 1);
    memcpy(&(b->volume_id), buf + 39, 4);
    memcpy(&(b->volume_label), buf + 43, 11);
    memcpy(&(b->fat_type_label), buf + 54, 8);
}

void copy_to_fat32(struct fat_extBS_32* b, uint8_t *buf){
    memcpy(&(b->table_size_32), buf + 36, 4);
    memcpy(&(b->extended_flags), buf + 40, 2);
    memcpy(&(b->fat_version), buf + 42, 2);
    memcpy(&(b->root_cluster), buf + 44, 4);
    memcpy(&(b->fat_info), buf + 48, 2);
    memcpy(&(b->backup_BS_sector), buf + 50, 2);
    memcpy(&(b->drive_number), buf + 64, 1);
    memcpy(&(b->boot_signature), buf + 66, 1);
    memcpy(&(b->volume_id), buf + 67, 4);
    memcpy(&(b->volume_label), buf + 71, 11);
    memcpy(&(b->fat_type_label), buf + 82, 8);
}

void copy_to_fat_BS(struct fat_BS* b,uint8_t* buf){
    memcpy(&(b->bootjmp), buf + 0, 3);
    memcpy(&(b->oem_name), buf + 3, 8);
    memcpy(&(b->bytes_per_sector), buf + 11, 2);
    memcpy(&(b->sectors_per_cluster), buf + 13, 1);
    memcpy(&(b->reserved_sector_count), buf + 14, 2);
    memcpy(&(b->table_count), buf + 16, 1);
    memcpy(&(b->root_entry_count), buf + 17, 2);
    memcpy(&(b->total_sectors_16), buf + 19, 2);
    memcpy(&(b->media_type), buf + 21, 1);
    memcpy(&(b->table_size_16), buf + 22, 2);
    memcpy(&(b->sectors_per_track), buf + 24, 2);
    memcpy(&(b->head_side_count), buf + 26, 2);
    memcpy(&(b->hidden_sector_count), buf + 28, 4);
    memcpy(&(b->total_sectors_32), buf + 32, 4);
}

static const char *fat_names[] = { "FAT12", "FAT16", "FAT32"};
#define FAT12		0
#define FAT16		1
#define FAT32		2
#define FAT_BLOCK_SIZE      512

struct dirent *fat_read_dir(struct fat_fs *filesys, struct dirent *d);
int fat_load(const char *path, uint8_t *buf, uint32_t buf_size);
int fat_store(const char *path, uint8_t *buf);

int fat_init(struct fs **filesystem){

    // read master boot record to find where the first partition begins
    uint8_t buf[512];
    int r = sd_read(buf, FAT_BLOCK_SIZE, 0);

    if(r < 0){
		uart_puts("FAT: error reading mbr\r\n");
		return r;
    }
	if(r != 512){
		uart_puts("FAT: error reading mbr (only ");
		uart_put_uint32_t(r, 10);
		uart_puts(" bytes read)\r\n");
		return -1;
	}
    uint32_t partition_offset =              buf[454] << 0
                                |   buf[455] << 8
                                |   buf[456] << 16
                                |   buf[457] << 24;
 /*
    uart_puts("partition offset is ");
    uart_put_uint32_t(partition_offset, 16);
    uart_puts("\r\n");
*/

    //read block 0 where the boot section is
    r = sd_read(buf, FAT_BLOCK_SIZE, partition_offset);
    if(r < 0){
		uart_puts("FAT: error reading fat block 0\r\n");
		return r;
	}
	if(r != 512){
		uart_puts("FAT: error reading fat block 0 (only ");
		uart_put_uint32_t(r, 10);
		uart_puts(" bytes read)\r\n");
		return -1;
	}

	// need to align the elements, cant read like this!
	struct fat_BS myfat;
	copy_to_fat_BS(&myfat, buf);
	
	if(myfat.bootjmp[0] != 0xeb){
		return -1;
	}
	
	uint32_t total_sectors = myfat.total_sectors_16;
	if(total_sectors == 0){
		total_sectors = myfat.total_sectors_32;
	}
	struct fat_fs *ret = (struct fat_fs *)malloc(sizeof(struct fat_fs));
    
    memset(ret, 0, sizeof(struct fat_fs));

    ret->b.fs_load = fat_load;
    ret->b.fs_store = fat_store;
	ret->total_sectors = total_sectors;
    


    ret->bytes_per_sector = (uint32_t)myfat.bytes_per_sector;
    ret->root_dir_entries = myfat.root_entry_count;
    ret->root_dir_sectors = (ret->root_dir_entries * 32 + ret->bytes_per_sector -1) / ret->bytes_per_sector;

    uint32_t size = myfat.table_size_16;
    if(size == 0){      // is fat32
	    copy_to_fat32(&(myfat.ext.fat32), buf);
        size = myfat.ext.fat32.table_size_32;
    }
    
    uint32_t data_sec = total_sectors - (myfat.reserved_sector_count + myfat.table_count * size 
                                            + ret->root_dir_sectors);

    uint32_t total_clusters = data_sec / myfat.sectors_per_cluster;

                            
	if(total_clusters < 4085){
//		uart_puts("SD card is FAT12\r\n");
		ret->fat_type = FAT12;
	}else if(total_clusters < 65525){
//		uart_puts("SD card is FAT16\r\n");
		ret->fat_type = FAT16;
	}else{
//	    uart_puts("SD card is FAT32\r\n");
		ret->fat_type = FAT32;
	}
	ret->b.fs_name = fat_names[ret->fat_type];
	ret->sectors_per_cluster = myfat.sectors_per_cluster;
	ret->bytes_per_sector = myfat.bytes_per_sector;
	
/*	uart_puts("Reading a ");
	uart_puts(ret->b.fs_name);
	uart_puts(" filesystem:\r\n      -Total sectors: ");
	uart_put_uint32_t(ret->total_sectors, 10);
	uart_puts("\r\n      -Sectors per cluster: ");
	uart_put_uint32_t(ret->sectors_per_cluster, 10);
	uart_puts("\r\n      -Bytes per sector: ");
	uart_put_uint32_t(ret->bytes_per_sector, 10);
    uart_puts("\r\n      -number of FAT tables: ");
    uart_put_uint32_t(myfat.table_count, 10);
	uart_puts("\r\n");
*/	
	ret->vol_label = (char*)malloc(12);
	// if fat32
	if( ret->fat_type == FAT32){
	    copy_to_fat32(&(myfat.ext.fat32), buf);
	    strcpy(ret->vol_label, myfat.ext.fat32.volume_label);
	    ret->vol_label[11] = 0;
/*	    uart_puts("FAT volume label: ");
	    uart_puts(ret->vol_label);
	    uart_puts("\r\n");
*/	    
	    ret->first_data_sector = partition_offset + myfat.reserved_sector_count + (myfat.table_count *
			                                myfat.ext.fat32.table_size_32);
		ret->first_fat_sector = myfat.reserved_sector_count + partition_offset;
		ret->first_non_root_sector = ret->first_data_sector;
		ret->sectors_per_fat = myfat.ext.fat32.table_size_32;
/*		uart_puts("FAT first data sector: ");
		uart_put_uint32_t(ret->first_data_sector, 10);
		uart_puts(", first fat sector: ");
		uart_put_uint32_t(ret->first_fat_sector, 10);*/
        ret->root_dir_cluster = myfat.ext.fat32.root_cluster;
/*        uart_puts(", root is at: ");
        uart_put_uint32_t(ret->root_dir_cluster, 10);
        uart_puts("\r\nfat32 table size is ");
        uart_put_uint32_t(myfat.ext.fat32.table_size_32, 10);

		uart_puts("\r\n");*/
	}else{ // if fat16/12 
		copy_to_fat16(&(myfat.ext.fat16), buf);
	    strcpy(ret->vol_label, myfat.ext.fat16.volume_label);
	    ret->vol_label[11] = 0;
/*	    uart_puts("FAT volume label: ");
	    uart_puts(ret->vol_label);
	    uart_puts("\r\n");
*/	    
	    ret->first_data_sector = partition_offset + myfat.reserved_sector_count + (myfat.table_count *
			                                myfat.table_size_16);
		ret->first_fat_sector = myfat.reserved_sector_count + partition_offset;
		ret->sectors_per_fat = myfat.table_size_16;
		
		ret->root_dir_entries = myfat.root_entry_count;
		ret->root_dir_sectors = (ret->root_dir_entries * 32 + ret->bytes_per_sector - 1) /
			ret->bytes_per_sector;	// The + bytes_per_sector - 1 rounds up the sector no
		
		
		ret->first_non_root_sector = ret->first_data_sector;
/*		uart_puts("FAT first data sector: ");
		uart_put_uint32_t(ret->first_data_sector, 10);
		uart_puts(", first fat sector: ");
		uart_put_uint32_t(ret->first_fat_sector, 10);
		uart_puts("\r\n");
		
		uart_puts("FAT root dir entries: ");
		uart_put_uint32_t(ret->root_dir_entries, 10);
		uart_puts(", root dir sectors: ");
		uart_put_uint32_t(ret->root_dir_sectors, 10);
		uart_puts("\r\n");*/
	}
	*filesystem = (struct fs*)ret;
	
	return 1;
}
	
uint32_t get_sector(struct fat_fs *fs, uint32_t cluster){
    cluster -= 2;
    return fs->first_non_root_sector + cluster * fs->sectors_per_cluster;
}


static uint32_t get_next_fat_entry(struct fat_fs *filesys, uint32_t cur_cluster){
    uint32_t offset;
    uint32_t sector;
    uint8_t buf[512];
    int ret;
    uint32_t index;
    uint32_t next_cluster;
    switch(filesys->fat_type){
        case FAT16:
            offset = cur_cluster << 1;
            sector = filesys->first_fat_sector + (offset / filesys->bytes_per_sector);
            ret = sd_read(buf, 512, sector);
            if(ret < 0){
                return 0x0ffffff7;
            }
            index = offset & filesys->bytes_per_sector;
            next_cluster = (uint32_t)*(uint16_t*)&buf[index];
            return next_cluster;
        case FAT32:
            offset = cur_cluster << 2;
            sector = filesys ->first_fat_sector + (offset / filesys->bytes_per_sector);
            ret = sd_read(buf, 512, sector );
            if(ret < 0){
                return 0x0ffffff7;
            }
            index = offset % filesys->bytes_per_sector;
            next_cluster = *(uint32_t*)&buf[index];
            return next_cluster & 0x0fffffff;
        default:
            uart_puts("FAT: type ");
            uart_puts(filesys->b.fs_name);
            uart_puts(" is not supported\r\n");
            return 0;
    }
}

static size_t fat_read(struct fat_fs *filesystem, uint32_t cluster_no, uint8_t *buf,
                        size_t byte_count, size_t offset){
    uint32_t cur_cluster = cluster_no;
    size_t cluster_size = filesystem->bytes_per_sector * filesystem->sectors_per_cluster;
    size_t file_loc = 0;
    int buf_ptr = 0;
    while(cur_cluster < 0x0ffffff8){
        if(( file_loc + cluster_size) > offset){
            if( file_loc < (offset + byte_count)){
                //  load this cluster, as it contains the requested file
                uint32_t sector = get_sector(filesystem, cur_cluster);
                uint8_t * r_buf = (uint8_t*)malloc(cluster_size);
                int ret = sd_read(r_buf, cluster_size, sector);
                // check for error
                if(ret < 0){
                    return ret;
                }

                int len;
                int c_ptr;
                // what part of this sector is in the file
                if(offset >= file_loc){
                    // first cluster of file
                    buf_ptr = 0;
                    c_ptr = offset - file_loc;
                    len = byte_count;
                    if(len > (int)cluster_size){
                        len = cluster_size;
                    }
                }else{
                    // not first cluster of file
                    c_ptr = 0;
                    len = byte_count - buf_ptr;
                    if(len > (int)cluster_size)             { len = cluster_size;}
                    if(len > (int)(byte_count - buf_ptr))   { len = byte_count - buf_ptr;}
                }
                memcpy(buf + buf_ptr, r_buf + c_ptr, len);
                free(r_buf);
                buf_ptr += len;
            }
        }
        cur_cluster = get_next_fat_entry( filesystem, cur_cluster);
        file_loc += cluster_size;
    }
    return buf_ptr;
}


struct dirent *fat_read_dir(struct fat_fs *fs, struct dirent *d){
	int root = 0;
	struct fat_fs *fat = fs;
	if(d == NULL){
		root = 1;
    }
	uint32_t cur_cluster;
	uint32_t cur_root_cluster_offset = 0;
	if(root){
		cur_cluster = fat->root_dir_cluster;
	}else{
		cur_cluster = d->cluster_no;
    }
	struct dirent *ret = NULL;
	struct dirent *prev = NULL;

	do{
		// Read this cluster 
		uint32_t cluster_size = fat->bytes_per_sector * fat->sectors_per_cluster;
		uint8_t *buf = (uint8_t *)malloc(cluster_size);

		// Interpret the cluster number to an absolute address
		uint32_t abs_cluster = cur_cluster - 2;
		uint32_t first_data_sector = fat->first_data_sector;
		if(!root)
			first_data_sector = fat->first_non_root_sector;
		int br_ret = sd_read( buf, cluster_size, 
				abs_cluster * fat->sectors_per_cluster + first_data_sector);
		if(br_ret < 0){
			return (void*)0;
		}

		for(uint32_t ptr = 0; ptr < cluster_size; ptr += 32){
			// exists?
			if((buf[ptr] == 0) || (buf[ptr] == 0xe5)){  continue;}
			// the "." or ".." directory?
			if(buf[ptr] == '.')   {continue;}
			// long filename entry?
			if(buf[ptr + 11] == 0x0f){  continue;}

			// if not, we can read the entry
			struct dirent *de = (struct dirent *)malloc(sizeof(struct dirent));
			memset(de, 0, sizeof(struct dirent));
			if(ret == (void *)0)
				ret = de;
			if(prev != (void *)0)
				prev->next = de;
			prev = de;

			de->name = (char *)malloc(13);
			// interpret name
			int name_index = 0;
			int ext = 0;
			int has_ext = 0;
			for(int i = 0; i < 11; i++){
				char cur_v = (char)buf[ptr + i];
				if(i == 8){
					ext = 1;
					de->name[name_index++] = '.';
				}
				if(cur_v == ' ')
					continue;
				if(ext)
					has_ext = 1;
				if((cur_v >= 'A') && (cur_v <= 'Z'))
					cur_v = 'a' + cur_v - 'A';
				de->name[name_index++] = cur_v;
			}
			if(!has_ext)
				de->name[name_index - 1] = 0;
			else
				de->name[name_index] = 0;

			if(buf[ptr + 11] & 0x10)
				de->is_dir = 1;
			de->next = NULL;
			de->byte_size = *(uint32_t*)&buf[ptr + 28];
            uint32_t cluster_num = *(uint16_t*)&buf[ptr + 26] 
                    | ((uint32_t)(*(uint16_t*)&buf[ptr + 20]) << 16);

			de->cluster_no = cluster_num;
		}
		free(buf);
		// next cluster
		if(root && (fs->fat_type != FAT32)){
			cur_root_cluster_offset++;
			if(cur_root_cluster_offset < (fat->root_dir_sectors /
						fat->sectors_per_cluster)){
				cur_cluster++;
			}else{
				cur_cluster = 0x0ffffff8;
		    }
		}
		else{
			cur_cluster = get_next_fat_entry(fat, cur_cluster);
    }
	}while(cur_cluster < 0x0ffffff7);
	return ret;
}

//if input is 'jepp.txt\0'
// a.exe
int fat_get_next_path(const char *path){
    int offset = 0;
    // look for '/' to find directory
    // if not found loop has reached end of loop
    // we have found the filename.
    while(path[offset] != '\0'){
        if(path[offset] == '/'){   return offset; }

        offset++;
    }
    // has found filename
    return offset;
}

int fat_load(const char *path, uint8_t *buf, uint32_t buf_size){
    const char *c = path;
    int offset;
    struct dirent *node = NULL;
    struct dirent *current_node = NULL;
    struct dirent *free_node = NULL;
    struct fs* filesys = fs_get();
    if( path == NULL){  return -1; }

    // find first folder/file
    // look for '/' or '/'
    while(1){
        if(*c == '/'){ c++;}
        offset = fat_get_next_path(c);
        char* path_buf = (char*)malloc(sizeof(char) * offset + 1);
        memcpy(path_buf, c, offset);
        path_buf[offset] = '\0';
        // now path_buf contains the next segment in the path.
        // search for it!
        // delete all the other nodes in the linked list
        node = fat_read_dir( (struct fat_fs*)filesys, current_node);
        while(node){
            if( !strcmp( node->name, path_buf) ){
                current_node = node;
                node = node->next;
            }else{
                free_node = node;
                node = node->next;
                free(free_node);
            }
        }
        if( current_node == NULL)   { return -1; }
        // current_node now contains the dirent for the next path segment
        if(current_node->is_dir){
        }else{
            break;  // is file
        }
        c = c + offset;
        free(path_buf);
    }
    //  do something to load the file
    
    if( current_node->byte_size > buf_size){
        uart_put_uint32_t(current_node->byte_size, 10);
        return -1;
    }

    int ret = fat_read(     (struct fat_fs*)filesys,
                            current_node->cluster_no,
                            buf,
                            current_node->byte_size,
                            0);

    return ret;
}


int fat_store(const char *path, uint8_t *buf){
    return -1;
}

