module adder
#(
    parameter DATA_WIDTH = 16
)
(
    input carryIn,
    input [DATA_WIDTH-1:0] Lhs,
    input [DATA_WIDTH-1:0] Rhs,
    input [1:0] CarrySelect,    // 0 -> 0   1 -> 1   2 -> carryIn   3 -> 0
    input aluAssert,

    output carryOut,
    output [DATA_WIDTH-1:0] result,
    output [DATA_WIDTH-1:0] mainBusOut
);

reg [DATA_WIDTH:0] data;
wire carry = CarrySelect[0] ? (CarrySelect[1] ? 1'b0 : 1'b1) : (CarrySelect[1] ? carryIn : 1'b0);

initial
    data <= 0;

always @(*) begin
    data <= {1'b0, Lhs} + {1'b0, Rhs} + carry;
end

assign result = data[DATA_WIDTH-1:0];
assign carryOut = data[DATA_WIDTH];
assign mainBusOut = aluAssert ? data[DATA_WIDTH-1:0] : 'bZ;

endmodule
