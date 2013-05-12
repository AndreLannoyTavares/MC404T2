strutils.o:	
	as -v strutils.s -o strutils.o 

teste.o:
	gcc -v -c teste.c -o teste.o 

teste: 
	gcc -v teste.o strutils.o -g -o teste
	
teste.x:	
	gcc teste.o strutils.o -o teste.x
