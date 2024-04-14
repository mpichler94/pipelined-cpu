module adder
(
    input carryIn,
    input [7:0] Lhs,
    input [7:0] Rhs,
    input [1:0] CarrySelect,    // 0 -> 0   1 -> 1   2 -> carryIn   3 -> 0
    input aluAssert,

    output carryOut,
    output [7:0] result,
    output [7:0] mainBusOut
);

reg [8:0] data;
wire carry = CarrySelect[0] ? (CarrySelect[1] ? 1'b0 : 1'b1) : (CarrySelect[1] ? carryIn : 1'b0);

initial
    data <= 0;

always @(*) begin
    data <= {1'b0, Lhs} + {1'b0, Rhs} + carry;
end

assign result = data[7:0];
assign carryOut = data[8];
assign mainBusOut = aluAssert ? data[7:0] : 'bZ;

endmodule
