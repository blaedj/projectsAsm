# Quotient.asm
# This file implements the Quotient class.

	.globl		Quotient
	
	.text
	
# Constructor for the Quotient class
#
# The Java code
#
#    new Quotient(n1, n2)
#
# translates to
#
#    code to put the address of n1 into $a0
#    code to put the address of n2 into $a1
#    jal     Quotient
#
# The address of the new Quotient instance is returned in $v0.
#
Quotient:

        # FIXME - Implementation step 5.
	jr		$ra

# Quotient class implementation of the ParseNode.value() method
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

        # FIXME - Implementation step 5.
	jr		$ra

