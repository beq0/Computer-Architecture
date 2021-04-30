.data
endl: .asciiz "\n"
.text
.globl solution

solution:
    # int m;
    # cin >> m;    m is saved in $t0
    jal		readint
    move 	$t0, $v0

    # int n;
    # cin >> n;    n is saved in $t1
    jal		readint
    move 	$t1, $v0

# while(1)
outerLoop:

    # int i = 2;
    addiu	$t2, $zero, 2

    # for (i = 2; i <= m; i++) {
    #     if (m % i == 0) {
        #     if (n % i == 0) {
        #         m = m / i;
        #         n = n / i;
        #         goto aqa;
        #     }
        # }
    # }
    innerLoop:
        bgt		$t2, $t0, printres      # if i > m, print result
        
        divu	$t0, $t2    # m / i
        mfhi	$t3		    # Modulo is kept in hi register
        mflo    $t4         # Division is kept in lo register
        bnez	$t3, skipInner	# If modulo is not 0, then go to "skip"
        
        divu	$t1, $t2    # n / i
        mfhi	$t3		    # Modulo is kept in hi register
        mflo    $t5         # Division is kept in lo register
        bnez	$t3, skipInner	# If modulo is not 0, then go to "skip"

        move    $t0, $t4    # m = m / i
        move    $t1, $t5    # n = n / i

        j       outerLoop   # goto aqa
        
        skipInner:
            addiu		$t2, $t2, 1     # Increment i for next iteration
            j		innerLoop


# cout << m;
# cout << n;
printres:
    # cout << m;
	li 	$v0, 1		
	move	$a0, $t0	
	syscall

    li $v0, 4 
    la $a0, endl
    syscall

    # cout << n;
    li 	$v0, 1		# Print result
	move	$a0, $t1	
	syscall
	
	li	$v0, 10		# Exit
	syscall

# cin >> N; 
readint:
	li 	$v0, 5		# Read integer
	syscall
	
	jr 	$ra		# Return
