.data
	Quebra: .asciiz "\n"
	string1: .space 2000
	string2: .space 2000

.text
.globl main

main:

    # get size at s1
    li $v0, 5
    syscall
    move $s1, $v0

    # get string 1
    li $v0, 8
    la $a0, string1
    li $a1, 2000
    syscall
 
    # get string 2
    li $v0, 8
    la $a0, string2
    li $a1, 2000
    syscall

    # compare each bit
    la $t1, string1
    la $t2, string2
    
    # start the var S5 = 0
    move $s4, $zero

    loop:
    
    # stop the loop after run X times
        beq $s1, $s5, end_loop
        
    # load the characters 
        lb $t3, 0($t1)
        lb $t4, 0($t2)
        
    # check if equal, if not continue loop, if equal then sum 1 and continue
        sub $t6, $t3, $t4
	 
        beq $t6, $zero, some_um
        j continue

    continue:
    # continue again, by incrementing both address by one
        addi $t1, $t1, 1
        addi $t2, $t2, 1
        addi $s5, $s5, 1
        j loop
	
    some_um:
        addi $s4, $s4, 1
    	addi $t1, $t1, 1
        addi $t2, $t2, 1
        addi $s5, $s5, 1
        j loop
    			
    end_loop:
	
 	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 4
	la $a0, Quebra
	syscall
	
	li $v0, 10
    	syscall

