# this program sorts an array of integers
# and prints out the intergers in the correct order
#
#
#
#
#
	.globl main

	.data

# the program string constants for output
PreMessage:	.asciiz "the test array pre-sort is: "
PostMessage:	.asciiz "the test array post-sort is: "
newline:	.asciiz "\n"

# the testing array
testArray:
    .word   5
    .word   7
    .word   4
    .word   2
 #   .word   5
 #   .word   6
 #   .word   3
 #   .word   2
 #   .word   1
 #   .word   0

	.text


# main program
main:

	li $t1, 3	# number of elements in the array

	li	$v0, 4
	la	$a0, PreMessage	# print the pre-sort message
	syscall

	li	$v0, 4		# print a newline
	la	$a0, newline
	syscall

	# PRINT THE ARRAY PRESORT
	la		$a0, testArray	# pass in the start of the array
	li		$a1, 4 		# set number of elements to be printed-----------------------------
	jal	printArray

	# SORT THE ARRAY
	la	$a0, testArray	# pass in the start of the array
	li	$a1, 4		# set number of elements to be sorted----------------------------
	jal	sortArray


	li	$v0, 4
	la	$a0, PostMessage	# print the post-sort message
	syscall

	li	$v0, 4		# print a newline
	la	$a0, newline
	syscall

	# PRINT THE ARRAY POSTSORT
	la	$a0, testArray	# pass in the start of the array
	li	$a1, 4		# set number of elements to be printed--------------------------
	jal	printArray


	li	$v0, 10		# terminate the program
	syscall
