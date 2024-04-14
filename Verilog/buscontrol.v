module buscontrol
(
    input clk,
    input reset_in,
    input [3:0] MainAssert,
    input [3:0] MainLoad,
    input [1:0] LhsAssert,
    input [1:0] RhsAssert,

    output reg_A_LHS,
    output reg_B_LHS,
    output reg_C_LHS,
    output reg_D_LHS,
    output reg_A_RHS,
    output reg_B_RHS,
    output reg_C_RHS,
    output reg_D_RHS,
    output reg_A_assert,
    output reg_B_assert,
    output reg_C_assert,
    output reg_D_assert,
    output reg_Const_assert,
    output reg_TL_assert,
    output reg_TH_assert,
    output alu_assert,
    output reg_A_load,
    output reg_B_load,
    output reg_C_load,
    output reg_D_load,
    output reg_Const_load,
    output reg_TL_load,
    output reg_TH_load,
    output memBridge_load,
    output memBridge_direction
);

assign reg_A_load = MainLoad == 1 ? 'b1 : 'b0;
assign reg_A_assert = (MainAssert == 1) ? 'b1 : 'b0;
assign reg_A_LHS = (LhsAssert == 0) ? 'b1 : 'b0;
assign reg_A_RHS = (RhsAssert == 0) ? 'b1 : 'b0;

assign reg_B_load = MainLoad == 2 ? 'b1 : 'b0;
assign reg_B_assert = (MainAssert == 2) ? 'b1 : 'b0;
assign reg_B_LHS = (LhsAssert == 1) ? 'b1 : 'b0;
assign reg_B_RHS = (RhsAssert == 1) ? 'b1 : 'b0;

assign reg_Const_load = MainLoad == 5 ? 'b1 : 'b0;
assign reg_Const_assert = MainAssert == 5 ? 'b1 : 'b0;

assign alu_assert = MainAssert == 8 ? 'b1 : 'b0;

assign memBridge_load = MainLoad == 15 ? 'b1 : 'b0;
assign memBridge_direction = MainLoad == 15 ? 'b1 : 'b0;




endmodule