# XV6 Modified

> Built a custom memory allocator (`malloc` / `free`) from scratch using a linked.

## What is this?

MIT's [XV6](https://github.com/mit-pdos/xv6-public) is a teaching-oriented reimplementation of Unix v6, rewritten for modern RISC-V architecture. I wanted to see how the things I use every day (processes, memory, filesystems) actually work under the hood. Plus, it's Unix, so the Kernel is editable (:

The main feature here is a custom memory allocator (`_malloc` / `_free`) built from scratch. There's a [detailed design document](./Memory%20Management%20Project/memory_management_design.pdf) if you want the full picture.

## The Interesting Bits

### Why build malloc?

When you call `malloc`, you're asking the runtime to find a chunk of free memory big enough for your data. Behind the scenes, the allocator juggles allocated and freed blocks, trying to satisfy future requests without wasting too much space or fragmenting memory into unusable minature blocks.

### The Linked List Approach

Each memory block carries its own bookkeeping:

```c
typedef struct LinkedListNode {
    int size;                              // How much data space this block holds
    int isThisNodeFree;                    // Is this block available?
    struct LinkedListNode *nextItemPointer; // Next block in the list
} LinkedListNode;
```

When you call `_malloc`, it scans this linked list using a **first-fit** strategy (finds the first free block that fits). If nothing works, it calls `sbrk()` to grab more heap from the OS.

When you call `_free`, it marks the block as free, then checks if the blocks next to it are also free. If they are, it merges them together. This keeps fragmentation from piling up.

The metadata lives _in-band_ with the data, right before the pointer I return to you. So the user gets `pointer + 1`, keeping the bookkeeping safe from accidental overwrites.

## Project Structure

```
XV6_Modified/
├── Memory Management Project/        # Standalone allocator (clean version)
│   ├── memory_management.c            # _malloc / _free implementation
│   ├── memory_management.h
│   └── memory_management_design.pdf   # Full design writeup
├── xv6/
│   ├── Makefile                       # Build system
│   ├── kernel/                        # XV6 kernel source
│   └── user/                          # User programs + allocator integrated
└── .github/
    └── workflows/
        └── build.yml                  # CI workflow
```

The `Memory Management Project/` folder has a clean, standalone version of the allocator that you can read without getting lost in XV6's build system.

## Running It

XV6 runs on QEMU emulating RISC-V. Check MIT's XV6 documentation for build instructions, or grab the standalone allocator in `Memory Management Project/` and compile it with a regular C compiler to see it work.

## Tech Stack

- **C** — everything
- **RISC-V** — target architecture
- **QEMU** — for emulation
- **XV6** — base operating system

## More Details

For the full technical breakdown, architecture decisions, algorithm details, and the reasoning behind each choice, see [the design document](./Memory%20Management%20Project/memory_management_design.pdf).
