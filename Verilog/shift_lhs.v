module shift_lhs
(
    input clk,
    input [1:0] op,
    input carryIn,
    input [7:0] LhsIn,

    output carryOut,
    output [7:0] LhsOut
);

reg [7:0] data;
reg carry;

initial begin
    data <= 0;
    carry <= 0;
end

always @(posedge clk) begin
    case (op)
        0: data <= LhsIn;
        0: carry <= 'b0;
        1: data <= {LhsIn[6:0], carryIn};
        1: carry <= LhsIn[7];
        2: data <= {carryIn, LhsIn[7:1]};
        2: carry <= LhsIn[0];
        3: data <= 'b0;
        3: carry <= 'b0;
    endcase
end

assign LhsOut = data;
assign carryOut = carry;


endmodule