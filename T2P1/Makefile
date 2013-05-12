strutils.o:	
	as strutils.s -o strutils.o 

teste.o:
	gcc -c teste.c -o teste.o 
	
teste.x:	
	gcc teste.o strutils.o -o teste.x

teste: 
	gcc teste.o strutils.o -g -o teste
