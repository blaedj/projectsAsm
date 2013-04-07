# print array file
#
#
#
# this file prints out the values of an array given the start address of the array
# and the number of entries to be printed
#

	.globl printArray

	.data

# string constants
# message:	.asciiz ""

newline:	.asciiz "\n"

	.text
#
# MAL call sequence assuming that $s0 holds the start address of the array
# and $s1 holds the number of array elements to be printed
#
# move	$a0, $s0
# move	$a1, $s1
# jal	printArray
#
# arrayAddress => $s0
# numElements => $s1
# counter => $s2

printArray:

	add	$sp, $sp, 12		# allocate some stack space
	sw	$s0, 0($sp)		# to store registers $s0-2
	sw	$s1, 4($sp)		#
	sw	$s2, 8($sp)		#

				# store the parameters into saved registers
	move 	$s0, $a0 	# save the arrays start address in a safe place
	move	$s1, $a1	# store the num of elements to print in a safe place
	li		$s2, 0		# set the counter to zero


	b	conditionTest
looptop:

	lw		$t2, 0($s0)

	li		$v0, 1
	move		$a0, $t2	# print the value of the current element
	syscall

	li	$v0, 4		# print a newline
	la	$a0, newline
	syscall

	addi	$s2, $s2, 1		# increment the counter

	add	$s0, $s0, 4		# move the start of the array up to move through the array

conditionTest:
	blt	$s2, $s1, looptop	# compare the counter and numOfElements

end:	# the subprogram is finished

	lw		$s0, 0($sp)	# restore the registers $s0-2
	lw		$s1, 4($sp)	#
	lw		$s2, 8($sp)	#
	sub		$sp, $sp, 12	# and deallocate the stack frame

	jr	$ra			# end of the function, return
