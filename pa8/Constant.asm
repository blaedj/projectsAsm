# Constant.asm
# This file implements the Constant class.

	.globl		Constant

	.text

# Constructor for the Constant class
#
# The Java code
#
#    new Constant(val)
#
# translates to
#
#    code to put val into $a0
#    jal     Constant
#
# The address of the new Constant instance is returned in $v0.
#
Constant:

	sub	$sp, $sp, 12
	sw	$t0, 0($sp)
	sw	$t1, 4($sp)
	sw	$t2, 8($sp)

	move	$t2, $a0	# store the parameter,

	li	$v0, 9	# sbrk allocate space
	li	$a0, 8 	# 2 words = 8 (bytes)
	syscall

	move	$t0, $v0	# save the address of the struct

	la	$t1, value	# get the address for the value method

	sw	$t1, 0($t0)	# make the value method accessible
	sw 	$t2, 4($t0)	# store the value member

	move	$v0, $t0 	# the return value goes here


	lw	$t0, 0($sp)
	lw	$t1, 4($sp)
	lw	$t2, 8($sp)
	add	$sp, $sp, 12	# restore registers & deallocate stack

	jr	$ra

# Constant class implementation of the ParseNode.value() method
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
	# $t9 holds the address of the struct
	sub	$sp, $sp, 8	# save the return address, + 1 reg
	sw	$ra, 0($sp)
	sw	$t0, 4($sp)

	move	$t0, $a0	 #save the base address of the struct

	lw	$v0, 4($t0)	# set the return value

	lw	$ra, 0($sp)
	lw	$t0, 4($sp)
	add	$sp, $sp, 8	# restore the stack and return address

	jr	$ra
