#########################################################
#  Programa de exemplo de uso do Bitmap Display Tool   	#
#  ISC Out 2017	  			  		#
#  Marcus Vinicius Lamar		  		#
#########################################################
#
# Cuidar que o arquivo display.bin deve estar no mesmo diretório do Mars45_Custom7.jar
# Use o programa paint.net (baixar da internet) para gerar o arquivo .bmp de imagem 320x240 e 24 bits/pixel 
# para então usar o programa bmp2oac.exe para gerar o arquivo .bin correspondente

.data
FILE1: .asciiz "abcd.bin"
FILE2: .asciiz "car1.bin"
FILE3: .asciiz "car2.bin"
FILE4: .asciiz "car3.bin"
FILE5: .asciiz "cobra.bin"
FILE6: .asciiz "faixas.bin"
FILE7: .asciiz "frog.bin"
FILE8: .asciiz "jacare.bin"
FILE9: .asciiz "mosca.bin"
FILE10: .asciiz "sapochegada.bin"
FILE11: .asciiz "troncomaior.bin"
FILE12: .asciiz "troncomenor.bin"

.text

# Preenche a tela de vermelho
	la $t1,0xFF000000	# endereco inicial da Memoria VGA
	la $t2,0xFF012C00	# endereco final 
	la $t3,0x07070707	# cor vermelho|vermelho|vermelhor|vermelho
LOOP: 	beq $t1,$t2,FORA	# Se for o último endereço então sai do loop
	sw $t3,0($t1)		# escreve a word na memória VGA
	addi $t1,$t1,4		# soma 4 ao endereço
	j LOOP			# volta a verificar
FORA:

# Abre o arquivo
	la $a0,FILE1		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE2		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE3		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE4		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE5		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
# Abre o arquivo
	la $a0,FILE6		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE7		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE8		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE9		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE10		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE11		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
	la $a0,FILE12		# Endereço da string do nome do arquivo
	li $a1,0		# Leitura
	li $a2,0		# binário
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
FIM:	li $v0,10		# syscall de exit
	syscall
