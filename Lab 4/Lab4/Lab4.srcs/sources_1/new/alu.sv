module alu(input  logic [31:0] a, b, 
           input  logic [2:0]  alucont, 
           output logic [31:0] result,
           output logic zero);

    assign zero = (result == 0);

    always_comb
        case (alucont)
            3'b000: result = a & b; 
            3'b001: result = a | b; 
            3'b010: result = a + b; 
            3'b110: result = a - b; 
            3'b111: result = a < b; 
            default: result = {32{1'bx}}; 
    endcase
endmodule