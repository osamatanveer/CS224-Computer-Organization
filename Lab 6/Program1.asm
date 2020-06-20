	.text
	.globl __main
	
__main:
	# Menu display 	
	la $a0, menuOp1
	li $v0, 4
	syscall
	
	la $a0, menuOp2
	li $v0, 4
	syscall
	
	la $a0, menuOp3
	li $v0, 4
	syscall
	
	la $a0, menuOp4
	li $v0, 4
	syscall
	
	la $a0, menuOp5
	li $v0, 4
	syscall
	
	la $a0, menuOp6
	li $v0, 4
	syscall
	
	la $a0, menuOp7
	li $v0, 4
	syscall
	
	la $a0, menuOp8
	li $v0, 4
	syscall
	
	la $a0, menuTitle
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, option1
	beq $v0, 2, option2
	beq $v0, 3, option3
	beq $v0, 4, option4
	beq $v0, 5, option5
	beq $v0, 6, option6
	beq $v0, 7, option7
	beq $v0, 8, option8
	j __main
	
# reading dimensions	
option1:
	# Getting N
	la $a0, inputDim
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # $s0 - N
	mul $t0, $s0, $s0 # $t0 - NxN
	
	# Allocating in heap
	move $a0, $t0
	li $v0, 9
	syscall
	
	move $s1, $v0 # $s1 - starting address of array in heap
	
	j __main		

option2:
	la $a0, inputMatrix
	li $v0, 4
	syscall
	
	
	move $t0, $s0 # n
	move $t1, $s1 # starting address
	mul $t0, $t0, $t0
	
	addi $t2, $zero, 1 # i - row
 	addi $t3, $zero, 1 # j - column
 	
 	addi $t4, $zero, 0
 	addi $t5, $zero, 0
 	
outerWhile: # i
	bgt $t2, $s0, outerWhileDone
	innerWhile: # j
		bgt $t3, $s0, innerWhileDone
		move $t4, $t3
		addi $t4, $t4, -1
		mul $t4, $t4, $s0
		sll $t4, $t4, 2
		move $t5, $t2
		addi $t5, $t5, -1
		sll $t5, $t5, 2
		add $t6, $t4, $t5 
		
		add $t7, $t6, $t1 
		li $v0, 5
		syscall
		sw $v0, 0($t7)
		
		addi $t3, $t3, 1
		j innerWhile
	innerWhileDone:
		addi $t2, $t2, 1
		addi $t3, $zero, 1
		j outerWhile
outerWhileDone:
	j __main			

option3:
	la $a0, enterPosI
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 # t0 - i
	
	la $a0, enterPosJ
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 #t1 - j
	
	addi $t1, $t1, -1
	mul $t1, $t1, $s0
	sll $t1, $t1, 2
	addi $t0, $t0, -1
	sll $t0, $t0, 2
	add $a0, $t1, $t0
	
	add $a0, $a0, $s1
	
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
			
	j __main
	
option4:
	# row major
	move $t0, $s0 # n
	move $t1, $s1 # starting address
	
	addi $s2, $zero, 0
	
	addi $t2, $zero, 1 # i
	addi $t3, $zero, 1 # j
	
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	
outerWhileCM: # i
	bgt $t2, $s0, outerWhileCMDone
	innerWhileCM: # j
		bgt $t3, $s0, innerWhileCMDone
		addi $t4, $t2, -1
		mul $t4, $t4, $s0
		sll $t4, $t4, 2
		
		addi $t5, $t3, -1
		sll $t5, $t5, 2
		add $a0, $t4, $t5
		add $a0, $s1, $a0
		lw $a0, 0($a0)
		add $s2, $s2, $a0		
		addi $t3, $t3, 1
		j innerWhileCM
	innerWhileCMDone:
		addi $t3, $zero, 1
		addi $t2, $t2, 1
		j outerWhileCM
outerWhileCMDone:
	move $a0, $s2
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	j __main

option5:
	addi $t2, $zero, 1 # i
	addi $t3, $zero, 1 # j
	
	addi $s3, $zero, 0
	
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	
outerWhileRM: # i
	bgt $t2, $s0, outerWhileRMDone
	innerWhileRM: # j
		bgt $t3, $s0, innerWhileRMDone
		addi $t4, $t2, -1
		sll $t4, $t4, 2
		
		addi $t5, $t3, -1
		mul $t5, $t5, $s0
		sll $t5, $t5, 2
		
		add $a0, $t4, $t5
		
		add $a0, $s1, $a0
		lw $a0, 0($a0)
		add $s3, $s3, $a0
		 		
		addi $t3, $t3, 1
		j innerWhileRM
	innerWhileRMDone:
		addi $t3, $zero, 1
		addi $t2, $t2, 1
		j outerWhileRM
outerWhileRMDone:
	move $a0, $s3
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	j __main

option6:
	la $a0, selectRowOrColumn
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t4, $v0 # t4 - row col no
	
	beq $v0, $zero, rowDisplay
	beq $v0, 1, columnDisplay
			
rowDisplay:
	la $a0, enterRowOrColumnNumber
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	addi $t0, $zero, 1 # j
	move $t1, $s1 # starting address
	
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	
loop:	bgt $t0, $s0, op6Done
	addi $t3, $t0, -1
	mul $t3, $t3, $s0
	sll $t3, $t3, 2
	addi $t4, $t2, -1
	sll $t4, $t4, 2
	add $t3, $t3, $t4
	add $t5, $t3, $s1
	
	lw $a0, 0($t5)
	li $v0, 1
	syscall
	la $a0, space,
	li $v0, 4
	syscall
	addi $t0, $t0, 1
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	j loop 

columnDisplay:
	la $a0, enterRowOrColumnNumber
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	addi $t0, $zero, 1 # j
	move $t1, $s1 # starting address
	
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	
loopColumn:
	bgt $t0, $s0, op6Done
	addi $t3, $t0, -1
	
	sll $t3, $t3, 2
	addi $t4, $t2, -1
	mul $t4, $t4, $s0
	sll $t4, $t4, 2
	add $t3, $t3, $t4
	add $t5, $t3, $s1
	
	lw $a0, 0($t5)
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	j loopColumn
	 										
op6Done:
	la $a0, newLine
	li $v0, 4
	syscall									
	j __main
							
option7:
	#la $a0, enterN
	#li $v0, 4
	#syscall
	
	#li $v0, 5
	#syscall
	
	#move $s0, $v0 # s0 - n
	addi $s0, $s0, 50
	mul $a0, $s0, $s0
	li $v0, 9
	syscall
	move $s1, $v0
	
	# s0 -n s1- starting addres
	move $t0, $s0 # n
	move $t1, $s1 # starting address
	mul $t0, $t0, $t0
	
	addi $t2, $zero, 1 # i - row
 	addi $t3, $zero, 1 # j - column
 	
 	addi $t4, $zero, 0
 	addi $t5, $zero, 0
 	
outerWhileN: # i
	bgt $t2, $s0, outerWhileDoneN
	innerWhileN: # j
		bgt $t3, $s0, innerWhileDoneN
		move $t4, $t3
		addi $t4, $t4, -1
		mul $t4, $t4, $s0
		sll $t4, $t4, 2
		move $t5, $t2
		addi $t5, $t5, -1
		sll $t5, $t5, 2
		add $t6, $t4, $t5 
		add $t7, $t6, $t1 
		li $a1, 10
		li $v0, 42
		syscall
		sw $a0, 0($t7)
		addi $t3, $t3, 1
		j innerWhileN
	innerWhileDoneN:
		addi $t2, $t2, 1
		addi $t3, $zero, 1
		j outerWhileN
outerWhileDoneN:
	j __main
			
option8:
	li $v0, 10
	syscall
	
	.data
	newLine: .asciiz "\n"
	menuTitle: .asciiz "What would you like to do? "
	menuOp1: .asciiz "1. Enter the dimensions of the matrix.\n"
	menuOp2: .asciiz "2. Enter the contents of the matrix(one at a time and row wise). \n"
	menuOp3: .asciiz "3. Enter position to access the matrix element at this position.\n"
	menuOp4: .asciiz "4. Get row major summation of matrix.\n"
	menuOp5: .asciiz "5. Get column major summation of matrix.\n"
	menuOp6: .asciiz "6. Get whole column or row.\n"
	menuOp7: .asciiz "7. Create a matrix of size N and initialize randomly.\n"
	menuOp8: .asciiz "8. Exit\n"
	
	inputDim: .asciiz "Dimension N for NxN matrix: "
	inputMatrix: .asciiz "Enter contents of matrix one-by-one row wise: \n"
	enterPosI: .asciiz "Enter the row number: "
	enterPosJ: .asciiz "Enter the column number: "
	enterN: .asciiz "Enter the value of N: "
	selectRowOrColumn: .asciiz "Enter 0 for row display, 1 for column display: "	
	enterRowOrColumnNumber: .asciiz "Enter row or column number: "
	space: .asciiz " "