module flags
(
    input clk,
    input arithCarryIn,
    input logicCarryIn,
    input [7:0] DataIn,
    input [7:0] LhsIn,
    input [7:0] RhsIn,
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
    overflow <= ((LhsIn[7] ^ DataIn[7]) & (DataIn[7] ^ RhsIn[7]));
    sign <= DataIn[7];
    arithCarry <= arithCarryIn;
    logicCarry <= logicCarryIn;

end

assign zero = ~(| DataIn);

endmodule