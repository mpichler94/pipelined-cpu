module r8b_gpr
(
    input clk,
    input reg_load,
    input reg_write,
    input [7:0] RegIn,
    input assert_LHS,
    input assert_RHS,

    output [7:0] RegOut,
    output [7:0] LhsOut,
    output [7:0] RhsOut
);

reg [7:0] data;

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