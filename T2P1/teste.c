/* cricao: 	exemplo de programa escrito em C que chama uma 
 *		funcão definida em linguagem de montagem.
 * Author:	Divino César
 * Data:	08 de maio de 2013
 *
 */
#include <stdio.h>

extern char* my_itoa(int num);

int main(int argc, char *argv[]) {

	char* res = my_itoa((int) argv[1]);

	printf("my_itoa(%d) = %s\n", (int) argv[1], res);

	return 0;	
}
