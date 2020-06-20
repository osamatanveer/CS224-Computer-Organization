`timescale 1ns / 1ps
module datapath (input  logic clk, reset, memtoreg, pcsrc, alusrc, regdst,
                 input  logic regwrite, jump, jumpByRegister, add4ForPush,
		         input  logic[2:0]  alucontrol, 
                 output logic zero, 
		         output logic[31:0] pc, 
	             input  logic[31:0] instr,
                 output logic[31:0] aluout, writedata, 
	             input  logic[31:0] readdata);

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, temp, dataToWrite, tempSrcB;
  logic [31:0] tempForALU, tempForA1Selection, tempForA3Selection;
  logic [31:0] signimm, signimmsh, srca, srcb, result;
 
  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(pc, 32'b100, pcplus4);
  sl2         immsh(signimm, signimmsh);
  adder       pcadd2(pcplus4, signimmsh, pcbranch);
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc,
                      pcnextbr);
  //jalr
  mux2 #(32) muxForJalr({pcplus4[31:28], 
                    instr[25:0], 2'b00}, srca, jumpByRegister, temp);
  
  mux2 #(32)  pcmux(pcnextbr, temp, jump, pcnext);

// register file logic
    mux2 #(32) wdChoose(result, pcplus4, jumpByRegister, dataToWrite);
    
    mux2 #(5) a1chooseMux(instr[25:21], 5'd29, add4ForPush, tempForA1Selection); // This mux added
        
    regfile     rf (clk, regwrite, tempForA1Selection, instr[20:16], writereg,
                   dataToWrite, srca, writedata);
    
    mux2 #(5)    wrmux (instr[20:16], instr[15:11], regdst, tempForA3Selection);
    
    mux2 #(5) a3chooseMux(tempForA3Selection, 5'd29, add4ForPush ,writereg); // This mux added
    
    mux2 #(32)  resmux (aluout, readdata, memtoreg, result);
    signext         se (instr[15:0], signimm);
    
    // ALU logic
    mux2 #(32)  srcbmux (writedata, signimm, alusrc, tempForALU);
    mux2 #(32) srcbor4(tempForALU, 32'd4, add4ForPush, srcb); // This mux added
    alu         alu (srca, srcb, alucontrol, aluout, zero);

endmodule