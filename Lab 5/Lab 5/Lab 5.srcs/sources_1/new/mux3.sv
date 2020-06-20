`timescale 1ns / 1ps

module mux3 #(parameter WIDTH = 8)
             (input  logic[WIDTH-1:0] d0, d1, d2,  
              input  logic [1:0] s, 
              output logic[WIDTH-1:0] y);
    always_comb
        begin
            if (~s[1] & ~s[0]) y <= d0;
            else if (~s[1] & s[0]) y <= d1;
            else if (s[1] & ~s[0]) y <= d2;
        end
    
endmodule
