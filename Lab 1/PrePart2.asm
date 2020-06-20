	.text
	.globl __main

__main:
	
	# Prompting the user to input a, b, c, d
	li $v0, 4 
	la $a0, inputPrompt
	syscall
	
	# Getting integers a, b, c, d
	# $a0 = a, $a1 = b, $a2 = c, $a3 = d 
	li $v0,  5
	syscall
	add $a0, $v0, 0
	
	li $v0,  5
	syscall
	add $a1, $v0, 0
	
	li $v0,  5
	syscall
	add $a2, $v0, 0
	
	li $v0,  5
	syscall
	add $a3, $v0, 0
	
	# Calling function computeExpression
	jal computeExpression
	move $v1, $v0
	
	# Output
	addi $s0, $v0, 0
	li $v0, 4 
	la $a0, outputPrompt
	syscall
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	# End program
	li $v0, 10
    	syscall
    	
computeExpression: 
	sub $t0, $a1, $a2 # b-c
	mult $a0, $t0 # a * (b-c)
	mflo $t1 # using lower 32 bits of the product
	div $t1, $a3 # a * (b-c) / d
	mfhi $v0 # remainder stored in hi register

	jr $ra # return statement
	
	.data
	inputPrompt: .asciiz "Enter a, b, c, d in sequential order: "
	outputPrompt: .asciiz "The output is "	
