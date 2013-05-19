p2:
	as interface.s -g -o interface.o
	as ias_state.s -g -o ias_state.o
	as main.s -g -o main.o
	gcc main.o interface.o ias_state.o -g -o p2 

p1:
	as strutils.s -g -o strutils.o
	gcc main.c -g -c 
	gcc main.o strutils.o -g -o p1

