`timescale 1ns / 1ps
// Hazard Unit with inputs and outputs named
// according to the convention that is followed on the book.

module HazardUnit(input logic clk, RegWriteW,
                input logic [4:0] WriteRegW,
                input logic RegWriteM,MemToRegM,
                input logic [4:0] WriteRegM, WriteRegE,
                input logic RegWriteE,MemToRegE,
                input logic [4:0] rsE,rtE,
                input logic [4:0] rsD,rtD,
                input logic BranchD,
                output logic [1:0] ForwardAE,ForwardBE,
                output logic FlushE,StallD,StallF,
                output logic ForwardAD, ForwardBD);
    logic lwstall;
    logic branchStall;
    
    always_comb
        begin
        
        if ((rsE != 0) & (rsE == WriteRegM) & RegWriteM)
            ForwardAE = 2'b10;
        else if ((rsE != 0) & (rsE == WriteRegW) & RegWriteW)
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;
        
        if ((rtE != 0) & (rtE == WriteRegM) & RegWriteM)
            ForwardBE = 2'b10;
        else if ((rtE != 0) & (rtE == WriteRegW) & RegWriteW)
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
        
        if ((rsD != 0) & (rsD == WriteRegM) & RegWriteM) ForwardAD = 1;
        else ForwardAD = 0;
        if ((rtD != 0) & (rtD == WriteRegM) & RegWriteM) ForwardBD = 1;
        else ForwardBD = 0;
        
        if (((rsD == rtE) | (rtD == rtE)) & MemToRegE) lwstall = 1;
        else lwstall = 0;   
        
        if ((BranchD & RegWriteE & ((WriteRegE == rsD) | WriteRegE == rtD))
                        | (BranchD & MemToRegM & ((WriteRegM == rsD) | (WriteRegM == rtD)))) branchStall = 1;
        else branchStall = 0;
        
        if (lwstall | branchStall) 
            begin
                StallF = 1;
                StallD = 1;
                FlushE = 1;
            end
        else 
            begin
                StallF = 0;
                StallD = 0;
                FlushE = 0;
            end
        end
endmodule