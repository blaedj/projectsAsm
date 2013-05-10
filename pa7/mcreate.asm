# mcreate.asm
# This program dynamically creates matrices
# given the number of rows and columns.
# The return value is the address of the matrix descriptor, a struct.
# typical call sequence:
#
	.globl mcreate

	.data

# here is an overview of the sturcture of the matrix descriptor
# aMatrix:
	# .word	1	# number of rows
	# .word	1	# number of columns
	# .word	entries # the address of the entries array
	#

	.text

mcreate:
	# allocate stack space
	sub	$sp, $sp, 8	# allocate space for 2 registers
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)	# and store preserved registers

	# store the parameters in a safe place
	move	$s0, $a0	# $s0 is the number of rows
	move	$s1, $a1	# $s1 is the number of columns

	# create the array
	mul	$t0, $s0, $s1	# calculate the total entries, rows * columns

	li	$v0, 9
	move	$a0, $t0	# $t0 is the total number of matrix elements
	syscall
	move	$t1, $v0	# $t1 is the address of the entries array

	# create the struct
	li	$v0, 9		# sbrk, allocate a space for the struct
	li	$a0, 12		# Three words = 12 bytes
	syscall
	move	$t2, $v0	# $t2 is the base address of the descriptor

	# set the members of the struct to their correct values
	sw	$s0, 0($t2)	# the first member is num of rows
	sw	$s1, 4($t2)	# the second member is num of columns
	sw	$t1, 8($t2)	# 3rd member is the address of the entries array

	move	$v0, $t2	# set the return value

end:	# the end of sub-program house keeping

	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	add	$sp, $sp, 8	# restore registers and de-allocate the stack

	jr	$ra		# return to caller
