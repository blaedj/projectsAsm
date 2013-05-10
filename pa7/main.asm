# This is the main file for the dynamic matrices program.
#
#
	.globl main

	.data

# static entries declaration
entries:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5

# static descriptor declaration for a 6x1 matrix
matrix6x1:
	.word	6	# 6 rows
	.word	1	# 1 column
	.word	entries

# static descriptor declaration for a 3x2 matrix
matrix3x2:
	.word	3	# 3 rows
	.word	2	# 2 columns
	.word	entries

# static descriptor declaration for a 2x3 matrix
matrix2x3:
	.word	2	# 2 rows
	.word	3	# 3 columns
	.word	entries

# static descriptor declaration for a 1x6 matrix
matrix1x6:
	.word	1	# 1 row
	.word	6	# 6 columns
	.word	entries
matrix1:
		.asciiz "\nThis is the 6x1 matrix\n"
matrix2:
		.asciiz "\nThis is the 3x2 matrix\n"
matrix3:
		.asciiz "\nThis is the 2x3 matrix\n"
matrix4:
		.asciiz "\nThis is the 1x6 matrix\n"
matrix5:
		.asciiz "\nThis is the 6x6 matrix, created dynamically\n"

productMatrix:
		.asciiz "\n This is the product of matrix2 and matrix3"

endMessage:
	.asciiz "\nThe program will now terminate"

	.text

main:

	# testing for the mwrite sub-program

	li	$v0, 4
	la	$a0, matrix1
	syscall			# print out the matrix name

	la	$a0, matrix6x1	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix
#---
	li	$v0, 4
	la	$a0, matrix2
	syscall			# print out the matrix name

	la	$a0, matrix3x2	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix
#---
	li	$v0, 4
	la	$a0, matrix3
	syscall			# print out the matrix name

	la	$a0, matrix2x3	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix
#---
	li	$v0, 4
	la	$a0, matrix4
	syscall			# print out the matrix name

	la	$a0, matrix1x6	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix
#---
	# the dynamic matrix
	li	$v0, 4
	la	$a0, matrix5
	syscall			# print out the matrix name

	# set the parameters and call mcreate
	li	$a0, 6		# 6 rows
	li	$a1, 6		# 6 columns
	jal	mcreate
#	move	$t0, $v0	# $t0 holds the address to the descriptor

	move	$a0, $v0
	jal	mwrite		# write out the dynamic array

#--- the mmult test
	li	$v0, 4
	la	$a0, productMatrix
	syscall			# print out the matrix name

	la	$a0, matrix2x3
	la	$a1, matrix3x2
	jal	mmult

	move 	$a0, $v0
	jal		mwrite



#----- end of printing arrays----
	li	$v0, 4
	la	$a0, endMessage
	syscall

	li	$v0, 10		# terminate the program
	syscall
