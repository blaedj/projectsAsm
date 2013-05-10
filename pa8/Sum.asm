	# Sum.asm
	# This file implements the Sum class.

	.globl		Sum

	.text
	# Constructor for the Sum class
	#
	# The Java code
	#
	#    new Sum(n1, n2)
	#
	# translates to
	#
	#    code to put the address of n1 into $a0
	#    code to put the address of n2 into $a1
	#    jal     Sum
	#
	# The address of the new Sum instance is returned in $v0.
	#
Sum:
	# save the parameters
	move	$t0, $a0	# left = $t0
	move	$t1, $a1	# right = $t1

	li	$v0, 9		# sbrk allocate space
	li	$a0, 12		# 1 word = 4 (bytes)
	syscall
	move	$t2, $v0	# save the address in $t2

	la	$t4, value

	sw	$t4, 0($t2)	# make the value method accesible
	sw	$t0, 4($t2)
	sw	$t1, 8($t2)	# store the left and right children

	move	$v0, $t2	# return the base address of the struct
	jr	$ra

	# Sum class implementation of the ParseNode.value() method
	#
	# The java Code
	#
	#    pn.value()
	#
	# translates to
	#
	#    code to put the address of pn into $a0
	#    lw      $t9, 0($a0)
	#    jalr    $t9
	#
	# The value for the parse tree rooted at pn is returned in $v0.
	#
value:

	add	$v0, $t0, $t1 # return the sum
	jr	$ra
