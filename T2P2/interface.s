@ Descricao:    Implementa a função get_cmd, que lê a entrada padrão e
@               retorna o código do comando lido e o valor de seus parâmentros
@ Author:       André Lannoy Tavares
@ Data:         18 de maio de 2013
@


        @ ###### get_cmd ######


.globl get_cmd @<------

.text
@ Implementação da função get_cmd
@ Parametros:
@       - Endereço da memória no qual deve ser escrito o valor do primeiro parâmetro lido.
@       - Endereço da memória no qual deve ser escrito o valor do segundo parâmetro lido.
@ Saída:
@       - Código do comando lido: 0 (exit), 1 (si), 2 (sn), 3 (c), 4 (stw),
@         5 (p), 6 (regs), 7 (comando não reconhecido), 8 (fim do arquivo)

get_cmd:
        push {lr}

	@ Seta os argumentos da syscall read
	@ Chama a syscall read para ler a entrada pradão



	pop {pc}


        @ ###### Identifica o comando ######


.globl id_cmd @<------

.data

cod_exit:	.asciz		"exit"
cod_si:		.asciz		"si"
cod_sm:		.asciz		"sm"
cod_c:		.asciz		"c"
cod_stw:	.asciz		"stw"
cod_p:		.asciz		"p"
cod_regs:	.asciz		"regs"

.text
@ Identifica um comando recebido como parâmetro e retorna seu código
@ Parametros:
@       - Endereço da memória a partir do qual estão armazenados os caracteres de uma string.
@       - Tamanho da string.
@ Saída:
@       - Código do comando apontado pelo endereço: 0 (exit), 1 (si), 2 (sn), 3 (c), 4 (stw),
@         5 (p), 6 (regs), 7 (comando não reconhecido), 8 (fim do arquivo)

id_cmd:
	push {lr}

	@ lexograficamente, c < exit < p < regs < si < sn < stw. Utilizaremos essa ordem para realizar uma busca binária.

	b id_cmd_regs				@ Pulamos para a string "do meio"

id_cmd_c:
	ldr r1, =cod_c
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bne id_cmd_nr				@ se a string recebida for lexograficamente diferente de "c", ela não é um dos 7 comandos
	ldr r0, #3				@ c = retornar 3	
	pop {pc}

id_cmd_exit:
	ldr r1, =cod_exit
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bmi id_cmd_c				@ se a string recebida for lexograficamente menor que "exit", testamos "c"
	bgt id_cmd_p				@ se a string recebida for lexograficamente maior que "exit", testamos "p"
	ldr r0, #0				@ exit = retornar 0	
	pop {pc}

id_cmd_p:
	ldr r1, =cod_p
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bne id_cmd_nr				@ se a string recebida for lexograficamente diferente de "p", ela não é um dos 7 comandos
	ldr r0, #5				@ p = retornar 5	
	pop {pc}

id_cmd_regs:
	ldr r1, =cod_regs
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bmi id_cmd_exit				@ se a string recebida for lexograficamente menor que "regs", testamos "exit"
	bgt id_cmd_sn				@ se a string recebida for lexograficamente maior que "regs", testamos "sn"
	ldr r0, #6				@ regs = retornar 6	
	pop {pc}

id_cmd_si:
	ldr r1, =cod_si
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bne id_cmd_nr				@ se a string recebida for lexograficamente diferente de "si", ela não é um dos 7 comandos
	ldr r0, #1				@ si = retornar 1	
	pop {pc}

id_cmd_sn:
	ldr r1, =cod_sn
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bmi id_cmd_si				@ se a string recebida for lexograficamente menor que "sn", testamos "si"
	bgt id_cmd_stw				@ se a string recebida for lexograficamente maior que "sn", testamos "stw"
	ldr r0, #2				@ sn = retornar 2	
	pop {pc}
	
id_cmd_stw:
	ldr r1, =cod_stw
	push {r0}
	bl my_strcmp
	cmp r0, #0				@ testamos se o resultado de str_cmp foi -1, 0 e 1 antes de recuperarmos o primeiro parâmetro (r0)
	pop {r0}
	bne id_cmd_nr				@ se a string recebida for lexograficamente diferente de "stw", ela não é um dos 7 comandos
	ldr r0, #4				@ stw = retornar 4	
	pop {pc}

id_cmd_nr:
	ldr r0, #7				@ não reconhecido = retornar 7	
	pop {pc}

.globl my_strcmp

.text
@ Implementação da função strcmp
@ Parametros:
@	- Endereço de memória de uma cadeia de caracteres terminada em \0 (em r0)
@	- Endereço de memória de uma cadeia de caracteres terminada em \0 (em r1)
@ Saída:
@ 	- 0 se as cadeias forem iguais, -1 se a primeira for for lexicograficamente menor, 1 se a segunda for lexograficamente menor

my_strcmp:
	push {lr}

comp_loop:						@ faça
	ldrb r2, [r0], #1				@ carrega o próximo caracter da primeira string, atualiza o apontador
	ldrb r3, [r1], #1				@ carrega o próximo caracter da segunda string, atualiza o apontador
	cmp r2, r3
	bne comp					@ sai do loop se str1 não for igual a str2
	cmp r2, #0					@ se r2 == r3 == 0 == '\0', chegamos ao fim, e as strings são iguais
	bne comp_loop					@ se não, repete o loop
	mov r0, #0
	pop {pc}

comp:
	cmp r2, r3					
	bcs comp_1					@ se r2 > r3m retorna 1
	mov r0, #-1 					@ se não, retorna -1
	pop {pc}	

comp_1:
	mov r0, #1
	pop {pc}
