module ALU(A,B,ALUControl,Result,Z,N,C,V);
    input [31:0] A;
    input [31:0] B;
    input [2:0] ALUControl;
    output [31:0] Result;
    output Z,N,C,V;
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1;
    wire [31:0] sum;
    wire [31:0] mux_2;
    wire [31:0] slt;
    wire cout;
    assign a_and_b = A & B;
    assign a_or_b = A | B;
    assign not_b = ~B;
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
    assign {cout, sum} = A + mux_1 + ALUControl[0]; // Addition or Subtraction
    assign slt = {31'b0, sum[31]};
    assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum :
                (ALUControl[2:0] == 3'b001) ? sum :
                (ALUControl[2:0] == 3'b010) ? a_and_b : 
                (ALUControl[2:0] == 3'b011) ? a_or_b:
                (ALUControl[2:0] == 3'b101) ? slt : 32'h0;
    assign Result = mux_2; // Result Flag
    assign Z = &(~Result); // Zero Flag
    assign N = Result[31]; // Negative Flag
    assign C = cout & (~ALUControl[1]); // Carry Flag
    assign V = (sum[31] ^ A[31]) & (~(B[31] ^ A[31] ^ ALUControl[0])) & (~ALUControl[1]); // Overflow Flag

endmodule
