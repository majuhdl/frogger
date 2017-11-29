###############################################
#  Programa de exemplo para Poll do teclado   #
#  ISC Jun 2016				      #
#  Marcus Vinicius			      #
###############################################

.text
# Polling do teclado e echo na tela
	li $s0,0
CONTA:  addi $s0,$s0,1	# contador
	jal ECHO2       # Verifica teclado por uma tecla
	
	move $a0,$t2
	li $a1,10
	li $a2,10
	li $a3,0xFF07
	li $v0,111
	syscall
	j CONTA

### Espera por uma tecla
ECHO: 	la $t1,0xFF100000
LOOP: 	lw $t0,0($t1)			# Le bit de Controle Teclado
   	andi $t0,$t0,0x0001	
   	beq $t0,$zero,LOOP		#Espera por uma tecla   	
   	lw $t2,4($t1)  		# Tecla lida
	sw $t2,12($t1)  	# escreve no display
	jr $ra

### Apenas verifica se há tecla apertada
ECHO2:	la $t1,0xFF100000
	lw $t0,0($t1)
	andi $t0,$t0,0x0001		# Le bit de Controle Teclado
   	beq $t0,$zero,PULA   	   	# Se não há tecla pressionada PULA
  	lw $t2,4($t1)  		# Tecla lida
	sw $t2,12($t1)  	# escreve no display
PULA:	jr $ra
