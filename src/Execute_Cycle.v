`include "ALU.v"
`include "Mux.v"
//`include "PC_Adder.v"
module execute_cycle(clk,rst,RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,ALUControlE,RD1_E,RD2_E,Imm_Ext_E,RD_E,PCE,ResultW,PCPlus4E,PCSrcE,PCTargetE,WriteDataM,ALU_ResultM,RegWriteM,ResultSrcM,PCPlus4M,MemWriteM,RD_M,ForwardA_E,ForwardB_E);
    input clk,rst,RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE;
    input [31:0] ResultW,RD1_E,RD2_E,Imm_Ext_E,PCE,PCPlus4E;
    input [2:0] ALUControlE;
    input [4:0] RD_E;
    input [1:0] ForwardA_E,ForwardB_E;
    output [31:0] PCTargetE;
    output PCSrcE,RegWriteM,MemWriteM,ResultSrcM;
    output [4:0] RD_M;
    output [31:0] PCPlus4M,WriteDataM,ALU_ResultM;
    wire [31:0] Src_A,Src_B_i,SrcB;
    wire [31:0] ResultE;
    wire ZeroE;
    reg RegWriteE_r,MemWriteE_r,ResultSrcE_r;
    reg RD_E_r;
    reg PCPlus4E_r,RD2_E_r,ResultE_r;
    Mux_3_by_1 srca_mux(
        .a(RD2_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardB_E),
        .d(Src_B_i)
    );
    Mux_3_by_1 srcb_mux(
        .a(RD1_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardA_E),
        .d(Src_A)
    );
    Mux alu_src_mux(
        .a(Src_B_i),
        .b(Imm_Ext_E),
        .s(ALUSrcE),
        .c(SrcB));
    ALU alu (
        .A(RD1_E),
        .B(SrcB),
        .ALUControl(ALUControlE),
        .Result(ResultE),
        .Z(),
        .N(),
        .C(),
        .V());
    PC_Adder branch_adder(
        .a(PCE),
        .b(Imm_Ext_E),
        .c(PCTargetE)

    );
    always @(posedge clk or negedge rst ) begin
        if (rst==1'b0) begin 
            RegWriteE_r <= 1'b0 ;
            ResultSrcE_r <= 1'b0 ;
            MemWriteE_r <= 1'b0 ;
            RD_E_r <= 5'h00 ;
            PCPlus4E_r <= 32'h00000000 ;
            RD2_E_r <= 32'h00000000 ;
            ResultE_r <= 32'h00000000 ;

        end 
        else begin
            RegWriteE_r <= RegWriteE ;
            ResultSrcE_r <= ResultSrcE ;
            MemWriteE_r <= MemWriteE ;
            RD_E_r <= RD_E ;
            PCPlus4E_r <= PCPlus4E ;
            RD2_E_r <= Src_B_i ;
            ResultE_r <= ResultE ;
        end 
    end 
    assign PCSrcE =(rst==1'b0) ? 1'b0 : ZeroE & BranchE;
    assign WriteDataM = RD2_E;
    assign ALU_ResultM = ResultE_r;
    assign RegWriteM = RegWriteE;
    assign ResultSrcM = ResultSrcE;
    assign MemWriteM = MemWriteE;
    assign PCPlus4M = PCPlus4E;
    assign RD_M = RD_E;
endmodule