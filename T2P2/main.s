@ Descricao:    Função Principal que roda o simulador de arquitetura IAS
@ Author:       André Lannoy Tavares
@ Data:         18 de maio de 2013
@

.globl main

.data

.text

main:

	push {lr}

	@ cmd_id =get_cmd

	@ switch (cmd_id)

	mov r0, #0
	pop {pc}
