	# ParseNode.asm
	# This file implements the ParseNode class.

	.globl		main

	.data

valueOf:
	.asciiz		"The value of "

is:
	.asciiz		" is "

endLine:
	.asciiz		".\n\n"

n1Label:
	.asciiz		"n1"

n3Label:
	.asciiz		"n3"

n5Label:
	.asciiz		"n5"

n7Label:
	.asciiz		"n7"

n9Label:
	.asciiz		"n9"

n11Label:
	.asciiz		"n11"

	.text

	# ParseNode.PrintValue(ParseNode pn, String nm) private method
	#
	# The java Code
	#
	#    printValue(pn, nm)
	#
	# translates to
	#
	#    code to put the address of pn into $a0
	#    code to put the address of nm into $a1
	#    jal     printValue
	#
	# Effect:
	#
	#    Prints a sentence describing the value of the parse tree
	#    rooted at pn, using nm as its name.
	#
printValue:
	# System.out.println("The value of " + nm + " is " + pn.value());
	# pn is in $a0, nm is in $a1
	# save pn and nm

	sub	$sp, $sp, 16	# space for 3 registers and return address
	sw	$t0, 0($sp)
	sw	$t1, 4($sp)
	sw	$t2, 8($sp)
	sw	$ra, 12($sp) 	# preserve the registers we use

	move	$t0, $a0	# save pn
	move	$t1, $a1	# save nm

	li	$v0, 4
	la	$a0, valueOf
	syscall

	li	$v0, 4
	move	$a0, $t1 	# nm
	syscall

	li	$v0, 4
	la	$a0, is 	# "is"
	syscall

	move	$a0, $t0	# $t0 holds the address of the node
	lw	$t9, 0($a0)
####### breaks here!!##########################################
	jalr	$t9		# put the value into $v0

	move	$t2, $v0	# $t2 = pn.value();

	li	$v0, 1
	move	$a0, $t2
	syscall		# print pn.value();

	li	$v0, 4
	la	$a0, endLine	# seperating spaces
	syscall


	lw	$t0, 0($sp)
	lw	$t1, 4($sp)
	lw	$t2, 8($sp)
	lw	$ra, 12($sp)
	add	$sp, $sp, 16	# restore registers and de-allocate the stack

	jr		$ra

	# ParseNode.main() static method
	#
	# Executed automatically.
	#
	# Builds a test parse tree, printing tree values at various stages
	# of construction.
	#
main:
	# n1 = new Constant(7)
	li		$a0, 7
	jal		Constant

	move	$s1, $v0	# $s1 = address of n1

	# printValue("n1", n1)
	move	$a0, $s1
	la	$a1, n1Label
	jal	printValue

	# n2 = new Constant(13);
	li	$a0, 13
	jal	Constant	# create a new constant of value 13

	move	$s2, $v0	# save the constant

	# n3 = new Sum(n1, n2);
	move	$a0, $s1
	move	$a1, $s2
	jal	Sum
				# save the sum
	move	$s3, $v0	# $s3 = sum1

	# printValue("n3", n3);
	la	$a0, n3Label	#
	la	$a1, 0($s3)	# vallue method of node3
	jal	printValue

	# ParseNode n4 = new Constant(5);
	li	$a0, 5
	jal	Constant
	move	$s4, $v0	# $s4 = n4

	# ParseNode n5 = new Sum(n3, n4);
	move	$a0, $s3
	move	$a1, $s4
	jal	Sum
	move	$s5, $v0	# $s5 = n5

	# printValue("n5", n5);

	la	$a0, n5Label
	move	$a1, $s5
	jal	printValue

	# FIXME - Implementation step 3
	# n6 = new Constant(3);
	# n7 = new Difference(n5, n6);
	# printValue("n7", n7);

	# FIXME - Implementation step 4
	# n8 = new Constant(4);
	# n9 = new Product(n7, n8);
	# printValue("n9", n9);

	# FIXME - Implementation step 5
	# n10 = new Constant(2);
	# n11 = new Quotient(n9, n10);
	# printValue("n11", n11);

	# terminate the program
	li		$v0, 10
	syscall
