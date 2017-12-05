# funcao leteclado utiliza registradores $t0 a $t2 para leitura do teclado, tecla do teclado inscrita em $a0
# guardar $s7 para salvar label de onde se encontra
.data
FILE1:	.asciiz "abcd.bin"
FILE2:	.asciiz "car1.bin"
FILE3:	.asciiz "car2.bin"
FILE4:	.asciiz "car3.bin"
FILE5:	.asciiz "cobra.bin"
FILE6:	.asciiz "faixas.bin"
FILE7:	.asciiz "frog.bin"
FILE8:	.asciiz "jacare.bin"
FILE9:	.asciiz "mosca.bin"
FILE10:	.asciiz "sapochegada.bin"
FILE11:	.asciiz "troncomaior.bin"
FILE12:	.asciiz "troncomenor.bin"
FILE13:	.asciiz "teladeinicio.bin"
FILE14:	.asciiz "menu.bin"
FILE15:	.asciiz "teladefim.bin"

.text
# Preenche a tela de vermelho
	la $t1,0xFF000000	# endereco inicial da Memoria VGA
	la $t2,0xFF012C00	# endereco final 
	la $t3,0x07070707	# cor vermelho|vermelho|vermelhor|vermelho
LOOP:
 	beq $t1,$t2,ABERTURA	# Se for o ultimo endereco entco sai do loop
	sw $t3,0($t1)		# escreve a word na memoria VGA
	addi $t1,$t1,4		# soma 4 ao endereco
	j LOOP			# fica no loop
	li $s0,0
LETECLADO:			# funcionamento similar ao de chamamento de funcao, eh pulada na primeira execucao de abertura do programa
	jal ECHOTECLADO       	# Verifica teclado por uma tecla
	move $a0,$t2
	add $ra, $s7, $zero	# altera o valor de $ra de forma que a funcao leteclado seja reaproveitavel
	jr $ra			# faz programa voltar para onde estava
ECHOTECLADO:			# espera por uma tecla
 	la $t1,0xFF100000	# carrega endereco do teclado
LOOPTECLADO:
 	lw $t0,0($t1)		# Le bit de Controle Teclado
   	andi $t0,$t0,0x0001	
   	beq $t0,$zero,LOOPTECLADO	#Espera por uma tecla
   	lw $t2,4($t1)  		# Tecla lida
	jr $ra
ABERTURA:			# Abertura do jogo
	la $a0,FILE13		# Endereco da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
PRINTAMENU:
	la $a0,FILE14		# menu
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
MENU:				# tela de selecao para o jogador
	addi $s7, pc, 4
	j LETECLADO
	move $t1, $a0
	addi $t2, $zero, 1
	beq $t1, $t2, PRINTABULEIRO
	addi $t2, $zero, 2
	beq $t1, $t2, FIM
	j MENU
PRINTABULEIRO:			# Abre cenario
	la $a0,FILE1		# Endereco da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE2		# carro1
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE3		# carro2
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE4		# carro3
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE5		# cobra
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE6		# faixas
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE7		# frog
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE8		# jacare
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE9		# mosca
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE10		# sapoChegada
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE11		# troncoMaior
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# Abre o arquivo
	la $a0,FILE12		# troncoMenor
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
JOGO:				# inicia leitura de teclado

FIM:
	# Abre o arquivo
	la $a0,FILE15		# encerramento
	li $a1,0		# Leitura
	li $a2,0		# binario
	li $v0,13		# syscall de open file
	syscall			# retorna em $v0 o descritor do arquivo
	move $t0,$v0		# salva o descritor em $t0
# Le o arquivos para a memoria VGA
	move $a0,$t0		# $a0 recebe o descritor
	la $a1,0xFF000000	# endereco de destino dos bytes lidos
	li $a2,76800		# quantidade de bytes
	li $v0,14		# syscall de read file
	syscall			# retorna em $v0 o numero de bytes lidos
#Fecha o arquivo
	move $a0,$t0		# $a0 recebe o descritor
	li $v0,16		# syscall de close file
	syscall			# retorna se foi tudo Ok
# devolve o controle ao sistema operacional
	li $v0,10		# syscall de exit
	syscall