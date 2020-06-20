`timescale 1ns / 1ps
module maindec (input logic[5:0] op, 
                input logic[5:0] funct, 
	              output logic memtoreg, memwrite, branch,
	              output logic alusrc, regdst, regwrite, jump, jumpByRegister, add4ForPush,
	              output logic[1:0] aluop);
   logic [10:0] controls;

   assign {regwrite, regdst, alusrc, branch, memwrite,
                memtoreg,  aluop, jump, jumpByRegister, add4ForPush} = controls;

  always_comb
    begin
        case(op)
          6'b000000: 
            if (funct == 6'b001001) controls <= 11'b11000000110; //jalr
            else controls <= 11'b11000010000; // R-type
          6'b100011: controls <= 11'b10100100000; // LW
          6'b101011: controls <= 11'b00101000000; // SW
          6'b000100: controls <= 11'b00010001000; // BEQ
          6'b001000: controls <= 11'b10100000000; // ADDI
          6'b000010: controls <= 11'b00000000100; // J
          6'b000001: controls <= 11'b10001001001; // PUSH
          default:   controls <= 11'bxxxxxxxxxx; // illegal op
        endcase
    end
endmodule