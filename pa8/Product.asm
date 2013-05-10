# Product.asm
# This file implements the Product class.

	.globl		Product
	
	.text
	
# Constructor for the Product class
#
# The Java code
#
#    new Product(n1, n2)
#
# translates to
#
#    code to put the address of n1 into $a0
#    code to put the address of n2 into $a1
#    jal     Product
#
# The address of the new Product instance is returned in $v0.
#
Product:

        # FIXME - Implementation step 4.
	jr		$ra

# Product class implementation of the ParseNode.value() method
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

        # FIXME - Implementation step 4.
	jr		$ra

