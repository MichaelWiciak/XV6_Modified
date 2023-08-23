// Hi Test here
#include "memory_management.h"


int main(int argc, char *argv[]){
    // Test 1 to check free reallocation and adding again to the end
    // int counter=1;
    // void *ptr;
    // void *optr=0;
    // while (counter<=argc-1){
    //     ptr = _malloc(atoi(argv[counter]));

    //     if (counter==1){
    //         optr=ptr;
    //     }
    //     counter+=1;
    // }
    // _free(optr);
    // ptr = _malloc(10);
    // _free(ptr);
    // ptr = _malloc(50);

    // // Test 2, check if adjacent free blocks get merged
    // void *ptr1;
    // void *ptr2;
    // void *ptr3;
    // void *ptr4;
    // void *ptr5;
    // ptr1 = _malloc(1000);
    // ptr2 = _malloc(300);
    // ptr3 = _malloc(300);
    // ptr4 = _malloc(300);
    // ptr5 = _malloc(1000);
    // ptr5 = _malloc(1);
    // _free(ptr2);
    // _free(ptr4);
    // _free(ptr3);
    // _free(ptr5);
    
    //Test 3, check if split works but doesn't
    // void *ptr1;
    // void *ptr2;
    // void *ptr3;
    // ptr1 = _malloc(100);
    // ptr2 = _malloc(200);
    // _free(ptr2);
    // ptr3 = _malloc(50);
    // ptr3 = _malloc(200);
    // _free(ptr3);

    // Test 4, check free on empty
    // void *ptr1;
    // void *ptr2;
    // void *ptr3=1;
    // ptr1 = _malloc(100);
    // ptr2 = _malloc(200);
    // _free(ptr1+1);

    // Test of malloc on variable
    // int* ptr1;
    // // We want ptr1 to store the space of 3 integers
    // ptr1 = (int*) _malloc (3 * sizeof(int));

    // if(ptr1==NULL){
    //   printf("Memory not allocated. \n");
    // }
    // else{printf("Memory allocated succesfully. \n");
    // // This statement shows where memory is allocated
    // printf("The address of the pointer is:%u\n ", ptr1);
    
    // // Here we assign values to the ptr1 created
    // for(int i=0;i<3;i++){
    //   ptr1[i] = i;
    // }
    // // Printing the vlaues of ptr1 to show memory allocation is done
    // for(int i=0;i<3;i++){
    //   printf("%d\n", ptr1[i]);
    // }
    // _free(ptr1);
    //}
    

    return 0;


}
