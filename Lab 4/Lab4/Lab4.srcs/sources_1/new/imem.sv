`timescale 1ns / 1ps
// External instruction memory used by MIPS single-cycle
// processor. It models instruction memory as a stored-program 
// ROM, with address as input, and instruction as output


module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})		   	// word-aligned fetch
//		address		instruction
//		-------		-----------
		8'h00: instr = 32'h20020005;  	// disassemble, by hand 
		8'h04: instr = 32'h2003000c;  	// or with a program,
		8'h08: instr = 32'h00432025;  	// to find out what
		8'h0c: instr = 32'h00432824;  	// this program does!
		8'h10: instr = 32'h00A43020;     
		8'h14: instr = 32'h10A60002;
		8'h18: instr = 32'h0043382A;
		8'h1c: instr = 32'h00434022;
		8'h20: instr = 32'hAC670068;
		8'h24: instr = 32'h8C780068;
        8'h28: instr = 32'h201d003f; // addi $sp, $zero, 63
        8'h2c: instr = 32'h4030000;  // push $v1
        8'h30: instr = 32'h4030000;  // push $v1
        8'h34: instr = 32'h00a0e809; // jalr $v0, $a1  
	     default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule