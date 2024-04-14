module tb_memory();

reg [15:0] Addr = 0;
reg [7:0] Data = 0;
reg clk;
reg write_memory  = 0;
reg read_memory = 1;
wire [7:0] DataOut;

memory DUT
(
    .clk(clk),
    .read(read_memory),
    .write(write_memory),
    .Addr(Addr), 
    .DataIn(Data),
    .DataOut(DataOut)
);

initial begin
    $dumpvars(1, tb_memory);
    $dumpvars(1, DUT);

    clk=0;
    forever #10 clk = ~clk;  
end

always @(posedge clk)
    if (Addr < 32)
        Addr <= Addr + 1;


 
initial begin 
    #30;
    read_memory = 1;
    #200;
    read_memory = 0;
    #20;
    Data = 'hCAFE;
    Addr = 'h30;
    write_memory = 1;
    #10;
    write_memory = 0;
    #10;
    Data = 'hBEEF;
    Addr = 'h40;
    write_memory = 1;
    #10;
    write_memory = 0;
    #10;
    Addr = 'h30;
    read_memory = 1;
    #20

    #100;
    $finish;
end 

endmodule