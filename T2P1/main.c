#include <stdio.h> 
#include <stdlib.h>

extern int 	my_ahtoi(char *str);
extern int 	my_atoi(char *str);
extern void my_itoa(int v, char *str);
extern void my_itoah(int v, char *str);
extern int 	my_strcmp(char *str1, char *str2);
extern int 	my_strlen(char *str);

int main() {
	int cmd_id, res;
	char str1[50];
	char str2[50];

	while (1) {
		printf("0) exit\n");
		printf("1) ahtoi\n");
		printf("2) atoi\n");
		printf("3) itoa\n");
		printf("4) itoah\n");
		printf("5) strcmp\n");
		printf("6) strlen\n");
		printf("Which function? ");
		scanf("%d", &cmd_id);
	
		switch (cmd_id) {
			case 0:
				return;
			case 1:
				scanf("%s", str1);
				res = my_ahtoi(str1);
				printf("%d\n", res);
				break;
			case 2:
				scanf("%s", str1);
				res = my_atoi(str1);
				printf("%d\n", res);
				break;
			case 3:
				scanf("%d", &res);
				my_itoa(res, str1);
				printf("%s\n", str1);
				break;
			case 4:
				scanf("%d", &res);
				my_itoah(res, str1);
				printf("%s\n", str1);
				break;
			case 5:
				scanf("%s", str1);
				scanf("%s", str2);
				res = my_strcmp(str1, str2);
				printf("%d\n", res);
				break;
			case 6:
				scanf("%s", str1);
				res = my_strlen(str1);
				printf("%d\n", res);
		}

		printf("\n\n\n\n\n");
	}

	return 0;
}

