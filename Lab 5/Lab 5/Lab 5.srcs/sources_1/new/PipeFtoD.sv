`timescale 1ns / 1ps

module PipeFtoD(input logic[31:0] instr, PcPlus4F,
                input logic reset, EN, clk, clr,		// StallD will be connected as this EN
                output logic[31:0] instrD, PcPlus4D);

    always_ff @(posedge clk)
        begin
        if (clr | reset) 
            begin
                instrD <= 32'd0;
                PcPlus4D <= 32'd0;
            end
        if (EN)
            begin
            instrD<=instr;
            PcPlus4D<=PcPlus4F;
            end
        end        
endmodule