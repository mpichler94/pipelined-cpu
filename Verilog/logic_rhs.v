module logic_rhs
#(
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input [2:0] op,
    input [DATA_WIDTH-1:0] LhsIn,
    input [DATA_WIDTH-1:0] RhsIn,

    output [DATA_WIDTH-1:0] RhsOut

);

reg [DATA_WIDTH-1:0] data;

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
        6: data <= -'h1;
    endcase

end

assign RhsOut = data;

endmodule