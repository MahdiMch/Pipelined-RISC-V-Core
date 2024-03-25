`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Memory_Cycle.v"
`include "Execute_Cycle.v"
`include "WriteB_Cycle.v"
`include "Hazards_Unit.v"
module Pipeline_Top(clk,rst);
    input clk,rst;
    wire PCSrcE,RegWriteW,RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,RegWriteM,MemWriteM,ResultSrcM,ResultSrcW;
    wire [4:0] RDW,RD_E,RD_M,Rs1_E,Rs2_E;
    wire [2:0] ALUControlE;
    wire [31:0] PCTargetE,InstrD,PCD,PCPlus4D,RD1_E,RD2_E,Imm_Ext_E,PCE,PCPlus4E,PCPlus4M,WriteDataM,ALU_ResultM;
    wire [31:0] ResultW,PCPlus4W,ALU_ResultW,ReadDataW;
    wire [1:0] ForwardAE,ForwardBE;
    //Declaring Fetch Cycle
    fecth_cycle Fetch (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );
    //Declaring Decode Cycle
    decode_cycle Decode(
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E)
        );
    //Declaring Execute Cycle
    execute_cycle Execute(
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .PCPlus4M(PCPlus4M),
        .MemWriteM(MemWriteM),
        .RD_M(RD_M),
        .ResultW(ResultW),
        .ForwardA_E(ForwardAE),
        .ForwardB_E(ForwardBE)
        );
    //Declaring Memory Cycle
    memory_cycle Memory (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .PCTargetE(PCTargetE),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RD_W(RDW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
        );
    //Declaring Write Back Cycle
    writeb_cycle WriteBack(
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .ResultW(ResultW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
        );
    //Hazard Unit
    hazards_unit Forwarding_block (
        .rst(rst),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .RD_M(RD_M),
        .RD_W(RDW),
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E),
        .ForwardBE(ForwardBE),
        .ForwardAE(ForwardAE)
        );

endmodule