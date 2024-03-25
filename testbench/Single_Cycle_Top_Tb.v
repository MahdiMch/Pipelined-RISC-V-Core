`timescale 1ns/1ps

module Single_Cycle_Top_Tb();

    reg clk = 0;
    reg rst = 1;
    
    wire [31:0] PC_Top, RD_Instr, Imm_Ext_Top, Result, ReadData, PCPlus4;
    wire [31:0] RD1_Top, RD2_Top;
    wire RegWrite, ImmSrc, MemWrite;
    wire [2:0] ALUControl_Top;

    // Instantiate the DUT (Design Under Test)
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst),
        .PC_Top(PC_Top),
        .RD_Instr(RD_Instr),
        .Imm_Ext_Top(Imm_Ext_Top),
        .Result(Result),
        .ReadData(ReadData),
        .PCPlus4(PCPlus4),
        .RD1_Top(RD1_Top),
        .RD2_Top(RD2_Top),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ALUControl_Top(ALUControl_Top)
    );
    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        #10 rst = 0;
        #50 rst = 1;
        #200 $finish; // End simulation after 200 time units
    end

    // Your simulation stimuli and checks go here
    
endmodule
