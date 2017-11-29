###############################################
#  Programa de exemplo para Syscall MIDI      #
#  ISC Out 2017				      #
#  Marcus Vinicius Lamar		      #
###############################################

.data
# Numero de Notas
NUM: .word 13,
# lista de nota,duração,...
NOTAS: 69,500,76,500,74,500,76,500,79,600, 76,1000,0,1200,69,500,76,500,74,500,76,500,81,600,76,1000

.text
	la $s0,NUM
	lw $s1,0($s0)
	la $s0,NOTAS
	li $t0,0
	li $a2,68	# instrumento
	li $a3,25	# volume

LOOP:	beq $t0,$s1, FIM
	lw $a0,0($s0)		# nota
	lw $a1,4($s0)		# duracao
	li $v0,31		# 33 da pausa a mais
	syscall
	move $a0,$a1		#pausa = duracao
	li $v0,32
	syscall
	addi $s0,$s0,8
	addi $t0,$t0,1
	j LOOP
	
FIM:	li $a0,40
	li $a1,1500
	li $a2,127
	li $a3,127
	li $v0,33
	syscall
	li $v0,10
	syscall

