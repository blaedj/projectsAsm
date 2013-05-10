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
        # FIXME - Implementation step 1.
	mv	$t2, $a0	# store the parameter,

	sub	$sp, $sp, 8	# save the return address
	sw	$ra, 0($sp)


	li	$v0, 9	# sbrk allocate space
	li	$a0, 8 	# 2 words = 8 (bytes)
	syscall

	move	$t0, $v0	# save the address of the struct
	la	$t1, value	# get the address for the value method

	sw 	$t2, 4($t0)	# store the value
	sw	$t1, 0($t0)	# make the value method accessible


	mv	$v0, $t0 	#"the return value goes here"

	lw	$ra, 0($sp)
	add	$sp, $sp, 8	# restore the stack and return address

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
	sub	$sp, $sp, 8	# save the return address
	sw	$ra, 0($sp)

	lw	$t0, 0($t9)	#
	mv	$v0, $t0	# set the return value

	lw	$ra, 0($sp)
	add	$sp, $sp, 8	# restore the stack and return address
	jr		$ra
