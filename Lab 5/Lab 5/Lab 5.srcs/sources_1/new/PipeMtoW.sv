`timescale 1ns / 1ps

module PipeMtoW(input logic clk, reset,
                input logic RegWriteM, MemtoRegM,
                input logic [31:0] ReadDataM, ALUOutM, 
                input logic [4:0] WriteRegM,
                output logic RegWriteW, MemtoRegW,
                output logic [31:0] ReadDataW, ALUOutW,
                output logic [4:0] WriteRegW);

    always_ff @ (posedge clk)
        begin
            // if reset, set everything 0
            if (reset)
                begin
                    RegWriteW <= 0;
                    MemtoRegW <= 0;
                    ReadDataW <= 32'd0;
                    ALUOutW <= 32'd0;
                    WriteRegW <= 5'd0;
                end
            // else, propogate data    
            else 
                begin
                    RegWriteW <= RegWriteM;
                    MemtoRegW <= MemtoRegM;
                    ReadDataW <= ReadDataM;
                    ALUOutW <= ALUOutM;
                    WriteRegW <= WriteRegM; 
                end
        end
endmodule