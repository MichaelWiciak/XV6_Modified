#include <inc/lib.h>




































enum
{
	MAXMALLOC = 1024*1024	/* max size of one allocated chunk */
};

#define PTE_CONTINUED 0x400

static uint8_t *mbegin = (uint8_t*) 0x08000000;
static uint8_t *mend   = (uint8_t*) 0x10000000;
static uint8_t *mptr;


void free(void *v);
void* malloc(size_t n);
static int isfree(void *v, size_t n);
