module Tb();
//Declare I/O
reg clk=0,rst,PCSrcE;
reg [31:0] PCTargetE;
wire [31:0] InstrD,PCD,PCPlus4D;
fecth_cycle fctb (
    .clk(clk),
    .rst(rst),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
    );
    always begin
        clk=~clk;
        #50;
    end
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        PCSrcE <= 1'b0;
        PCTargetE <= 32'h00000000;
        #500;
        $finish;   
    end 
    //Generating VCD file to capture the changes in signal values during simulation . 
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
endmodule