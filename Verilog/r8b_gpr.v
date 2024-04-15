module r8b_gpr
#(
    parameter WIDTH = 16
)
(
    input clk,
    input reg_load,
    input reg_write,
    input [WIDTH-1:0] RegIn,
    input assert_LHS,
    input assert_RHS,

    output [WIDTH-1:0] RegOut,
    output [WIDTH-1:0] LhsOut,
    output [WIDTH-1:0] RhsOut
);

reg [WIDTH-1:0] data;

initial
    data <= 0;

always @(negedge clk) begin
    if (reg_load)
        data <= RegIn;
end

assign RegOut = reg_write ? data : 'bZ;
assign LhsOut = assert_LHS ? data : 'bZ;
assign RhsOut = assert_RHS ? data : 'bZ;

endmodule