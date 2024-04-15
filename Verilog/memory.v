module memory
#(
    parameter ADDR_WIDTH = 16,
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input [ADDR_WIDTH-1:0] Addr,
    input [DATA_WIDTH-1:0] MainBusIn,
    input dir,
    input load,
    input mem_assert,

    output [DATA_WIDTH-1:0] MemDataOut,
    output [DATA_WIDTH-1:0] MainBusOut
);

//reg [DATA_WIDTH-1:0] RAM [65535:0];
reg [DATA_WIDTH-1:0] RAM [(1<<ADDR_WIDTH)-1:0];

reg [DATA_WIDTH-1:0] dout;

initial
    dout <= 0;

//assign MemDataOut = dir ? MainBusIn : dout;
assign MemDataOut = dout;
assign MainBusOut = mem_assert ? dout : 'bZ;

always @(posedge clk) begin
    if (load) begin
        RAM[Addr] <= MainBusIn[DATA_WIDTH-1+:8];
        RAM[Addr + 1] <= MainBusIn[DATA_WIDTH-9+:8];
        dout <= MainBusIn;
    end else
        dout[15:8] <= RAM[Addr];
        dout[7:0] <= RAM[Addr+1];
end

endmodule