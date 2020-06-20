`timescale 1ns / 1ps

module processor_tb();

    logic clk, reset;
    logic [31:0] regf [31:0];
    logic [31:0] RAM[63:0];
    
    processor dut(clk, reset, regf, RAM);  
    
    initial 
        begin
            clk = 0;
            reset = 1; #20;
            reset = 0;
        end  
    
    always
        begin
            #20; clk = ~clk;
        end    
        
endmodule
