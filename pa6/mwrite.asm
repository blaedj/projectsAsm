# This sub-program writes out a matrix given the address of the
# matrix descriptor (a struct)


	.globl	mwrite

	.data
	
	newline: .asciiz "\n" 
	space:   .asciiz " "
	

	.text

mwrite:
	# typical call sequence
	# la    $a0, matrixDescriptor
	# jal   mwrite
	#
	sub		$sp, $sp, 4		# allocate space for one register
	sw		$s0, 0($sp) 	# save $s0


	move	$s0, $a0		# store the address of the matrix descriptor struct in a safe place
	
	#initialize the counters
	li 		$t0, 0   # outer loop counter
	li 		$t1, 0   # inner loop counter
	
	# access the rowCount, ColumnCount and elementsArray of the descriptor struct
	lw		$t2, 0($s0)	# $t2 is the # of rows 
	lw		$t3, 4($s0)	# $t3 is the # of columns
	lw		$t4, 8($s0) # $t4 is the adress of the entries Array 
	
	# initialize the register to hold the value to print
	li	$t5, 0			# $t5 holds the word to print
	
	b	outerLoopTest
	outerLoopTop:
	li		$t1, 0		# reset the inner loop counter
	
	b innerLoopTest
	
	innerLoopTop:
	# do a syscall to print out the current word, then increment the counter
	
	lw		$t5, 0($t4)	# set $a0 to the value of the current array element

	li		$v0, 1
	move 	$a0, $t5		
	syscall 			# print out the element
	
	li	$v0, 4		# print a space
	la	$a0, space 
	syscall
	
	# increment the head of the array by 4
	add		$t4, $t4, 4		# move the pointer to the head of the array up by four
	
	# increment the inner counter by one
	add		$t1, $t1, 1 
	
	innerLoopTest:
	blt		$t1, $t3 ,innerLoopTop
	
	# print a newline, for formatting
	li	$v0, 4		
	la	$a0, newline
	syscall
	
	# increment the outer loop counter by one
	add		$t0, $t0, 1 
	
	outerLoopTest: 
	# while the counter < # of rows, branch to the loop top
	blt		$t0, $t2, outerLoopTop
	
	
	
end: 
	lw	 	$s0, 0($sp)		#restore $s0
	add		$sp, $sp, 4		# deallocate the stack
	jr		$ra				# return to the caller
	
