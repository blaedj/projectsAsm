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
		.asciiz "This is the 6x1 matrix"
matrix2:
		.asciiz "This is the 3x2 matrix"
matrix3:
		.asciiz "This is the 2x3 matrix"
matrix4:
		.asciiz "This is the 1x6 matrix"

endMessage:
	.asciiz "The program will now terminate"

newline: .asciiz "\n"

	.text

main:

	# testing for the mwrite sub-program


	li	$v0, 4
	la	$a0, matrix1
	syscall			# print out the matrix name



	la	$a0, matrix6x1	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix

	li	$v0, 4
	la	$a0, matrix2
	syscall			# print out the matrix name

	# print a newline, for formatting
	li	$v0, 4		
	la	$a0, newline
	syscall

	la	$a0, matrix3x2	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix

	li	$v0, 4
	la	$a0, matrix3
	syscall			# print out the matrix name
	
	# print a newline, for formatting
	li	$v0, 4		
	la	$a0, newline
	syscall

	la	$a0, matrix2x3	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix

	li	$v0, 4
	la	$a0, matrix4
	syscall			# print out the matrix name

	# print a newline, for formatting
	li	$v0, 4		
	la	$a0, newline
	syscall

	la	$a0, matrix1x6	# the address of the descriptor is the lone parameter
	jal	mwrite		# print out the matrix

	li	$v0, 4
	la	$a0, endMessage
	syscall


	li	$v0, 10		# terminate the program
	syscall
