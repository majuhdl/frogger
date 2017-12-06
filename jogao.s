# funcao leteclado utiliza registradores $t0 a $t2 para leitura do teclado, tecla do teclado inscrita em $a0
# guardar $s7 para salvar label de onde se encontra
.data
#files
MAPFILE:	.asciiz "abcd.bin"
CARFILE1:	.asciiz "car1.bin"
CARFILE2:	.asciiz "car2.bin"
CARFILE3:	.asciiz "car3.bin"
COBRAFILE:	.asciiz "cobra.bin"
FROGFILE:	.asciiz "frog.bin"
CROCFILE:	.asciiz "jacare.bin"
FLYFILE:	.asciiz "mosca.bin"
TRONCOGFILE:	.asciiz "troncomaior.bin"
TRONCOPFILE:	.asciiz "troncomenor.bin"
FROGCHEGADA:	.asciiz "sapochegada.bin"
FAIXAS:		.asciiz "faixas.bin"
TELAINICIO:	.asciiz "teladeinicio.bin"
TELAMENU:	.asciiz "menu.bin"
TELAFIM:	.asciiz "teladefim.bin"

#SIZE
MAPSIZE: 	.space 76800
CAR1SIZE: 	.space 720
CAR2SIZE: 	.space 396
CAR3SIZE: 	.space 396
SNAKESIZE:	.space 520
FROGSIZE: 	.space 340
CROCSIZE: 	.space 1440
FLYSIZE: 	.space 288
INITSIZE: 	.space 76800

#POSITION
MAPPOS: 	.word 0xFF000000
CAR1POS: 	.word 0xFF000000
CAR2POS: 	.word 0xFF000000
CAR3POS: 	.word 0xFF000000
SNAKEPOS:	.word 0xFF011F80
FROGPOS: 	.word 0xFF000000
CROCPOS: 	.word 0xFF000000
FLYPOS: 	.word 0xFF000000
INITPOS: 	.word 0xFF000000

.text
	j INICIO
GUARDA_RA:
	addi $s7, $ra, 4 	# guarda o endereço pc+4 em s7 para uso na funcao do teclado
	jr $ra
LETECLADO:			# funcionamento similar ao de chamamento de funcao, eh pulada na primeira execucao de abertura do programa
	jal ECHOTECLADO       	# Verifica teclado por uma tecla
	move $a0,$t2
	jr $s7			# faz programa voltar para onde estava
ECHOTECLADO:			# espera por uma tecla
 	la $t1,0xFF100000	# carrega endereco do teclado
LOOPTECLADO:
 	lw $t0,0($t1)		# Le bit de Controle Teclado
   	andi $t0,$t0,0x0001	
   	beq $t0,$zero,LOOPTECLADO	#Espera por uma tecla
   	lw $t2,4($t1)  		# Tecla lida
   	sw $t2,12($t1)  	# escreve no display
	jr $ra
INICIO:
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
ABERTURA:			# Abertura do jogo
	la $a0,TELAINICIO	# abertura
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
	la $a0,TELAMENU		# menu
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
	jal GUARDA_RA
	j LETECLADO
	move $t1, $a0
	addi $t2, $zero, 49	# código do numero 1 na tabela asc
	beq $t1, $t2, PRINTABULEIRO
	addi $t2, $zero, 50	# código do numero 2 na tabela asc
	beq $t1, $t2, FIM
	j MENU
PRINTABULEIRO:			# Abre cenario
	la $a0,MAPFILE		# Endereco da string do nome do arquivo
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
	la $a0,FAIXAS		# faixas
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
PRINTAOBJETOS:			# Abre o arquivo
	la $a0,CARFILE1		# carro1
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
	la $a0,CARFILE2		# carro2
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
	la $a0,CARFILE3		# carro3
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
	la $a0,FROGFILE		# frog
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
	la $a0,TRONCOGFILE	# troncoMaior
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
	la $a0,TRONCOPFILE	# troncoMenor
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
	la $s0, FROGPOS
	jal GUARDA_RA
	j LETECLADO
	move $t1, $a0
	addi $t2, $zero, 97	# código da letra a na tabela asc, esquerda
	beq $t1, $t2, FROGESQ
	addi $t2, $zero, 100	# código do letra d na tabela asc, direita
	beq $t1, $t2, FROGDIR
	addi $t2, $zero, 119	# código do letra w na tabela asc, cima
	beq $t1, $t2, FROGCIMA
	addi $t2, $zero, 115	# código do letra s na tabela asc, baixo
	beq $t1, $t2, FROGBAIXO
	j JOGO
FROGESQ:
	add $s0, $s0, -20
	sw $s0, FROGPOS
	j PRINTAOBJETOS
FROGDIR:
	add $s0, $s0, 20
	sw $s0, FROGPOS
	j PRINTAOBJETOS
FROGCIMA:
	add $s0, $s0, -3200
	sw $s0, FROGPOS	
	j PRINTAOBJETOS
FROGBAIXO:
	add $s0, $s0, 3200
	sw $s0, FROGPOS
	j PRINTAOBJETOS
FIM:
# Abre o arquivo
	la $a0,TELAFIM		# encerramento
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
