module flags
#(
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input arithCarryIn,
    input logicCarryIn,
    input [DATA_WIDTH-1:0] DataIn,
    input [DATA_WIDTH-1:0] LhsIn,
    input [DATA_WIDTH-1:0] RhsIn,
    input [1:0] CarrySelect,

    output reg arithCarry,
    output reg logicCarry,
    output zero,
    output reg sign,
    output reg overflow,
    output reg [1:0] CarrySelectDelayed
);

initial begin
    arithCarry <= 0;
    logicCarry <= 0;
    sign <= 0;
    overflow <= 0;
    CarrySelectDelayed <= 0;

end

always @(posedge clk) begin
    CarrySelectDelayed <= CarrySelect;
    overflow <= ((LhsIn[DATA_WIDTH] ^ DataIn[DATA_WIDTH]) & (DataIn[DATA_WIDTH] ^ RhsIn[DATA_WIDTH]));
    sign <= DataIn[DATA_WIDTH];
    arithCarry <= arithCarryIn;
    logicCarry <= logicCarryIn;

end

assign zero = ~(| DataIn);

endmodule