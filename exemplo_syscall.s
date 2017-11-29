###############################################
#  Programa de exemplo para bitmap display com syscall   #
# Versão Polling				#
#  ISC Jun 2016				      #
#  Marcus Vinicius			      #
###############################################
.data 
FILE: .asciiz "display.bin"
STR: .asciiz "Placar do sapo:"

.text
# Usar com o Bitmap Display e Keyboard and Display MMIO conectados

# Abre o arquivo
	la $a0,FILE
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
##### Incluir no Settings/Exception Handler o arquivo SYSTEMv54.s

	la $a0,STR   #Endereco da STR
	li $a1,0	# coluna
	li $a2,0	#linha
	li $a3,0xFF00	# cores de frente(00) e fundo(FF) do texto
	li $v0,104	# print string		
	syscall

MAINLOOP: jal KEYBOARD       # Verifica teclado por uma tecla

	  move $a0,$t2	# imprime o código ascii da tecla como placar
	  li $a1,152	# coluna
	  li $a2,0	#linha
	  li $a3,0xFF00	# cores de frente(00) e fundo(FF) do texto
	  li $v0,101	# print int	
	  syscall	  
	  j MAINLOOP

FIM:	li $v0,10
	syscall

KEYBOARD: la $t1,0xFF100000
	lw $t0,0($t1)
	andi $t0,$t0,0x0001		# Le bit de Controle Teclado
   	beq $t0,$zero,PULA   	   	# Se não há tecla pressionada PULA
  	lw $t2,4($t1)  		# Tecla lida
#	sw $t2,12($t1)  	# escreve no display de texto
	
	move $a0,$t2	# código ascii da tecla lida
	li $a1,220	# coluna
	li $a2,100	#linha
	li $a3,0x3807	# cores de frente(07) e fundo(38) do caracter ASCII do teclado
	li $v0,111	# print char
	syscall 
	
PULA:	jr $ra

