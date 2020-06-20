`timescale 1ns / 1ps

// parameterized register
module flopr #(parameter WIDTH = 8)
              (input logic clk, reset, en, 
	       input logic[WIDTH-1:0] d, 
               output logic[WIDTH-1:0] q);

  always_ff@(posedge clk, posedge reset)
    begin
        if (reset) q <= 0; 
        else       q <= d;
        if (~en) q <= d;
    end
endmodule