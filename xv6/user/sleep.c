#include "../kernel/types.h"
#include "user.h"

int main(int argc, char *argv[])
{
	if (argc==1){
		printf("Did you forget the argument?\n");
	}
	else if (argc>2){
		printf("Please only pass one value.\n");
	}

	int seconds = atoi(argv[1]);
	sleep(seconds);
	exit (0);
}
