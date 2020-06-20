`timescale 1ns / 1ps

module processor (input logic clk, reset,
                  output logic [31:0] regf [31:0],
                  output logic [31:0] RAM[63:0]); 

    logic [31:0] pcPlus4F, pcBranchD, pcDash, pcF, instr, instrD, pcPlus4D;
    logic [4:0]WriteRegW;
    logic [31:0] rd1, rd2;
    logic RegWriteD, MemToRegD, MemWriteD;
    logic [2:0] ALUControlD;
    logic ALUSrcD, RegDstD, branchD;
    logic [31:0] signImmD;
    logic [31:0] signImmDAfterShift;
    logic stallF, stallD, FlushE;
    logic [31:0] outMux1D, outMux2D;
    logic equalD, pcSrcD;
    logic ForwardAD, ForwardBD;
    logic RegWriteE, MemToRegE, MemWriteE, ALUSrcE, RegDstE;
    logic [2:0] ALUControlE;
    logic [4:0] rsE, rtE, rdE, WriteRegE;
    logic [31:0] SignImmE, rd1E, rd2E;
    logic [31:0] ResultW, SrcAE, SrcBE, WriteDataE, aluOutput; 
    logic zero; // ALU Signal
    
    logic RegWriteM, MemToRegM, MemWriteM;
    logic [31:0] ALUOutM, WriteDataM, rdW, ReadDataM;
    logic [4:0] WriteRegM;
    logic [31:0] rdM;    
    
    logic RegWriteW, MemToRegW;
    logic [31:0] ReadDataW, ALUOutW;
    logic [31:0] rd1D, rd2D;
    logic [4:0] rsD, rtD, rdD;
    
    logic [31:0] tempRegFile [31:0];
    logic [31:0] tempRAM[63:0];
    
    logic [1:0] ForwardAE, ForwardBE;
    
	// before FtoD reg
	mux2 #(32) pcSelectMux(pcPlus4F, pcBranchD, pcSrcD, pcDash);
	flopr #(32) pcReg(clk, reset, ~stallF , pcDash, pcF);
	imem im(pcF[7:2], instr);
	adder fAdder(pcF, 32'd4, pcPlus4F);
	
	PipeFtoD ftd(instr, pcPlus4F, reset, ~stallD, clk, pcSrcD, instrD, pcPlus4D);
    	
	// after FtoDReg before DtoEReg
    
	regfile rf(clk, RegWriteW, instrD[25:21], instrD[20:16], WriteRegW, ResultW, rd1, rd2, tempRegFile);
	controller ctrlr(instrD[31:26], instrD[5:0], RegWriteD, MemToRegD, MemWriteD, 
	                ALUControlD, ALUSrcD, RegDstD, branchD);
	signext se(instrD[15:0], signImmD);
	sl2 shift(signImmD, signImmDAfterShift);
	adder dAdder(signImmDAfterShift, pcPlus4D, pcBranchD);                
	mux2 #(32) rd1mux(rd1, ALUOutM, ForwardAD, outMux1D);
	mux2 #(32) rd2mux(rd2, ALUOutM, ForwardBD, outMux2D);
	equal checkEqual(outMux1D, outMux2D, equalD);
    and2 andD(equalD, branchD, pcSrcD);
    

    PipeDtoE dte(clk, reset, FlushE, RegWriteD, MemToRegD, MemWriteD, ALUControlD, 
                ALUSrcD, RegDstD, rd1, rd2, instrD[25:21], instrD[20:16], instrD[15:11], signImmD,
                RegWriteE, MemToRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE,
                rd1E, rd2E, rsE, rtE, rdE, SignImmE); // clr missing
    
    // after DtoEReg before EtoMReg
    mux2 #(5) regSelMux(rtE, rdE, RegDstE, WriteRegE);
    mux3 #(32) srcAEMux(rd1E, ResultW, ALUOutM, ForwardAE, SrcAE);            
	mux3 #(32) srcBE1stMux(rd2E, ResultW, ALUOutM, ForwardBE, WriteDataE);
	mux2 #(32) srcBE2ndMux(WriteDataE, SignImmE, ALUSrcE, SrcBE);
	
	alu ALU(SrcAE, SrcBE, ALUControlE , aluOutput, zero);
	
	PipeEtoM etm(clk, reset, RegWriteE, MemToRegE, MemWriteE,
	             aluOutput, WriteDataE, WriteRegE, 
	             RegWriteM, MemToRegM, MemWriteM, ALUOutM, 
	             WriteDataM, WriteRegM);   
	
	// after EtoMReg before MtoWReg
	dmem dm(clk, MemWriteM, ALUOutM, WriteDataM, rdM, tempRAM);
	
	PipeMtoW mtw(clk, reset, RegWriteM, MemToRegM, rdM, ALUOutM, 
                WriteRegM, RegWriteW, MemToRegW, rdW, ALUOutW, WriteRegW);
	
	mux2 #(32) be2ndMux(ALUOutW, rdW, MemToRegW, ResultW);
	
	HazardUnit hu(clk, RegWriteW, WriteRegW, RegWriteM, MemToRegM, WriteRegM, WriteRegE,
	               RegWriteE, MemToRegE, rsE, rtE, rsD, rtD, branchD, 
	               ForwardAE, ForwardBE, FlushE, stallD, stallF, ForwardAD, ForwardBD);
	
	assign regf = tempRegFile;
	assign RAM = tempRAM;
	
endmodule