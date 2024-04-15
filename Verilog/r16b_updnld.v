// 16 bit register with up, down and load.
// Will be used for at least PC, SP, SI, DI registers.
// Hardware implementation would be a 74xx193

module r16b_updnld
#(
    parameter WIDTH = 16
)
(
    input clk,
    input clr,
    input reg_load,
    input reg_write,
    input inc,
    input dec,
    input [WIDTH-1:0] XferBusIn,

    output [WIDTH-1:0] Out
);

    reg [WIDTH-1:0] data;

    initial
        data <= 0;

    always @(clr)
        if (clr)
            data <= 'b0; 

    always @(negedge clk) 
        if (clr)
            data <= 'b0; 
        else if (reg_load)
            data <= XferBusIn;
        else if (inc)
            data <= data + 1'b1;
        else if (dec)
            data <= data - 1'b1;

    assign Out = reg_write ? data : 'bZ;
        
endmodule