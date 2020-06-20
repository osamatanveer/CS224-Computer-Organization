`timescale 1ns / 1ps

module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})
//		address		instruction
//		-------		-----------
//      UNCOMMENT BELOW TO TEST USING NO HAZARD INSTRUCTIONS
		8'h00: instr = 32'h20080010; //addi $t0, $zero, 0x0010
		8'h04: instr = 32'h20090015; //addi $t1, $zero, 0x0015
		8'h08: instr = 32'h200A0012; //addi $t2, $zero, 0x0012
		8'h0c: instr = 32'h200B0010; //addi $t3, $zero, 0x0010 
		8'h10: instr = 32'h200C0018; //addi $t4, $zero, 0x0018
		8'h14: instr = 32'h21100007; //addi $s0, $t0, 0x0007
		8'h18: instr = 32'hAC080004; //sw $t0, 0x0004($zero)
		8'h1c: instr = 32'h01098820; //add $s1, $t0, $t1
		8'h20: instr = 32'h01495025; //or $t2, $t2, $t1
		8'h24: instr = 32'h0100A82A; //slt $s5, $t0, $zero
		8'h28: instr = 32'h016CB024; //and $s6, $t3, $t4
		8'h2c: instr = 32'h01284822; //sub $t1, $t1, $t0
		8'h30: instr = 32'h8C1F0004; //lw $ra, 0x0004($zero)
		8'h34: instr = 32'h110BFFFB; //beq $t2, $s0, 0xFFFB

//      UNCOMMENT BELOW TO TEST WHEN COMPUTE HAZARDS OCCUR
//        8'h00: instr = 32'h20080015; //addi $t0, $zero, 0x0015
//        8'h04: instr = 32'h21090010; //addi $t1, $t0, 0x0010
//        8'h08: instr = 32'h01285020; //add $t2, $t1, $t0

//      UNCOMMENT BELOW TO TEST WHEN LOAD USE HAZARDS OCCUR
//        8'h00: instr = 32'h20080015; //addi $t0, $zero, 0x0015
//		8'h04: instr = 32'h20090010; //addi $t1, $zero, 0x0010
//		8'h08: instr = 32'h20100007; //addi $s0, $zero, 0x0007 
//		8'h0c: instr = 32'h20110008; //addi $s1, $zero, 0x0008
//		8'h10: instr = 32'hAC080000; //sw $t0, 0x0000($zero)
//		8'h14: instr = 32'h8C030000; //lw $v1, 0x0000($zero)
//		8'h18: instr = 32'h00701022; //sub $v0, $v1, $s0

//      UNCOMMENT BELOW TO TEST WHEN BRANCH HAZARDS OCCUR
//        8'h00: instr = 32'h20080000; //addi $t0, $zero, 0x0000
//		8'h04: instr = 32'h11000002; //beq $t0, $zero, 0x0002 
//		8'h08: instr = 32'h20090004; //addi $t1, $zero, 0x0004
//		8'h0c: instr = 32'h21090001; //addi $t1, $t0, 0x0001
//		8'h10: instr = 32'h21090002; //addi $t1, $t0, 0x0002
//		8'h14: instr = 32'h20090003; //addi $t1, $zero, 0x0003
//		8'h18: instr = 32'hAC090000; //sw $t1, 0x0000($zero)        
        
        default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule