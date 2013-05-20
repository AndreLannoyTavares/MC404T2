@ Descricao:    Função Principal que roda o simulador de arquitetura IAS
@ Author:       André Lannoy Tavares
@ Data:         18 de maio de 2013
@

.globl main

.data

.text

main:

	push {lr}

	bl get_cmd 				@ lê uma linha da entrada e guarda o código da operação em r0

	cmp r0, #0
	bne main_test_1
	mov r0, #0
	pop {pc} 						@ Encerra execução ao ler o comando "exit"
		
main_test_1:
	cmp r0, #1
	bne main_test_2
	@ do stuff code 1
	
main_test_2:	
	cmp r0, #2
	bne main_test_3
	@ do stuff code 2
	
main_test_3:	
	cmp r0, #3
	bne main_test_4
	@ do stuff code 3
	
main_test_4:	
	cmp r0, #4
	bne main_test_5
	@ do stuff code 4
	
main_test_5:	
	cmp r0, #5
	bne main_test_6
	@ do stuff code 5
		
main_test_6:
	cmp r0, #6
	bne main_test_7
	@ do stuff code 6
	
main_test_7:	
	cmp r0, #7
	bne main_test_8
	mov r0, #0
	pop {pc} 						@ Encerra execução ao ler um comando não identificado
	
main_test_8:	
	cmp r0, #8
	@ do stuff code 0
		

	@ switch (cmd_id)

	mov r0, #0
	pop {pc}
