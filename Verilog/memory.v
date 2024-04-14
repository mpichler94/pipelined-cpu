module memory
(
    input clk,
    input [15:0] Addr,
    input [7:0] MainBusIn,
    input dir,
    input load,
    input mem_assert,

    output [7:0] MemDataOut,
    output [7:0] MainBusOut
);

reg [7:0] RAM [65535:0];

reg [7:0] dout;

initial
    dout <= 0;

//assign MemDataOut = dir ? MainBusIn : dout;
assign MemDataOut = dout;
assign MainBusOut = mem_assert ? dout : 'bZ;

always @(posedge clk) begin
    if (load) begin
        RAM[Addr] <= MainBusIn;
        dout <= MainBusIn;
    end else
        dout <= RAM[Addr];
end

endmodule