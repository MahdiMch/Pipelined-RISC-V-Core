module Tb();
    reg clk=0,rst;
     always begin
        clk=~clk;
        #50;
    end
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        #1000;
        $finish;   
    end 
    //Generating VCD file to capture the changes in signal values during simulation . 
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
    Pipeline_Top dut (
        .clk(clk),
        .rst(rst)
    );
endmodule