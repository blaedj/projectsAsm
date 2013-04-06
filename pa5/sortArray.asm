# SortArray Subprogram
# uses the quicksort algorithm to sort an array
#
#
#
	.globl sortArray

	.data

	.text

sortArray:
	# load the appropriate parameters for calling the quicksort method
	# takes in:
	#	$a0: the address of an array
	#	$a1: the number of elements in that array

	add	$sp, $sp, 16		# allocate some stack space
	sw	$s0, 0($sp)		# to store registers $s0-2
	sw	$s1, 4($sp)		#
	sw	$s2, 8($sp)		#
	sw	$s3, 12(#sp)		#


quickSort:
	# This subprogram sorts an array
	# input 1: array beginning address
	# input 2: indexlow is index low
	# input 3: indexhi is index high
	#
	# Typical call:
	#
	#	la	$a0, testArray # load the address of the unsorted array
	#	li	$a2, 1		# the low index of the unsorted array
	#	li	$a3, 4		# the high index of the unsorted array
	#	jal	sortArray	#

	move

	# int pivot = pivot value for partitioning array
	# int ulo, uhi => the high and low indeces of the unsorted area
	# int ieq =>the least index of array entry with value equal to pivot
	# int tempEntry => temp for swapping



	# if (indexlow >= indexhi) return
	bge
