	.text
	.globl __main
	.eqv shift_amount 4
__main:
	# storing word in memory
	lui $a0, 0xAA00
	ori $a0, 0x00BB
	sw $a0, int
	# shift amount 
	li $a1, shift_amount
	jal shiftLeftCircular
		
	move $a0, $v0
	li $v0, 34
	syscall
	
	li $v0, 4
	la $a0, nextLine
	syscall
	
	lw $a0, int
	li $a1, shift_amount
	jal shiftRightCircular
	
	move $a0, $v0
	li $v0, 34
	syscall
			
	li $v0, 10
	syscall
		
shiftLeftCircular:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	move $s0, $a0
	move $s1, $a1
	# remaining bits
	li $s2, 32
	sub $s2, $s2, $s1
	srlv $s3, $s0, $s2
	
	sll $s0, $s0, shift_amount
	or $s0, $s0, $s3
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16
	jr $ra
	
shiftRightCircular:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	move $s0, $a0
	move $s1, $a1
	# remaining bits
	li $s2, 32
	sub $s2, $s2, $s1
	sllv $s3, $s0, $s2
	
	srl $s0, $s0, shift_amount
	or $s0, $s0, $s3
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16
	jr $ra
					
	.data
	int: .word
	nextLine: .asciiz "\n"
	