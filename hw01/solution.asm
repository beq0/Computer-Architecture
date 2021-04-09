.data
.text
.globl solution

solution:
    # int result = 0;    result is saved in t0
    move 	$t0, $zero	

    # int N;
    # cin >> N;    N is saved in $t1
    jal		readint
    move 	$t1, $v0
    
    # int i = 1;
    addiu	$t2, $t2, 1
    
    # for (int i = 1; i*i <= N; i++) {
    #     if (N % i == 0) result++;
    # }
loop:
    multu	$t2, $t2    # i*i
    mflo 	$t3     # significant bits of i*i (multu) is kept in lo register
    bgt		$t3, $t1, printres
    
    divu	$t1, $t2    # N / i
    mfhi	$t3		# Modulo is kept in hi register
    bnez	$t3, skip	# If modulo is not 0, then go to "skip"
    
    addiu	$t0, $t0, 1
    
    skip:
    	addiu		$t2, $t2, 1     # Increment i for next iteration
    	j		loop


# cout << result;
printres:
	li 	$v0, 1		# Print result
	move	$a0, $t0	
	syscall
	
	li	$v0, 10		# Exit
	syscall

# cin >> N; 
readint:
	li 	$v0, 5		# Read integer
	syscall
	
	jr 	$ra		# Return
