`include "ALU_Decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(
    input [6:0] op,
    input [2:0] funct3,
    input [6:0] funct7,
    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output ResultSrc,
    output Branch,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

wire [1:0] ALUOp;

main_decoder Main_Decoder(
    .op(op),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    //.Branch(Branch),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp)
);

ALU_Decoder ALU_Decoder(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .op5(op),
    .ALUControl(ALUControl)
);

endmodule
