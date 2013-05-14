/* cricao: 	exemplo de programa escrito em C que chama uma 
 *		funcão definida em linguagem de montagem.
 * Author:	Divino César
 * Data:	08 de maio de 2013
 *
 */
#include <stdio.h>

extern int my_atoi(char *str1);

int main(int argc, char *argv[]) {

	int res = my_atoi(argv[1]);

	printf("my_atoi(%s) = %d\n", argv[1], res);

	return 0;	
}
