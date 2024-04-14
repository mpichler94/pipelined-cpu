module logic_rhs
(
    input clk,
    input [2:0] op,
    input [7:0] LhsIn,
    input [7:0] RhsIn,

    output [7:0] RhsOut

);

reg [7:0] data;

initial
    data <= 0;

always @(posedge clk) begin
    case (op)
        0: data <= 'b0;
        1: data <= ~RhsIn;
        2: data <= LhsIn ^ RhsIn;
        3: data <= LhsIn & RhsIn;
        4: data <= RhsIn;
        5: data <= LhsIn | RhsIn;
        6: data <= 'hFF;
    endcase

end

assign RhsOut = data;

endmodule