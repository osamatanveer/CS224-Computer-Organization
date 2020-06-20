	.text
	.globl __main

__main:
	# part a
	jal initializeArray
	
	# part b
	jal bubbleSort
	
	# part c
	jal processArray
	
	li $v0, 10
	syscall

# PART A
initializeArray:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	
	# Taking input from user
	la $a0, promptForArraySizeInput
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # $s0 - n

	# Declaring array on heap of size n
	move $a0, $v0
	li $v0, 9
	syscall
	
	move $s1, $v0 # $s1 - starting address
	move $s2, $v0 # $s2 - addressing memory
	li $s3, 1 # $s2 - i = 0
	
forInitialize:
	bgt $s3, $s0, initialized
	li $a0, 1 # lower bound
	li $a1, 100000 # upper bound
	li $v0, 42
	syscall
	sw $a0, 0($s2)
	addi $s2, $s2, 4
	addi $s3, $s3, 1	
	j forInitialize
	
initialized:
	move $v0, $s0
	move $v1, $s1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	
	jr $ra	

# PART B
bubbleSort:
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	
	move $s0, $v0 # size 
	move $s1, $v1 # starting address
	li $s2, 0 # i = 0
	li $s3, 0 # j
	li $s4, 0 # inner loop termination
	li $s6, 0 # array addressing
	li $s7, 4 # array addressing 
outerFor: 	
	beq $s2, $s0, bubbleSortDone
	sub $s5, $zero, $s2 # -i 
	addi $s5, $s5, -1 # - i - 1
	add $s4, $s0, $s5 # n - i - 1
	li $s3, 0 # setting j to 0 each time we enter inner loop
	move $s6, $s1 # array addressing j
	add $s7, $s1, 4 # array addressing j + 1
innerFor:
	beq $s3, $s4, incrementI
	lw $v0, 0($s6)
	lw $v1, 0($s7)
	sgt $a0, $v0, $v1
	addi $s3, $s3, 1
	bne $a0, $zero, swap
swapDone:
	addi $s6, $s6, 4
	addi $s7, $s7, 4
	j innerFor

swap:
	sw $v1, 0($s6)
	sw $v0, 0($s7)
	j swapDone

incrementI: 
	addi $s2, $s2, 1
	j outerFor
				
bubbleSortDone:	
	move $v0, $s0
	move $v1, $s1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addi $sp, $sp, 32
	jr $ra
	
# PART C
processArray:
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	
	move $s0, $v0 # size
	move $s1, $v1 # starting address
	li $s2, 0 # i = 0
	move $s3, $s1 # addressing array
forProcess:
	beq $s2, $s0, processingDone
	
	# Index display
	move $a0, $s2
	li $v0, 1
	syscall
	
	# Space between number and index
	la $a0, space
	li $v0, 4
	syscall
	
	# Number display
	lw $a0, 0($s3)
	li $v0, 1
	syscall
	
	# Space between number and index
	la $a0, space
	li $v0, 4
	syscall
	
	# storing ra stack before calling digitsum 
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# digit sum
	lw $a0, 0($s3)
	jal digitSum
	
	# displaying digit sum  
	move $a0, $s5
	li $v0, 1
	syscall 
	
	# space after digit sum
	la $a0, space
	li $v0, 4
	syscall
	
	# restoring value of ra after call back from digitsum
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# storing on stack to call checkPrime
	# storing save registers 
	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	# check prime 
	lw $a0,0($s3) 
	jal checkPrime
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)
	addi $sp, $sp, 36
	
	# Next line
	la $a0, nextLine
	li $v0, 4
	syscall
	
	addi $s3, $s3, 4
	addi $s2, $s2, 1
	j forProcess

checkPrime:
	move $s2, $a0
	li $s3, 2 # initial prime
	
	beq $s2, 1, isNotPrime
	beq $s2, 2, isPrime

forPrime:
	beq $s2, $s3, isPrime
	div $s2, $s3
	mfhi $s4 
	beq $s4, $zero, isNotPrime
	addi $s3, $s3, 1
	j forPrime
		
isPrime:
	la $a0, isP
	li $v0, 4
	syscall
	jr $ra

isNotPrime:
	la $a0, noP
	li $v0, 4
	syscall
	jr $ra
		
digitSum:
	li $s5, 0 # $s0 sum
	li $s4, 10
	move $s6, $a0
forDigitSum:
	div $s6, $s4
	mflo $s6 # n / 10 
	mfhi $s7 # n % 10 
	add $s5, $s5, $s7
	bne $s6, $zero, forDigitSum
	jr $ra
	
processingDone:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addi $sp, $sp, 32
	
	jr $ra
		
	.data 
	promptForArraySizeInput: .asciiz "Enter the size of the array: "
	space: .asciiz " "
	nextLine: .asciiz "\n"
	noP: .asciiz "No"
	isP: .asciiz "Yes"	
