`timescale 1ns / 1ps

module PipeDtoE(input logic clk, reset, clr, 
                input logic RegWriteD, MemtoRegD, MemWriteD,
                input logic [2:0] ALUControlD, 
                input logic ALUSrcD, RegDstD,
                input logic [31:0] rd1D, rd2D, 
                input logic [4:0] rsD, rtD, rdD,
                input logic [31:0] signImmD,
                output logic RegWriteE, MemToRegE, MemWriteE,
                output logic [2:0] ALUControlE,
                output logic ALUSrcE, RegDstE,
                output logic [31:0] rd1E, rd2E,
                output logic [4:0] rsE, rtE, rdE,
                output logic [31:0] signImmE);
                
    always_ff @ (posedge clk, posedge reset)
        begin
            // Setting register to default on the start
            if (reset | clr) 
                begin
                    RegWriteE <= 0;
                    MemToRegE <= 0;
                    MemWriteE <= 0;
                    ALUControlE <= 3'b000;
                    ALUSrcE <= 0;
                    RegDstE <= 0;
                    rd1E <= 32'd0;
                    rd2E <= 32'd0;
                    rsE <= 5'd0;
                    rtE <= 5'd0;
                    rdE <= 5'd0;
                    signImmE <= 32'd0;
                end
            else
                begin
                    RegWriteE <= RegWriteD;
                    MemToRegE <= MemtoRegD;
                    MemWriteE <= MemWriteD;
                    ALUControlE <= ALUControlD;
                    ALUSrcE <= ALUSrcD;
                    RegDstE <= RegDstD;
                    rd1E <= rd1D;
                    rd2E <= rd2D;
                    rsE <= rsD;
                    rtE <= rtD;
                    rdE <= rdD;
                    signImmE <= signImmD;
                end
        end

endmodule
