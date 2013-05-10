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

        # FIXME - Implementation step 2.
	jr		$ra

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

        # FIXME - Implementation step 2.
	jr		$ra

