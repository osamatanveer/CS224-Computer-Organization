`timescale 1ns / 1ps

module top_tb();

logic[31:0] writeData, dataAdr;
logic clk, reset, memWrite;

top dut(clk, reset, writeData, dataAdr, memWrite);

initial 
    begin
        clk = 0;
        reset = 1; #20ns; 
        reset = 0; 
    end
    
always
    begin
        #20; clk = ~clk; 
    end
    
endmodule
