#include <stdlib.h>
#include "dirent.h"

struct dirent* open_dir(struct fs *filesys, struct dirent* d, const char *name);

int load(struct fs *filesys, struct dirent* d, const char *name);


