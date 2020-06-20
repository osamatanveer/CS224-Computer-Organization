`timescale 1ns / 1ps

module equal(input logic [31:0] a, b, 
            output logic y);
    always_comb
        if (a == b) y = 1;
        else y = 0;            
endmodule
