module hazards_unit(rst,RegWriteM,RegWriteW,RD_M,RD_W,Rs1_E,Rs2_E,ForwardBE,ForwardAE);
    input rst,RegWriteM,RegWriteW;
    input [4:0] RD_M,RD_W,Rs1_E,Rs2_E;
    output [1:0] ForwardBE,ForwardAE;
    assign ForwardAE=(rst==1'b0) ? 2'b00 : 
                                ((RegWriteM==1) & (RD_M!=5'h00) & (RD_M==Rs1_E)) ? 2'b10 :
                                ((RegWriteW==1) & (RD_W!=5'h00) & (RD_W==Rs1_E)) ? 2'b01 : 2'b00;
    assign ForwardBE=(rst==1'b0) ? 2'b00 : 
                                ((RegWriteM==1) & (RD_M!=5'h00) & (RD_M==Rs2_E)) ? 2'b10 :
                                ((RegWriteW==1) & (RD_W!=5'h00) & (RD_W==Rs2_E)) ? 2'b01 : 2'b00;                             

endmodule