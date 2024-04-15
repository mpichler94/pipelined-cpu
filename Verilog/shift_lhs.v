module shift_lhs
#(
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input [1:0] op,
    input carryIn,
    input [DATA_WIDTH-1:0] LhsIn,

    output carryOut,
    output [DATA_WIDTH-1:0] LhsOut
);

reg [DATA_WIDTH-1:0] data;
reg carry;

initial begin
    data <= 0;
    carry <= 0;
end

always @(posedge clk) begin
    case (op)
        0: data <= LhsIn;
        0: carry <= 'b0;
        1: data <= {LhsIn[DATA_WIDTH-2:0], carryIn};
        1: carry <= LhsIn[DATA_WIDTH-1];
        2: data <= {carryIn, LhsIn[DATA_WIDTH-1:1]};
        2: carry <= LhsIn[0];
        3: data <= 'b0;
        3: carry <= 'b0;
    endcase
end

assign LhsOut = data;
assign carryOut = carry;


endmodule