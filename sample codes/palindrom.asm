.data
starter_text: .asciiz "Enter a string to check if it is a palindrome: "
is_palin_msg: .asciiz "YES!!! This string is a palindrome.\n"
not_palindrome_msg: .asciiz "NO!!! This string is not a palindrome.\n"
allocate_memory: .space 257 # alloxate 256 + 1 bytes for the string.

.text
	main:
	## read the string S:
	la $a0, starter_text #prompt user to enter a phrase
	li $v0, 4
	syscall
	
	la $a0, allocate_memory #store phrase
	li $a1, 256 #size of string
	li $v0, 8 # load code into $v0.
	syscall

	la $t1, allocate_memory  
  	
	la $t4, allocate_memory 
  
  	# get length of input string
	length_loop:
	lb $t5, ($a0)
	beq $t5, 10, checkPali #checking for palindrome
	bgt $t5, 47, test1
	j negative
  	
  	# cases to check if input is valid
  	# according to ASCII TABLE
	test1: 
	blt $t5, 58, positive #ascii
	bgt $t5, 64, test2
	j negative
  
  
	test2: 
	blt $t5, 91, positive 
	bgt $t5, 96, test3 
	j negative
	
	test3: 
	blt $t7, 123, positive
	j negative
  
  	#input x is nice string in. Char by Char a-z A-Z
	positive: 
   	bgt $t5, 96, makeLow #ascii
	j not_Upper_Case
		
	# change from lower to upper case if needed
	makeLow:
	addi $t5, $t5, +32 

	not_Upper_Case:
	sb $t5, ($t1)
	addi $a0, $a0, 1 #increment
	addi $t1, $t1, 1
	j length_loop

	negative:
	addi $a0, $a0, 1 #increment user input
	j length_loop
  

	checkPali:
	sb $zero, ($a0)
	addi $t1, $t1, -1 #decrement

	loop:   
	lb $t3, ($t4)
	lb $t2, ($t1)   
	beq $t3, $t2, next
	j not_palindrome
	
	next: 
	jal test_loop #jump and link to test loop.
	addi $t4, $t4, 1 # incrememnt
	addi $t1, $t1, -1 # decrememnt
	j loop # continue to loop

	#test to see if we need to check more characters
	test_loop:
	beq $t4, $t1, is_palindrome
	addi $t1, $t1, -1
	beq $t4, $t1, is_palindrome 
	addi $t1, $t1, 1
	jr $ra 

	#case  when string is palindrom
	is_palindrome: 
	la $a0, allocate_memory
	li $v0, 4
	la $a0 is_palin_msg
	syscall
   	j exit

	#case when string is not palindrom
	not_palindrome:
	la $a0, not_palindrome_msg 
	li $v0, 4
	syscall
	j exit
  	
  	# end of program
	exit: 
	li $v0, 10 
	syscall 
