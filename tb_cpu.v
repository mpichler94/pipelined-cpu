`include "Verilog/cpu.v"

module tb_cpu;

reg [15:0] Addr = 0;
reg [7:0] Data = 0;
reg clk;
reg reset = 0;
wire [7:0] DataOut;

cpu DUT
(
    .clk(clk),
    .resetIn(reset)
);

initial begin
    $dumpvars(0, tb_cpu);

    clk=0;
    forever #10 clk = ~clk;  
end

initial begin 
    #1000;

    $finish;
end 

endmodule