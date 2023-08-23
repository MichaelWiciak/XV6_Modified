// NOTE: I have left some of the //printf statements commented out
// so if anyone wants to check how it works, please uncomment those 
// statements
#include "memory_management.h"
// Used for initialisation of the linked list structure
static LinkedListNode headOfLinkedList;
static LinkedListNode *headOfLinkedListPointer = NULL;

// Malloc implementaiton
void* _malloc(int size){
    // Check if the size provided is a non negative and non zero integer.
    if (size<=0){
        return NULL;
    }
    // In the first iteration, initialise the linked list structure
    if (headOfLinkedListPointer==NULL){
        //printf("Make header null");
        headOfLinkedList.size=0;
        headOfLinkedList.isThisNodeFree=false;
        headOfLinkedList.nextItemPointer = NULL;
        headOfLinkedListPointer = &headOfLinkedList;
    }
    //printf("\nAddresses should increment by %d\n", size + STRUCT_SIZE);
    //printf("Address of head of linked list %d\n", headOfLinkedListPointer);
    // Initialise variables necessary to traverse through the linked list
    LinkedListNode *previousNodePointer;
    LinkedListNode *currentNodePointer;
    previousNodePointer = headOfLinkedListPointer;
    currentNodePointer = headOfLinkedList.nextItemPointer;
    int exit=false; 
    // Iterate through the whole linked list until you find a available space
    // or you reached the end of the linked list
    while (currentNodePointer!=headOfLinkedListPointer && exit==false){
        // If the current pointer isn't pointing anywhere, we have reached the end of the linked list
        // So exit the loop
        if (currentNodePointer==NULL){
            exit=true;
        }
        // If we have available space in one of our already allocated nodes
        else if(currentNodePointer->isThisNodeFree==true){
            // And the size requirements match perfectly, return the pointer to that location
            if (currentNodePointer->size==size){
                //printf("Previous Node: %d %d\n", previousNodePointer->size, previousNodePointer);
                //printf("CurrentNode: %d %d\n", currentNodePointer->size, currentNodePointer);
                currentNodePointer->isThisNodeFree=false;
                //printf("Replaced the node here since its free\n");
                // Return the pointer + 1 because don't we want the user to 
                // overwrite the structure stored there
                return currentNodePointer+1;  
            }
            // The node available is too large for the data
            // but still allocate it here if the node will be split
            else if (currentNodePointer->size>size){
                // Node not big enough to be split and hold two separate nodes
                // so store the data here by returning a pointer to slighly larger chunk of memory
                if (currentNodePointer->size-STRUCT_SIZE-1<=size){
                    //printf("Put here even though it is too big slightly\nPrevious Node pointer %d \n Current Node Pointer %d\n", previousNodePointer, currentNodePointer);
                    currentNodePointer->isThisNodeFree=false;
                    //printf("Replaced the node here since its free\n");
                    return currentNodePointer+1;  
                }
                // The split could be implemented here.
                else{
                    //printf("Put here even though it is too big slightly\nPrevious Node pointer %d \n Current Node Pointer %d\n", previousNodePointer, currentNodePointer);
                    currentNodePointer->isThisNodeFree=false;
                    //printf("Replaced the node here since its free\n");
                    return currentNodePointer+1;  
                }
            }
            // This pointer doesn't have free space so go to next node
            else{
                //printf("Previous Node: %d %d\n", previousNodePointer->size, previousNodePointer);
                //printf("CurrentNode: %d %d\n", currentNodePointer->size, currentNodePointer);
                previousNodePointer=currentNodePointer;
                currentNodePointer = currentNodePointer->nextItemPointer;
        }
        }
        // This pointer doesn't have free space so go to next node
        else{
            //printf("Previous Node: %d %d\n", previousNodePointer->size, previousNodePointer);
            //printf("CurrentNode: %d %d\n", currentNodePointer->size, currentNodePointer);
            previousNodePointer=currentNodePointer;
            currentNodePointer = currentNodePointer->nextItemPointer;
        }
    }
    // If we still havent' returned the pointer, that means there is
    // no free space so have to expand the heap
    // Creating a new node 
    LinkedListNode *pointerToNewLinkedListNode;
    char *pointerToNewMemory = sbrk(0);
    // The new node need to have enough memory to store the required
    // data and the node structure
    char *newMemoryRequest = sbrk(size+STRUCT_SIZE);
    // Check if sbrk failed
    if (newMemoryRequest == (void *) -1 || newMemoryRequest==NULL) {
        return NULL;
    }
    // If it didn't fail, create the new node and assign to it defaul information
    pointerToNewLinkedListNode = (void *) pointerToNewMemory;
    pointerToNewLinkedListNode->size=size;
    pointerToNewLinkedListNode->nextItemPointer=NULL;
    pointerToNewLinkedListNode->isThisNodeFree=false;
    //printf("Created a new sbrk location of %d \n", pointerToNewLinkedListNode);
    // If the pointer to the head of linked list is empty, that means
    // this is the first valid malloc call so assign this node to the 
    // head linked list structure
    if (headOfLinkedList.nextItemPointer==NULL){
        headOfLinkedList.nextItemPointer =  pointerToNewLinkedListNode;
        //printf("Updated header %d\n",headOfLinkedListPointer);
    }
    // Else assign the pointer of this node to the previous node
    else{
        previousNodePointer->nextItemPointer = pointerToNewLinkedListNode;
        //printf("Updated the previous node pointer + struct size %d\n",previousNodePointer);
    }
    // Return the pointer + 1 because don't we want the user to 
    // overwrite the structure stored there
    return pointerToNewLinkedListNode+1;
}
// Free implementation
void _free(void *ptr){
    // Since we gave the user a address after the stored structure
    // we need to take that way from the pointer since our linked list
    // pointers stores the whole address accounting for structure size
    // Only attempt to free if the pointer provided is actually a pointer
    if (ptr!=NULL){
        //printf("\nTry to free %d\n", ptr);
        ptr=ptr-STRUCT_SIZE;
        // Initialise variables to be able to traverse the linked list
        LinkedListNode *previousNodePointer;
        LinkedListNode *currentNodePointer;
        previousNodePointer = headOfLinkedListPointer;
        currentNodePointer = headOfLinkedList.nextItemPointer;
        int exit=false;
        // Traverse the linked list, looking for that pointer
        // If it isn't found, exit doing nothing
        while (currentNodePointer!=headOfLinkedListPointer && exit==false){
            // Couldn't find this pointer in the linked list so exit the loop
            if (currentNodePointer==NULL||currentNodePointer==0 || previousNodePointer->nextItemPointer==NULL){
                //printf("This pointer does not exist\n\n");
                exit=true;
            }
            // If the provided pointer is found, make it free to be used by malloc in future iterations
            if(currentNodePointer==ptr && exit==false){
                //printf("Previous Node: %d %d %d\n", previousNodePointer->size, previousNodePointer, previousNodePointer->isThisNodeFree);
                //printf("CurrentNode: %d %d %d\n", currentNodePointer->size, currentNodePointer, currentNodePointer->isThisNodeFree);
                // For optimisation, attempt to merge adjacent free nodes together
                // If both the previous and next node are free, merge all three into 1 node
                if (previousNodePointer->isThisNodeFree==true && currentNodePointer->nextItemPointer!=NULL){
                    if (currentNodePointer->nextItemPointer->isThisNodeFree==true){
                        previousNodePointer->size += currentNodePointer->size + 2*STRUCT_SIZE + currentNodePointer->nextItemPointer->size;
                        previousNodePointer->nextItemPointer = currentNodePointer->nextItemPointer->nextItemPointer;
                        previousNodePointer->isThisNodeFree=true;
                    }
                    // The next node isn't free so only merge the previous one
                    else{
                        previousNodePointer->size += currentNodePointer->size + STRUCT_SIZE;
                        previousNodePointer->nextItemPointer = currentNodePointer->nextItemPointer;
                        previousNodePointer->isThisNodeFree=true;
                    }
                }
                // Only the previous node can be marged
                else if (previousNodePointer->isThisNodeFree==true){
                    previousNodePointer->size += currentNodePointer->size + STRUCT_SIZE;
                    previousNodePointer->nextItemPointer = currentNodePointer->nextItemPointer;
                    previousNodePointer->isThisNodeFree=true;
                }
                // Only the next node can be merged
                else if (currentNodePointer->nextItemPointer!=NULL){
                    if (currentNodePointer->nextItemPointer->isThisNodeFree==true){
                        currentNodePointer->size += currentNodePointer->nextItemPointer->size + STRUCT_SIZE;
                        currentNodePointer->nextItemPointer = currentNodePointer->nextItemPointer->nextItemPointer;
                        currentNodePointer->isThisNodeFree=true;
                        }
                    else{
                        currentNodePointer->isThisNodeFree=true;
                }
                }
                // Else non of the adjacent nodes be merged so 
                // just make the current one available for malloc for reuse
                else{
                    currentNodePointer->isThisNodeFree=true;
                }
                //printf("Just Freed: %d\n\n", currentNodePointer->size);
                // Since the pointer has been found, exit the loop
                exit=true;
            }
            // Go to next node
            else if (exit==false){
                //printf("Previous Node: %d %d %d\n", previousNodePointer->size, previousNodePointer, previousNodePointer->isThisNodeFree);
                //printf("CurrentNode: %d %d %d\n", currentNodePointer->size, currentNodePointer, currentNodePointer->isThisNodeFree);
                previousNodePointer=currentNodePointer;
                currentNodePointer = currentNodePointer->nextItemPointer;
            }
        }
    }
}

