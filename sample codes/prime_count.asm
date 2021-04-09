.data 
FirstInteger: .asciiz "Enter first integer: " 
Factor: .asciiz "factor is: " 
.text 
	main:
	la $a0, FirstInteger
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0,$v0
	li $t1, 2
	li $t5, 2
	
	loop:
	mult $t1,$t1
	mflo	$t2
	bgt $t2,$t0,bla
	div $t0,$t1
	mfhi $t4
	beqz $t4 tra
	addi $t1,$t1,1
	j loop

	bla:
	ble $t0,1, exit
	#move $a0,$t0
	#li $v0,1
	#syscall
	j exit
	
	exit:
	addi $t5,$t5,-1
	move $a0,$t5
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
	
	tra:
	#move $a0,$t1
	#li $v0,1
	#syscall
	
	#li $v0, 11
	#li $a0, 32
	#syscall
	
	addi $t5,$t5,1
	
	mflo $t0
	j loop