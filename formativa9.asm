.data
	zero: .float 0.00000000
.text
	#le o float em $f0
	li $v0, 6
	syscall
	mov.s $f4, 
	
	
	li $v0, 2
	lwc1 $f12, $f7
	syscall
	
	
	