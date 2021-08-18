
multfac:
	add $s1, $zero, $zero 
	add $s2, $zero, $a1
	add $s4, $zero, $zero 
	add $t0, $zero, $zero
	addi $t1, $zero, 32
	
confirma:
	beq $s4, 1, adicionar 
	sub $s1, $s1, $a0  
	j direciona
	
roda_dnv:
	andi $t3, $s2, 1
	bne $t3, $s4, confirma
	j direciona
	
adicionar:	
	add $s1, $s1, $a0
		
direciona:	
	move $s4, $t3 
	andi $t4, $s1, 1 
	sra $s1, $s1, 1
	srl $s2, $s2, 1 
	sll $t4, $t4, 31 
	add $s2, $s2, $t4 
	addi $t0, $t0, 1  
	bne $t0, $t1, roda_dnv
	mthi $s1 
	mtlo $s2 
