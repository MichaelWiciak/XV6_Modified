// this file needs to be inside of the user space of the xv6 operating system
// as it requires types.h and user.h to be included
#include "../kernel/types.h"
//#include <stddef.h>
//#include <stdbool.h>
#include "user.h"

// Structure of my linked list malloc/free implementation
typedef struct linkedListNode {
    int size;
    int isThisNodeFree;
    struct linkedListNode* nextItemPointer;
} LinkedListNode;

// Used to keep track of the size of the linkedListNode structure
#define STRUCT_SIZE sizeof(LinkedListNode)
// Defines some macros here so the program wouldn't be dependent on certain
// libraries
#define NULL 0
#define true 1
#define false 0

// Function constructors
void* _malloc(int size);
void _free(void *ptr);
