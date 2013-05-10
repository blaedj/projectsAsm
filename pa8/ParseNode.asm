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
	mv	$t0, $a0	# save pn
	mv	$t1, $a1	# save nm

	li	$v0, 4
	la	$a0, valueOf
	syscall

	li	$v0, 4
	la	$a0, $t1 	# nm
	syscall

	li	$v0, 4
	la	$a0, is 	# "is"
	syscall

	li	$v0, 4
	la	$a0, $a1
	syscall		# print pn.value();

	jr		$ra

# ParseNode.main() static method
#
# Executed automatically.
#
# Builds a test parse tree, printing tree values at various stages
# of construction.
#
main:

# Implementation step 1
	# n1 = new Constant(7)
	li		$a0, 7
	jal		Constant
	move	$s1, $v0
	# printValue("n1", n1)
	la		$a0, n1Label
	move	$a1, $s1
	jal		printValue

# FIXME - Implementation step 2
    # n2 = new Constant(13);
    # n3 = new Sum(n1, n2);
    # printValue("n3", n3);
    # ParseNode n4 = new Constant(5);
    # ParseNode n5 = new Sum(n3, n4);
    # printValue("n5", n5);

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
