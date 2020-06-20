`timescale 1ns / 1ps
module PipeEtoM(input logic clk, reset, 
                input logic RegWriteE, MemtoRegE, MemWriteE,
                input logic [31:0] ALUOutE, WriteDataE,
                input logic [4:0] WriteRegE,
                output logic RegWriteM, MemtoRegM, MemWriteM,
                output logic [31:0] ALUOutM, WriteDataM,
                output logic [4:0] WriteRegM);
                
    always_ff @ (posedge clk)
        begin
            // If reset, set everything 0
            if (reset) 
                begin
                    RegWriteM <= 0;
                    MemtoRegM <= 0;
                    MemWriteM <= 0;
                    ALUOutM <= 32'd0;
                    WriteDataM <= 32'd0;
                    WriteRegM <= 5'd0;
                end
            // else, propogate data
            else
                begin
                    RegWriteM <= RegWriteE;
                    MemtoRegM <= MemtoRegE;
                    MemWriteM <= MemWriteE;
                    ALUOutM <= ALUOutE;
                    WriteDataM <= WriteDataE;
                    WriteRegM <= WriteRegE;
                end
            
        end

endmodule
