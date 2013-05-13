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


	@ ###### Divisão ######


.text
@ Cálcula a divisão de r0 por r1. Retorna o resultado em r0, e o resto em r1
@ Parametros:
@ 	- Número inteiro de 32 bits (dividendo)
@ 	- Número inteiro de 32 bits (divisor)
@ Saída:
@	- Número inteiro de 32 bits (quociente)
@	- Número inteiro de 32 bits (sobra)

my_div:
	push {lr}
	@ FUNCTION HERE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	pop {pc}


	@ ###### Valor Absoluto -> Complemento de Dois ######


.text
@ Cálculo do Complemento de dois de um número absoluto
@ Parametros:
@ 	- Número inteiro de 32 bits
@ Saída:
@	- Número inteiro de 32 bits (convertido)

para_comp_dois:
	push {lr}
	mvn r0, r0
	add r0, r0, #1		@<<<<<<
	pop {pc}

	@ ###### Complemento de Dois -> Valor Absoluto ######


.text
@ Cálculo de um valor absoluto a partir de um número em Complemento de dois
@ Parametros:
@ 	- Número inteiro de 32 bits
@ Saída:
@	- Número inteiro de 32 bits (convertido)

de_comp_dois:
	push {lr}
	sub r0, r0, #1		@<<<<<<
	mvn r0, r0
	pop {pc}	


	@ ###### Valor ASCII -> Valor Numérico ######


.text
@ Cálculo de um valor numérico a partir de um caracter ASCII
@ Parametros:
@ 	- Número inteiro de 32 bits (Valor ASCII)
@ Saída:
@	- Número inteiro de 32 bits

my_ctoi:
	push {lr}

	mov r1, #0x61	
	cmp r0, r1
	bcc ctoi_not_a 					@ se r0 igual a ou maior que 'a'	
	sub r0, r0, #0x57				@ subtrai um valor tal que 'a'->10, 'b'->11 e assim por diante
	pop {pc}

ctoi_not_a:
	mov r1, #0x41
	cmp r0, r1
	bcc ctoi_not_A					@ se r0 igual a ou maior que 'A'
	sub r0, r0, #0x37				@ subtrai um valor tal que 'A'->10, 'B'->11 e assim por diante
	pop {pc}	

ctoi_not_A:						@ se o caracter em r0 é válido e é menor que 'A', está entre 0 e 9 
	sub r0, r0, #0x30				@ subtraimos um valor tal que '0'->0, '1'->1 e assim por diante
	pop {pc}


	@ ###### Valor Numérico -> Valor ASCII ######


.text
@ Cálculo de um caracter ASCII partir de um valor numérico 
@ Parametros:
@ 	- Número inteiro de 32 bits 
@ Saída:
@	- Número inteiro de 32 bits (Valor ASCII)

my_itoc:
	push {lr}

	mov r1, #0x09	
	cmp r0, r1
	bcc ctoi_not_a 					@ se r0 igual a ou maior que 10->'A'	
	add r0, r0, #0x57				@ adicionamos um valor tal que 10->'A', 11->'B' e assim por diante
	pop {pc}

itoc_not_a:
	add r0, r0, #0x30				@ adicionamos um valor tal que '0'<-0, '1'<-1 e assim por diante
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
	push {r4, r5}		@<<<<<<			@ constante da base numérica (16) e flag de negativos 
	mov r4, #0x10
	mov r5, #0

	ldr r1, [r0]
	mov r2, #0x2D		@<<<<<<			@ r2 recebe o valor de '-' na tabela ASCII
	cmp r1, r2
	bne ahtoi_count					@ se o primeiro digito for um número, começa o cálculo 
	add r0, r0, #4		@<<<<<<			@ calcula o próximo endereço
	ldr r1, [r0]					@ r1 recebe o próximo digito
	push {r0, r2, r3}
	mov r0, r1
	bl my_ctoi					@ converte o valor ASCII de r1 para o valor numérico
	mov r1, r0
	pop {r0, r2, r3}
	mov r5, #1					@ marca que o número é negativo

ahtoi_count:
	@ mov r2, #0					@ r2 recebe o valor de '\0'
	mov r3, #0					@ inicializa o acumulador

ahtoi_loop:						@ faça
	mul r2, r3, r4					@ multiplica o valor acumulado pela base (16)
	add r3, r2, r1					@ soma o valor recem lido
	add r0, r0, #4		@<<<<<<			@ calcula o novo endereço
	ldr r1, [r0]					@ r1 recebe o próximo digito
	cmp r1, #0
	push {r0, r2, r3}
	mov r0, r1
	bl my_ctoi					@ converte o valor ASCII de r1 para o valor numérico
	mov r1, r0
	pop {r0, r2, r3}
	beq comp_loop					@ enquanto str for diferente de '\0'
	mov r3, r0		@<<<<<<			@ posiciona o resultado no registrador correto

	cmp r5, #0
	beq ahtoi_end
	bl para_comp_dois				@ calcula o complemtento de dois do valor acumulado (transforma em negativo)
	
ahtoi_end:
	pop {r4, r5}		@<<<<<<
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
	
	mov r2, #0x10					@ r2 recebe o valor da base (16)
	@testar caso em que r0 < 16
	mov r3, #0x1					@ Inicializa o contador
itoah_in_loop:
	mov r4, r3
	mul r3, r2, r4					@ r3 recebe a próxima potencia de r2
	cmp r3, r0
	bcc itoah_in_loop				@ enquanto r3 for menor que o número recebido

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

	@ empilhamos os registradores >= r4

	@ testamos o primeiro bit para saber se o número e negativo
	@ se for, calculamos a volta do complemento de dois
	@ setamos a flag de negativos

	@ pot = 1
	@ criamos um apontador para o local de pot na pilha	
	@ enquanto pot for menor que número da entrada
		@ colocamos pot na pilha
		@ atualizamos o apontador da pilha
		@ pot = pot * base

	@ enquanto o número da entrada for diferente que zero
		@ desempilhamos a próxima potência
		@ zeramos o contador de unidades
		@ enquanto o número da entrada for maior que ou igual à potência
			@ subtraimos a potência da entrada
			@ aumentamos o contador de unidades
		@ adionamos o contador de unidades à pilha
		@ aumentamos o contador de dígitos da string
	
	@ se a flag dos negativos estiver setada
		@ escreve '-' no primeiro digito
		@ aponta para o próximo digito

	@ enquanto não voltamos o stack pointer para sua posição original
		@ desempilha um digito
		@ guarda o digito no apontador atual
		@ aponta para o próximo dígito

	@ insere o '\0' no digito atual 

	@ desempilhamos os registradores >= r4
  
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
	ldr r3, [r0]
	cmp r3, r2					@ se str1 for igual a '\0'
	beq comp					@ pula para comp			
	ldr r3, [r1]	
	cmp r3, r2					@ se str2 for igual a '\0'
	beq comp					@ pula para comp
	add r0, r0, #4	 @checar #4			@ str1 recebe o próximo endereço após str1
	add r1, r1, #4	 @checar #4			@ str2 recebe o próximo endereço após str2 
	ldr r2, [r0]
	ldr r3, [r1]
	cmp r2, r3
	beq comp_loop					@ enquanto str1 for igual a str2

comp:
	ldr r2, [r0]
	ldr r3, [r1]
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

