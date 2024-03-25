module Instruction_Memory(
    input [31:0] A,
    input rst,
    output [31:0] RD
);
    reg [31:0] Mem[1023:0]; // Creation of memory

    assign RD = (rst == 1'b0) ? Mem[A[31:2]] : 32'h0;

    initial begin
        //Mem[0] = 32'hFFC4A303;
        //Mem[1] = 32'h00832383;
        Mem[0] = 32'h0064A423;
        
    end
endmodule
