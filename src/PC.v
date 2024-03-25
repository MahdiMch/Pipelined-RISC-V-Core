module Pc(
    input [31:0] PC_NEXT,
    input clk,
    input rst,
    output reg [31:0] PC
);
    always @(posedge clk) begin
        if (rst)
            PC <= 32'h0;
        else
            PC <= PC_NEXT;
    end
endmodule
