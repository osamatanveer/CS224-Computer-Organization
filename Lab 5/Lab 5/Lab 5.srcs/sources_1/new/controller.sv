`timescale 1ns / 1ps

module controller(input  logic[5:0] op, funct,
                  output logic     regwrite, memtoreg,
                  output logic     memwrite,
                  output logic[2:0] alucontrol,
                  output logic     alusrc, regdst,
                  output logic     branch);

   logic [1:0] aluop;

   maindec md (op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, 
         jump, aluop);

   aludec  ad (funct, aluop, alucontrol);

endmodule