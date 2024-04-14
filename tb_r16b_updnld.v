module tb_r16b_updnld();

reg [7:0] MB = 0;
reg [15:0] XB = 0;
reg clk;
reg load_tx  = 0;
reg read_tx = 0;
reg inc = 0;
reg dec = 0;
wire [15:0] Q16;

r16b_updnld DUT
(
    .clk(clk),
    .reg_load(load_tx),
    .reg_write(read_tx),
    .inc(inc),
    .dec(dec),
    .XferBusIn(XB),
    .Out(Q16)
);

initial begin
    $dumpvars(1, tb_r16b_updnld);
    $dumpvars(1, DUT);

    clk=0;
    forever #10 clk = ~clk;  
end


 
initial begin 
    #100; // just let clock run
    
    XB = 16'hCAFE;
    load_tx = 1;
    #20;
    load_tx = 0;
    read_tx = 1;
    #20;
    read_tx = 0;
    #20;

    inc = 1;
    read_tx = 1;
    #50;
    read_tx = 0;
    #50;
    inc = 0;
    #20;

    dec  = 1;
    read_tx = 1;
    #100;
    read_tx = 0;
    dec = 0;

    #100;
    $finish;
end 

endmodule