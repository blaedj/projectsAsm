# mmult subprogram
# this subprogram multiplies two matrices
# it takes in two matrix descriptors as it's parameters.
#
# 1. make sure the 2 matrices are compatible, if not then return null, (0)
# 2. if compatible, call mcreate to create a new matrix descriptor and array for the result.
#
# $s0 = M1 = matix 1 descriptor address
# $s1 = M2 = matrix 2 descriptor address
# $s2 = R = result matrix descriptor address
# $t0 = r = row index
# $t1 = c = column index
# $t2 holds temp copy of R[r][c]
# $t3 = num of cols in M1
# $t4 = num of rows in M2
# $t5 = num of rows in M1
# $t6 = num of cols in M2
# $t7 = 'k', innermost loop counter
# aMatrix:
# 	.word	1	# number of rows
# 	.word	1	# number of columns
#	.word	entries # the address of the entries array

#   overview of accessing properties of a matrix descriptor
#	lw		[Register1], 0($s0)	# [Register1] is the # of rows
#	lw		[Register2], 4($s0)	# [Register2] is the # of columns
#	lw		[Register3], 8($s0) 	# [Register3] is the adress of the entries Array

	.globl mmult

	.data

	.text

mmult:
# save all of the s registers
	sub	$sp, $sp, 32	# allocate space for all 8 s-registers
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)	# and store/preserved registers
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	sw	$s4, 20($sp)
	sw	$s5, 24($sp)
	sw	$s6, 28($sp)
	sw	$s7, 32($sp)

# save parameters
	move	$s0, $a0	# $s0 is the address of matrix descripter 1
	move	$s1, $a1	# $s1 is the address of matrix descripter 2

# check for compatibility:
# columns of M1 must equal rows of M2
	lw 	$t3, 4($s0) 		# $t3 is num of cols in M1
	lw 	$t4, 0($s0) 		# $t4 is num of rows in M2

	bne 	$t3, $t4, notCompatible # if not compatible, jump to 'return null'

	# else the two are compatible, need to call mcreate to make the result matrix

	lw	$t5, 0($s0)
	lw 	$t6, 4($s1)

	move	$a0, $t5		# rows in m1 = rows in r
	move	$a1, $t6		# cols in m2 = cols in r
	jal	mcreate
	move	$s2, $v0		# move the address of the descriptor to a safe place


	li	$t0, 0			# $t0 = outer loop counter/row index (r)
	b	outsideLoopTest
outsideLoopTop:
	add	$t0, $t0, 1		# increment outermost loop counter

	li	$t1, 0			# $t1 = 2nd level loop counter/column index (c)
	b	secondLoopTest
secondLoopTop:
	add	$t1, $t1, 1		# increment the second loop counter



	li	$t7, 0			# $t7 = inner loop counter (k)
	li	$t2, 0			# set the R[r][c] to zero before inner loop
	b	innerLoopTest
innerLoopTop:
	# address of M[r][c] = (r*(m.colCount) + c)*4 + base address of entries array got M

	#$s3 = address of R[r][c]
	li	$s3, 0
	mul	$s3, $t0, $t5	# r * colCount = total
	add	$s3, $s3, $t1   # (total) + c
	mul	$s3, $s3, 4	# (total) * 4
	lw	$t9, 8($s2)
	add	$s3, $s3, $t9 	# the address of R[r][c]

	# $s4 = address of M1[r][k]
	li	$s4, 0
	mul	$s4, $t0, $t3	# r * colCount = total
	add	$s4, $s4, $t7   # (total) + c
	mul	$s4, $s4, 4	# (total) * 4
	lw	$t9, 8($s0)
	add	$s4, $s4, $t9	 # the address of M1[r][k]

	# $s5 = address of M2[k][c]
	li	$s5, 0
	mul	$s5, $t7, $t6	# r * colCount = total
	add	$s5, $s5, $t1   # (total) + c
	mul	$s5, $s5, 4	# (total) * 4
	lw	$t9, 8($s1)
	add	$s5, $s5, $t9 	# the address of R[r][c]

	# $t2 = $t2 +  mul ((lw 0($s5))), (lw 0($s4))
	lw	$s7, 0($s5)
	lw	$t8, 0($s4)	# get the values of the current array indices

	mul	$s7, $s7, $t8
	add	$t2, $t2, $t7	# load the computed value of the R[r][c] into $t2
	sw	$t2, 0($s3)	# load the value in $t2 into the appropriate address in memory

innerLoopTest:
	blt	$t7, $t3, innerLoopTop	# increment the inner loop counter

secondLoopTest:
	blt	$t1, $t6, secondLoopTop	# c < M2.columnCount

#-----------
outsideLoopTest:
	blt	$t0, $t5, outsideLoopTop # r < M1.rowcount

	move	$v0, $s2	# return the address of the result matrix descriptor

end:	# frame de-allocation

	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$s4, 16($sp)
	lw	$s5, 20($sp)
	lw	$s6, 24($sp)
	lw	$s7, 28($sp)
	add	$sp, $sp, 32	# restore registers and de-allocate the stack

	jr	$ra		# return to caller

notCompatible:
	li	$v0, 0		# return null
	b	end
