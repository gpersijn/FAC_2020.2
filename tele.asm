.data
	Quebra: .asciiz "\n"

.text
main:
	#Leitura do primeiro numero   C  -> T0
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Leitura do segundo numero    A -> T1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Conta
	sub $t2, $t0, 1    #  C-1 -> T2
	div $t1, $t2  #A/C-1
	mflo $t3 #quociente em t4
	mfhi $t4  # resto da divisao em t5
	
	move $t5, $t3   # resposta = quociente
	
	bgt $t4, $zero, resp
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, Quebra
	syscall
	
	li $v0, 10
	syscall
	
	resp:
		add $t5, $t5, 1
		
		li $v0, 1
		move $a0, $t5
		syscall
	
		li $v0, 4
		la $a0, Quebra
		syscall