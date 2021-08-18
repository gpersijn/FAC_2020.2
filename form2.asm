multfac:
	add $s4, $zero, $a1 
	add $s1, $zero, $zero 
	add $t0, $zero, $zero
	add $s5, $zero, $zero 
	addi $t1, $zero, 32
	
again:	
	andi $t3, $s4, 1
	bne $t3, $s5, confirma 
	j esquerda

confirma:
	beq $s5, 1, soma 	
	sub $s1, $s1, $a0  
	j esquerda
	
soma:
	add $s1, $s1, $a0
		
esquerda:
	move $s5, $t3
	andi $t4, $s1, 1 
	sra $s1, $s1, 1 
	srl $s4, $s4, 1 
	sll $t4, $t4, 31 
	add $s4, $s4, $t4 
			 
	addi $t0, $t0, 1
	bne $t0, $t1, again
		
	mthi $s1 
	mtlo $s4 
	jr $ra 
