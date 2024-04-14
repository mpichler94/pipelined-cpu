`timescale 100ns/1ns

`include "Verilog/clock_reset.v"
`include "Verilog/r16b_updnld.v"
`include "Verilog/r8b_gpr.v"
`include "Verilog/memory.v"
`include "Verilog/pipe_stage0.v"
`include "Verilog/pipe_stage1.v"
`include "Verilog/pipe_stage2.v"
`include "Verilog/buscontrol.v"
`include "Verilog/shift_lhs.v"
`include "Verilog/logic_rhs.v"
`include "Verilog/adder.v"
`include "Verilog/flags.v"


module cpu
(
    input clk,
    input resetIn

);

wire flags_0_overflow;
wire flags_1_sign;
wire flags_2_zero;
wire flags_3_carryA;
wire flags_4_carryL;
wire flags_6_reset;

wire [7:0] BUS_Memory;
wire [7:0] BUS_Main;
wire [15:0] BUS_Addr;
wire [7:0] BUS_LHS;
wire [7:0] BUS_RHS;
wire [7:0] Alu_LHS;
wire [7:0] Alu_RHS;
wire [7:0] Data;

wire [7:0] pipe0Out_pipeline;
wire pipe0Out_0_inc_PCRA0;
wire pipe0Out_1_inc_PCRA1;


wire [7:0] pipe1Out_pipeline;
wire [1:0] pipe1Out_lhs;
wire [1:0] pipe1Out_rhs;
wire [1:0] pipe1Out_shift;
wire [2:0] pipe1Out_logic;
wire pipe1Out_15_FetchSuppress;

wire [7:0] pipe2Out_pipeline;
wire [3:0] MainBusAssert;
wire [3:0] MainBusLoad;

wire control_reg_A_load;
wire control_reg_A_assert;
wire control_reg_A_LHS;
wire control_reg_A_RHS;

wire control_reg_B_load;
wire control_reg_B_assert;
wire control_reg_B_LHS;
wire control_reg_B_RHS;

wire control_reg_Const_assert;
wire control_reg_Const_load;

wire control_alu_assert;

wire memBridge_load;
wire memBridge_direction;

wire  arithCarry;
wire shift_carryOut;
wire [1:0] CarrySelect;
wire [1:0] CarrySelectDelayed;


// FOR DEBUGGING ----------
reg read_memory = 1;

// ------------------------

clock_reset clock_reset
(
    .clk(clk),
    .reset_in_n(resetIn),
    .reset_out_n(flags_6_reset)
);

r16b_updnld PCRA0
(
    .clk(clk),
    .clr(flags_6_reset),
    .reg_load(),
    .reg_write(1'b1),
    .inc(pipe0Out_0_inc_PCRA0),
    .dec(),
    .XferBusIn(),
    .Out(BUS_Addr)
);

r8b_gpr A
(
    .clk(clk),
    .reg_load(control_reg_A_load),
    .reg_write(control_reg_A_assert),
    .assert_LHS(control_reg_A_LHS),
    .assert_RHS(control_reg_A_RHS),
    .RegIn(BUS_Main),

    .RegOut(BUS_Main),
    .LhsOut(BUS_LHS),
    .RhsOut(BUS_RHS)
);

r8b_gpr B
(
    .clk(clk),
    .reg_load(control_reg_B_load),
    .reg_write(control_reg_B_assert),
    .assert_LHS(control_reg_B_LHS),
    .assert_RHS(control_reg_B_RHS),
    .RegIn(BUS_Main),

    .RegOut(BUS_Main),
    .LhsOut(BUS_LHS),
    .RhsOut(BUS_RHS)
);

r8b_gpr Const
(
    .clk(clk),
    .reg_load(pipe1Out_15_FetchSuppress),
    .reg_write(control_reg_Const_assert),
    .RegIn(BUS_Memory),

    .RegOut(BUS_Main)
);

memory memory
(
    .clk(clk),
    .Addr(BUS_Addr),
    .MainBusIn(BUS_Main),
    .dir(memBridge_direction),
    .load(memBridge_load),
    .mem_assert(1'b0),

    .MemDataOut(BUS_Memory),
    .MainBusOut(BUS_Main)
);

pipe_stage0 stage0
(
    .clk(clk),
    .PipeIn(BUS_Memory),
    .busRequest(),
    .fetchSuppress(pipe1Out_15_FetchSuppress),
    .flag5_PCRA_flip(1'b0),
    
    .PipeOut(pipe0Out_pipeline),
    .out0_incPCRA0(pipe0Out_0_inc_PCRA0),
    .out1_incPCRA1(pipe0Out_1_inc_PCRA1)
);

pipe_stage1 stage1
(
    .clk(clk),
    .PipeIn(pipe0Out_pipeline),
    
    .PipeOut(pipe1Out_pipeline),
    .lhs(pipe1Out_lhs),
    .rhs(pipe1Out_rhs),
    .out_shift(pipe1Out_shift),
    .out_logic(pipe1Out_logic),
    .out_carry(CarrySelect),
    .out_FetchSuppress(pipe1Out_15_FetchSuppress)
);


pipe_stage2 stage2
(
    .clk(clk),
    .PipeIn(pipe1Out_pipeline),
    
    .PipeOut(pipe2Out_pipeline),
    .MainAssert(MainBusAssert),
    .MainLoad(MainBusLoad)
);

buscontrol buscontrol
(
    .clk(clk),
    .reset_in(flags_6_reset),
    .MainAssert(MainBusAssert),
    .MainLoad(MainBusLoad),
    .LhsAssert(pipe1Out_lhs),
    .RhsAssert(pipe1Out_rhs),

    .reg_A_load(control_reg_A_load),
    .reg_A_assert(control_reg_A_assert),
    .reg_A_LHS(control_reg_A_LHS),
    .reg_A_RHS(control_reg_A_RHS),

    .reg_B_load(control_reg_B_load),
    .reg_B_assert(control_reg_B_assert),
    .reg_B_LHS(control_reg_B_LHS),
    .reg_B_RHS(control_reg_B_RHS),

    .reg_Const_load(control_reg_Const_load),
    .reg_Const_assert(control_reg_Const_assert),

    .reg_TL_assert(),
    .reg_TH_assert(),
    .reg_TL_load(),
    .reg_TH_load(),

    .alu_assert(control_alu_assert),

    .memBridge_load(memBridge_load),
    .memBridge_direction(memBridge_direction)
);

shift_lhs shift
(
    .clk(clk),
    .op(pipe1Out_shift),
    .carryIn(flags_4_carryL),
    .LhsIn(BUS_LHS),

    .carryOut(shift_carryOut),
    .LhsOut(Alu_LHS)
);

logic_rhs logic_rhs
(
    .clk(clk),
    .op(pipe1Out_logic),
    .LhsIn(BUS_LHS),
    .RhsIn(BUS_RHS),

    .RhsOut(Alu_RHS)
);

adder adder
(
    .carryIn(flags_3_carryA),
    .Lhs(Alu_LHS),
    .Rhs(Alu_RHS),
    .CarrySelect(CarrySelectDelayed),    // 0 -> 0   1 -> 1   2 -> carryIn   3 -> 0
    .aluAssert(control_alu_assert),

    .carryOut(arithCarry),
    .result(Data),
    .mainBusOut(BUS_Main)
);

flags flags
(
    .clk(clk),
    .arithCarryIn(arithCarry),
    .logicCarryIn(shift_carryOut),
    .DataIn(Data),
    .LhsIn(BUS_LHS),
    .RhsIn(BUS_RHS),
    .CarrySelect(CarrySelect),

    .arithCarry(flags_3_carryA),
    .logicCarry(flags_4_carryL),
    .zero(flags_2_zero),
    .sign(flags_1_sign),
    .overflow(flags_0_overflow),
    .CarrySelectDelayed(CarrySelectDelayed)
);

initial begin
    $readmemh("../ram.hex", memory.RAM, 0);
    $readmemh("ram.hex", memory.RAM, 0);
end


endmodule