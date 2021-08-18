.data
	destino: .space 100
	destinado: .space 100
	quebraLinhaVar: .word 0
	invalida: .asciiz "Entrada invalida.\n"
	string: .space 100
	chars: .byte '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','.','-',':','+','=','^','!','/','*','?','&','<','>','(',')','[',']','{','}','@','%','$','#'

.text
main:
	#Leitura da String
	li $v0, 8	
	la $t0, string
	li $a1, 100	
	addi $a0, $t0,0 
	addi $s1, $a0, 0		
	syscall

	li $t4, 0	#inicia registro a 0
	li $s2,10	#carrega em $s2 o valor decimal de '\n'
	 
	jal loop1
	add $t8, $t8, $t4
	add $t9, $t9, 4

	# t4 o tamanho da string
	lb $s3, quebraLinhaVar
	
	la  $s1, destino
	la  $s3, destinado
	jal repete
	jal exit
	
    
printar:

	lb $a0, destino($t9)
	li $v0, 11
	syscall
	
	beqz $t9, success
	subi $t9, $t9, 1
	j printar

divide:
	li $t7, 85
	div $s4, $t7		
	mfhi $t2    #resto
	mflo $t3    #quociente em s4
	
	blt $s4, $t7, quociente
	################################ Até aqui OK
	 
	#
	lb $s0, chars($t2)
	sb $s0,0($s1)             
	addi $s1,$s1,1 
	#
	
	move $s4, $t3 
	j divide


quociente:
	lb $s0, chars($t2)
	sb $s0,0($s1)             
	
	j success

repete:
	lb $s6, 0($s1) 
	andi $s4, $s6, 0xFF
	sll $s4, $s4, 8
	addi $s6, $zero, 0
	
	lb $s5, 1($s1)
	andi $t5, $s5, 0xFF
	add $s4, $s4, $t5
	sll $s4, $s4, 8
	
	addi $s1, $s1, 1
	subi $t8, $t8, 2
	
	j while
	

while:
	beq $a1, $a3, exit
	# s6 = s5
	addi $s5, $zero, 0
	lb $s7, 1($s1)
	andi $t5, $s7, 0xFF
	
	add $s4, $s4, $t5

	subi $t8, $t8, 1
	addi $s1, $s1, 1
	
	add $s0, $zero, 4
	div $t8, $s0
	mfhi $t0
	
	beqz $t0, succes
	sll $s4, $s4, 8
	
	j while

def:
	la  $s1, destino
	
	move $a2, $s4
	move $t0, $s1
	jal divide
	jal printar
	j exit
	move $s4, $a2
	move $s1, $t0
	
	sll $s4, $s4, 8
	add $a3, $a3, 1
	
	j while

succes:
	beq $a3, $zero, def
	move $a2, $s4
	move $t0, $s1
	
	jal divide
	jal printar
	
	move $s4, $a2
	move $s1, $t0
	la  $s1, destino
	
	sll $s4, $s4, 8
	add $a3, $a3, 1
	
	j while


loop1:
	lb $t1,0($t0)		#carrega o valor decimal guardado no endereço $t0
	beq $t1,$s2, comparar	#se o valor for igual a '\n' o programa salta
	addi $t4,$t4,1 		#caso contrario o contador de caracteres aumenta 1
	addi $t0,$t0,1		#aumenta 1 a $t0 para que o endereço de memoria passe a apontar para os 8 bits seguintes
	j loop1 
	
comparar:
	addi $t7, $t7, 4
	div $t4, $t7		
	mfhi $s3
	mflo $a1
	beq $s3, $zero, success
	bne $s3, $zero, entradaInvalida
	
entradaInvalida:
	la $a0, invalida 
	li $v0, 4
	syscall
       	j exit

success:
	jr  $ra		
	
exit: 
	jal barraene
	la $v0, 10   # finaliza
	syscall		
	     
	
barraene: 
	li $v0, 11           
	addi $a0, $zero, 10  
	syscall  
	            
	jr $ra 
	
