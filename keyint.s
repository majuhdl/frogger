####################################################
#  Programa de exemplo de interrupçao do teclado   #
#  ISC Jun 2016				           #
#  Marcus Vinicius			           #
####################################################

.eqv KEY_BUFFER 0x900007a4
.text
# Leitura do teclado e echo na tela
	la $t1,0xFF100000
	li $t0,2
	sw $t0,0($t1)   # Habilita interrupção do teclado

	li $s0,0
CONTA:	addi $s0,$s0,1		# contador
	la $t0,KEY_BUFFER
	lw $a0,0($t0)
	addi $a0,$a0,48
	li $a1,64	# coluna
	li $a2,52	#linha
	li $a3,0x3807	# cores de frente(07) e fundo(38) do caracter ASCII do teclado
	li $v0,101 	# print int
	syscall
	
 	j CONTA
	


#.ktext  está no SYSTEMv53.s usar com o Custom6
#ECHO: 	la $t1,0xFF100000
#   	lw $t2,4($t1)  # Tecla lida
#	sw $t2,12($t1)
#	eret

