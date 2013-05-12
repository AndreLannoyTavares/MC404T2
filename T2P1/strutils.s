@ Descricao: 	Conjunto de funcoes para manipulacão de vetores de caracteres
@		e conversão de bases.
@ Author:	André Lannoy Tavares
@ Data:		11 de maio de 2013
@
.globl my_strlen

.text
@ Implementacao da funcão strlen
@ Parametros:
@	- Ponteiro para uma cadeia de caracteres terminada em \0
@ Saída:
@	- Número de caracteres diferentes de \0 na cadeia de caracteres
@
my_strlen:
	push {lr}

	mov r2, r0
head:
	ldrb r1, [r0], #0x1
	cmp r1, #0x0
	bne head
	
	sub r0, r0, r2
	sub r0, r0, #0x1

	pop {pc}


	@ ###### Cadeia de Hexadecimais -> Inteiro ######


.globl my_ahtoi

.text
@ Implementação da função ahtoi
@ Parametros:
@ 	- Ponteiro para uma cadeia de caracteres com digitos hexadecimais terminada em \0
@ Saída:
@	- Número inteiro de 32 bits (conversão dos caracteres)

my_ahtoi:
	push {lr}

	pop {pc}


	@ ###### Cadeia de Decimais -> Inteiro ######


.globl my_atoi

.text
@ Implementação da função atoi
@ Parametros:
@ 	- Ponteiro para uma cadeia de caracteres com digitos decimais terminada em \0
@ Saída:
@	- Número inteiro de 32 bits (conversão dos caracteres)

my_atoi:
	push {lr}

	pop {pc}


	@ ###### Inteiro -> Cadeia de Hexadecimais ######


.globl my_itoah

.text
@ Implementação da função itoah
@ Parametros:
@ 	- Número inteiro
@	- Endereço de memória a partir do qual uma cadeia de caracteres hexadecimais terminada em \0 deve ser escrita

my_itoah:
	push {lr}

	pop {pc}


	@ ###### Inteiro -> Cadeia de Decimais ######


.globl my_itoa

.text
@ Implementação da função itoa
@ Parametros:
@ 	- Número inteiro
@	- Endereço de memória a partir do qual uma cadeia de caracteres decimais terminada em \0 deve ser escrita

my_itoa:
	push {lr}

	pop {pc}


	@ ###### Comparação de Duas Cadeias ######


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
	mov r2, #0					@ guardamos em r2 o código ASCII de '\0'
	mov r3, [r0]
	cmp r3, r2					@ se str1 for igual a '\0'
	beq comp					@ pula para comp			
	mov r3, [r1]	
	cmp r3, r2					@ se str2 for igual a '\0'
	beq comp					@ pula para comp
	add r0, r0, #4	 @checar #4			@ str1 recebe o próximo endereço após str1
	add r1, r1, #4	 @checar #4			@ str2 recebe o próximo endereço após str2 
	mov r2, [r0]
	mov r3, [r1]
	cmp r2, r3
	beq comp_loop					@ enquanto str1 for igual a str2

comp:
	mov r2, [r0]
	mov r3, [r1]
	cmp r2, r3					@ se str1 - str2 = 0
	beq comp_0					@ então retorna 0
	cmp r2, r3					@ se não se str1 - str2 > 0
	beq comp_1					@ então retorna 1
	mov r0, #2 	@checar código do -1		@ se não retorna -1
	pop {pc}	

comp_0:
	mov r0, #0
	pop {pc}

comp_1:
	mov r0, #1
	pop {pc}

