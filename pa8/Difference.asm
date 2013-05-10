# Difference.asm
# This file implements the Difference class.

	.globl		Difference
	
	.text
	
# Constructor for the Difference class
#
# The Java code
#
#    new Difference(n1, n2)
#
# translates to
#
#    code to put the address of n1 into $a0
#    code to put the address of n2 into $a1
#    jal     Difference
#
# The address of the new Difference instance is returned in $v0.
#
Difference:

        # FIXME - Implementation step 3.
	jr		$ra

# Difference class implementation of the ParseNode.value() method
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

        # FIXME - Implementation step 3.
	jr		$ra

