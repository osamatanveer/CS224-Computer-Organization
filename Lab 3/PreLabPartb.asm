	.text
	.globl __main
	
__main:
	
	# first number input
	la $a0, promptForValue1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	# second number input
	la $a0, promptForValue2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0

	move $a0, $s0
	move $a1, $s1
	
	# Calling Fucntion 
	jal recursiveMultiplication
	move $s0, $v0
	
	# Displaying Product
	la $a0, promptForProductResult
	li $v0, 4
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	la $a0, endLine
	li $v0, 4
	syscall
	
	# ADDITION
	
	# n input
	la $a0, promptForN
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0

	move $a0, $s0
	li $a1, 0
	jal recursiveSummation
	
	move $s0, $v0
	move $a0, $s0
	li $v0, 1
	syscall
	
	# Exit 	
	li $v0, 10
	syscall		
	
recursiveMultiplication:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp) # number to add
	sw $a1, 8($sp) # number of times number to add
	move $v0, $zero	
	
	# base case
	beq $a1, 1, recMulDone
	
	# find sum of (n-1)
	addi $a1, $a1, -1
	
	jal recursiveMultiplication
	add $v0, $a0, $v0
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	add $sp, $sp, 12
	
recMulDone:
	jr $ra
			
recursiveSummation:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a1, 4($sp) # number to add
	move $v0, $zero	
	
	# base case
	beq $a1, $a0, recSumDone
	
	# next term
	addi $a1, $a1, 1
	
	jal recursiveSummation
	add $v0, $t0, $v0
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	add $sp, $sp, 8
	move $t0, $a1
	
recSumDone:
	jr $ra
		
	.data
	promptForValue1: .asciiz "Enter the first number: "
	promptForValue2: .asciiz "Enter the second number: "
	promptForProductResult: .asciiz "\nThe product is "
	promptForN: .asciiz "Enter the value of n: "
	promptForSumResult: .asciiz "The sum is "
	endLine: .asciiz "\n"