.data
.text
.globl gcd

gcd:
	jal 	readint
	move 	$t1, $v0	# Read first integer A
	
	jal 	readint
	move 	$t2, $v0	# Read second integer B

	abs 	$t1, $t1	# abs(A)
	
	abs 	$t2, $t2	# abs(B)
	
loop:
	beqz 	$t2, printres	# if B equals 0 then A is GCD
	
	div 	$t1, $t2	# LO has (A mod B)
	mfhi	$t3		# TMP = A mod B
	move	$t1, $t2	# A = B
	move 	$t2, $t3	# B = TMP
	
	j	loop		# Next iteration	
	
printres:
	li 	$v0, 1		# Print GCD
	move	$a0, $t1	# A is resultt
	syscall
	
	li	$v0, 10		# Exit
	syscall
	
readint:
	li 	$v0, 5		# Read integer
	syscall
	
	jr 	$ra		# Return