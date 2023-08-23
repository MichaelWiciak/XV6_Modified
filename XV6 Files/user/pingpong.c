#include "../kernel/types.h"
#include "user.h"

int main (int argc, char *argv[]){
        
	int p[2];
	pipe(p);
	
	exit (0);
}

