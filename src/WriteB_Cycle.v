//`include "Mux.v"
module writeb_cycle(clk,rst,ResultSrcW,ResultW,PCPlus4W,ALU_ResultW,ReadDataW);
input clk,rst,ResultSrcW;
input [31:0] PCPlus4W,ALU_ResultW,ReadDataW;
output [31:0] ResultW;
Mux result_mux(
    .a(ALU_ResultW),
    .b(ReadDataW),
    .s(ResultSrcW),
    .c(ResultW)
);
endmodule