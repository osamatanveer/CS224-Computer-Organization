	.text
	.globl __main
__main:
	# Prompting the user to input a, b, c, d
	li $v0, 4 
	la $a0, inputPrompt
	syscall
	
	# Getting integers a, b, c, d
	# $a0 = b, $a1 = c, $a2 = d 
	li $v0,  5
	syscall
	add $a0, $v0, 0
	
	li $v0,  5
	syscall
	add $a1, $v0, 0
	
	li $v0,  5
	syscall
	add $a2, $v0, 0
	
	mult $a0, $a1 # (b * c)
	mflo $t0 
	
	div $a0, $a1 # b mod c
	mfhi $t1
	
	div $t1, $a2 # (b mod c) / d
	mflo $t2
	
	add $t3, $a2, $t2
	sub $t3, $t3,$t0 
	
	# Output
	addi $s0, $v0, 0
	li $v0, 4 
	la $a0, outputPrompt
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	# End program
	li $v0, 10
    	syscall
	
	.data
	inputPrompt: .asciiz "Enter b, c, d in sequential order: "
	outputPrompt: .asciiz "The output is "	
