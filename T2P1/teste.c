/*
 * Descricao: 	exemplo de programa escrito em C que chama uma 
 *		funcão definida em linguagem de montagem.
 * Author:	Divino César
 * Data:	08 de maio de 2013
 *
 */
#include <stdio.h>

extern int my_strlen(char *str);

int main(int argc, char *argv[]) {

	int len = my_strlen(argv[1]);

	printf("my_strlen(%s) = %d\n", argv[1], len);

	return 0;	
}
