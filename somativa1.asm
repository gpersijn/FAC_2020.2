.data 
	
	quebralinha: .asciiz "\n"
	ADD: .asciiz "ADD: "
	SUB: .asciiz "SUB: "
	AND: .asciiz "AND: "
	OR: .asciiz "OR: "
	XOR: .asciiz "XOR: "
	MASK: .asciiz "MASK: "
	SLL: .asciiz "SLL("
	SLL2: .asciiz "): "
	SRL: .asciiz "SRL("
	SRL2: .asciiz "): "
	
.text

main:
	# Ler valor 1 em s1
	li $v0, 5
	syscall
	move $s1, $v0
	
	# Ler valor 2 em s2
	li $v0, 5
	syscall
	move $s2, $v0
	
	# Ler valor 3 em s3
	li $v0, 5
	syscall
	move $s3, $v0
	
	add $t0, $s1, $s2 # Adição em t0
	sub $t1, $s1, $s2 # Subtração em t1
	and $t2, $s1, $s2 # And em t2
	or $t3, $s1, $s2 # Or em t3
	xor $t4, $s1, $s2 # Xor em t4
	
	and $t7, $s3, 31 # valor de m em t7
	
	sll $t5, $s1, 1 # SLR em t5
	srl $t6, $s2, 1 # SLR em t6
	
	#Laço while para o sll e srl
	addi $s0, $s0, 1
while:
	beq $s0, $t7, saida
	
	sll $t5, $t5, 1 # SLR em t5
	srl $t6, $t6, 1 # SLR em t6
	
	addi $s0, $s0, 1
	j while

	
saida: 	
print:
	# Printa a adição:
	la $a0, ADD
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
	# Printa a subtração:
	la $a0, SUB
	li $v0, 4
	syscall
	
	la $a0, ($t1)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
	# Printa o and:
	la $a0, AND
	li $v0, 4
	syscall
	
	la $a0, ($t2)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
	# Printa o OR
	la $a0, OR
	li $v0, 4
	syscall
	
	la $a0, ($t3)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
	# Printa o XOR
	la $a0, XOR
	li $v0, 4
	syscall
	
	la $a0, ($t4)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
       
       # Printa o MASK
       	la $a0, MASK
	li $v0, 4
	syscall
	
	la $a0, ($t7)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
	# Printa o SLL
        la $a0, SLL
	li $v0, 4
	syscall
	
	la $a0, ($t7)
	li $v0,1
        syscall
	
	la $a0, SLL2
	li $v0, 4
	syscall
	
	la $a0, ($t5)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
	
       # Printa o SLR
        la $a0, SRL
	li $v0, 4
	syscall
	
	la $a0, ($t7)
	li $v0,1
        syscall
	
	la $a0, SRL2
	li $v0, 4
	syscall
	
	la $a0, ($t6)
	li $v0,1
        syscall
        
        la $a0, quebralinha
	li $v0, 4
	syscall
      
       # Encerra
        li $v0, 10
	syscall
