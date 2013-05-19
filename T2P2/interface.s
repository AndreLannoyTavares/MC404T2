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

	pop {pc}
