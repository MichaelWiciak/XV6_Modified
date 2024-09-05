# XV6 OS Enhancement Project

## Project Overview

This project enhances the XV6 operating system by adding additional user-space programs and optimizing existing ones for improved efficiency and added functionality. A significant part of the enhancement includes a custom memory management system that implements `malloc` and `free` functionality using a linked list to manage dynamic memory allocation efficiently. There is a .pdf report detailing how this works in the folder. 

## Memory Management: `memoryManagement.c` and `memoryManagement.h`

### Overview
The memory management component introduces a custom implementation of dynamic memory allocation (`_malloc`) and deallocation (`_free`) based on a linked list structure. This system tracks allocated memory blocks and manages free space more efficiently compared to the standard implementation, with features like splitting and merging memory blocks to reduce fragmentation.

### Key Features

1. **Linked List Structure for Memory Blocks**  
   The system uses a linked list (`LinkedListNode`) to track allocated and free memory blocks. Each node in the list represents a block of memory and contains:
   - `size`: The size of the allocated block.
   - `isThisNodeFree`: A flag indicating whether the block is free or in use.
   - `nextItemPointer`: A pointer to the next node in the list.

2. **Efficient Memory Allocation** (`_malloc`)  
   - **First-fit strategy**: The `_malloc` function traverses the linked list to find the first free block that can accommodate the requested size.
   - **Heap Expansion**: If no suitable free block is found, the heap is expanded using `sbrk()` to create a new block.
   - **Block Splitting**: If a free block is larger than required, it can be split to maximize memory usage (though the splitting logic is currently simplified for this version).

3. **Memory Deallocation and Block Merging** (`_free`)  
   - When freeing a memory block, the system attempts to merge adjacent free blocks to reduce fragmentation and avoid leaving small unusable chunks of memory.
   - The merging logic checks both the previous and next nodes in the linked list, combining blocks when possible.

### How it Works

- **Initialization**:  
  The linked list is initialized upon the first call to `_malloc`. The head node (`headOfLinkedList`) starts with zero size and is marked as in use.
  
- **Memory Allocation**:  
  When a new memory block is requested, `_malloc` checks the linked list for a suitable free block. If none is found, it requests additional memory from the OS using `sbrk()`. The new block is added to the linked list, and the pointer to the allocated memory is returned (offset by the size of the metadata structure to protect it from being overwritten).

- **Memory Deallocation**:  
  When a block is freed, `_free` marks the block as available for reuse and attempts to merge adjacent free blocks to optimize memory usage.

### Code Comments
Many `printf` statements have been commented out in the code, allowing developers to debug the memory management functions easily. By uncommenting these lines, you can see how the linked list nodes are being allocated, traversed, and freed.

---

This is one part of the larger XV6 project that improves system functionality through optimized user programs and resource management. More details on the additional user programs and other optimizations will be provided soon.
