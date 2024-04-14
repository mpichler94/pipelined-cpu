// 16 bit register with up, down and load.
// Will be used for at least PC, SP, SI, DI registers.
// Hardware implementation would be a 74xx193

module r16b_updnld
(
    input clk,
    input clr,
    input reg_load,
    input reg_write,
    input inc,
    input dec,
    input [15:0] XferBusIn,

    output [15:0] Out
);

    reg [15:0] data;

    initial
        data <= 0;

    always @(clr)
        if (clr)
            data <= 16'b0; 

    always @(negedge clk) 
        if (clr)
            data <= 16'b0; 
        else if (reg_load)
            data <= XferBusIn;
        else if (inc)
            data <= data + 1'b1;
        else if (dec)
            data <= data - 1'b1;

    assign Out = reg_write ? data : 'bZ;
        

endmodule