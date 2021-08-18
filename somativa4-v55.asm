.data
	invalidas: .asciiz "Entradas invalidas.\n"
	invalidas2: .asciiz "O modulo nao eh primo.\n"
	
	exponencial: .asciiz "A exponencial modular "
	elevado: .asciiz " elevado a "
	resultado: .asciiz " eh "
	moddois: .asciiz ")"
	mod: .asciiz " (mod "
	dot: .asciiz ".\n"


.text
.globl main
	
main:
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0

	# Leitura do 3 valor em s4 para analise do primo
	jal read_int							
	la 	$s0, ($v0)						
	li	$s4, 0
	
	# Filtro 1 <= x <= 65535
	blt $s1, 1, printInvalida
	bgt $s1, 65535, printInvalida
	
	blt $s2, 1, printInvalida
	bgt $s2, 65535, printInvalida
	
	blt $s0, 1, printInvalida
	bgt $s0, 65535, printInvalida
	
	beq $s0, 1, printInvalida2
	
	# Grava o 3 valor em s5										
	addi $s5, $s0, 0 
	
	# Descobre a raiz quadrada em s4
	jal isqrt	
	
	# Inicia o i = 2 para verificaçao do primo
	li $s6, 2 
	
	# verifcia primo
	jal func_primo
	jal call
	j while
	
call:
	addi $s5, $s1, 0      
	addi $s6, $s2, 0
	move $s0, $s5
	move $s1, $s6
	move $s2, $v0
	add $s4, $s0, 0 
	add  $s5, $s1, 0
	add $t5, $zero, 1
	jr $ra
	
while:
	
	beq $s1, $zero, stopwhile 
	div $t6, $s1, 2      #adicionando 2 em registrador
	mfhi $t4              #dividindo por 2
	beq $t4, $zero, entraIF    #armazenando o resto em t4 e indo pra funcao
	bnez $t4, entraELSE  #se for diferente de zero
	
	j while
	
entraIF:
	
	add $t0, $s0, $zero	#adicionando o valor de s0 em t0
	add $t1, $s0, $zero	#adicionando valor de s0 em t1
	add $s3, $zero, $zero  #inicializando 0 em s3
	
	div $t0, $s2
	mfhi $t0
	
	jal again
	
again:
	ble $t1, $zero, endagain   #comparando o valor que esta em t1 com zero
	div $t3, $t1, 2     #dividindo t1 por 3
	mfhi $t3   #pegando o resto da divisao
	beq $t3, 1, if_um  #se t7 for igual a 1, entra na condição
		
	mul $t0, $t0, 2  #multiplicando t0 por 2 e guardando em t0
	div $t0, $s2  #dividindo por s2
	mfhi $t0
	div $t1, $t1, 2
	j again
	
endagain:
	div $s3, $s2       #dividindo valor
	mfhi $s0
		
	div $s1, $s1, 2
	
	j while
	
entraELSE:
	
	move $t0, $s0    #definindo s0 para o registrador t0
	move $t1, $t5      #definindo t5 para o registrador t1
	add $s3, $zero, $zero 
	
	div $t0, $s2     
	mfhi $t0  #pegando resto da divisao em t0
	
	jal while2
	
while2: 
	ble $t1, $zero, stopwhile2 #se for igual a 0 sai do loop
	div $t3, $t1, 2   #dividindo por 2 o valor de t1
	mfhi $t3     #pegando o resto do valor da divisao anterior
	beq $t3, 1, if_dois
	
	mul $t0, $t0, 2 #multiplicando por 2 o valor de t0
	div $t0, $s2
	mfhi $t0 #pegando o resto da divisao em t0
	
	div $t1, $t1, 2
	j while2
	
stopwhile2:
	div $s3, $s2  #dividindo o valor que esta em s3
	mfhi $t5   #armazenando o resto em t5

	sub $s1, $s1, 1  #subtrair s1 de s1
	
	j while
	
stopwhile:
 	la   $a0, exponencial   
        li   $v0, 4          
        syscall
        
        move $a0, $s4
	li $v0, 1
 	syscall
 	
 	la   $a0, elevado   
        li   $v0, 4          
        syscall
        
        move $a0, $s5
	li $v0, 1
 	syscall
 	
 	la   $a0, mod   
        li   $v0, 4          
        syscall
        
        move $a0, $s2
	li $v0, 1
 	syscall
 	
 	la   $a0, moddois   
        li   $v0, 4          
        syscall
        
        la   $a0, resultado 
        li   $v0, 4          
        syscall
        
        move $a0, $t5
	li $v0, 1
 	syscall
 	
 	la   $a0, dot   
        li   $v0, 4          
        syscall
 	
 	jal exit

if_um:
	add $s3, $s3, $t0
	div $s3, $s2
	mfhi $s3
	
	mul $t0, $t0, 2
	div $t0, $s2
	mfhi $t0
	
	div $t1, $t1, 2
	
	j again

if_dois:
	add $s3, $s3, $t0
	div $s3, $s2
	mfhi $s3
		
	mul $t0, $t0, 2
	div $t0, $s2
	mfhi $t0
	
	div $t1, $t1, 2
	
	j while2		
																																								
																																																																																																																							
func_primo:   
	bgt $s6, $s4, success    
	div $s5, $s6
	mfhi $t3
	beq $t3, $zero, printInvalida2
	addi $s6, $s6, 1
	j func_primo			
		
																																								
printInvalida:

	la $a0, invalidas   
	li $v0, 4
	syscall
        jal exit

printInvalida2:

	la $a0, invalidas2  
	li $v0, 4
	syscall
        jal exit
	
read_int:
	li $v0, 5	
	syscall		
	jr $ra	
	
isqrt:
	mul	$t0, $s4, 2
	add $t0, $t0, 1
	sub $s0, $s0, $t0
	add $s4, $s4, 1			# incrementa o contador, que sera o resultado da raiz
	beq $s0, $zero, success	# se chegamos a zero a raiz é perfeita
	slt	$t0, $s0, $zero		# caso seja menor que zero, deu problema
	beq $t0, 1, error		# então mostramos mensagem de erro
	j isqrt				# caso não ocorra nenhum dos casos acima, itera novamente
	
error:
	sub $s4, $s4, 1      # quando nao for raiz perfeita retorna o menor inteiro 
	j success

success:
	jr  $ra	     # retorna pra main
  
	
exit: 
	la $v0, 10   # finaliza
	syscall	


	
