`include "PC.v"
`include "PC_Adder.v"
//`include "Mux.v"
`include "Instruction_Memory.v"
module fecth_cycle(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);
input clk,rst;
input PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD;
output [31:0] PCD,PCPlus4D;
wire [31:0] PC_F,PCF,PCPlus4F;
wire [31:0] InstrF;
reg [31:0] InstrF_reg;
reg [31:0] PCF_reg,PCPlus4F_reg;
Mux PC_MUX(
    .a(PCPlus4F),
    .b(PCTargetE),
    .s(PCSrcE),
    .c(PC_F)
);
Pc Program_Counter(
    .clk(clk),
    .rst(rst),
    .PC(PCF),
    .PC_NEXT(PC_F)
);
Instruction_Memory IMEM(
    .rst(rst),
    .A(PCF),
    .RD(InstrF)
);
PC_Adder pc_adder(
    .a(PCF),
    .b(32'h00000004),
    .c(PCPlus4F)
);
//Fecth cycle 
always @(posedge clk or negedge rst) begin 
    if (rst==1'b0)begin
        InstrF_reg <= 32'h00000000;
        PCF_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
     end
    else begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;

    end 

end 
assign InstrD=(rst==1'b0) ? 32'h00000000:InstrF_reg;
assign PCD=(rst==1'b0) ? 32'h00000000:PCF_reg;
assign PCPlus4D=(rst==1'b0) ? 32'h00000000:PCPlus4F_reg;

endmodule
