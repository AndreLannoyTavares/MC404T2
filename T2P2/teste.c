
#include <stdio.h>

extern int my_itoa(int num);

int main(int argc, char *argv[]) {

	int res = id_cmd((char*) argv[1]);

	printf("id_cmd(%s) = %d\n", (char*) argv[1], res);

	return 0;	
}
