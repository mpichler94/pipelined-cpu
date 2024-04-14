module pipe_stage0
(
    input clk,
    input [7:0] PipeIn,
    input busRequest,
    input fetchSuppress,
    input flag5_PCRA_flip,
    
    output [7:0] PipeOut,
    output out0_incPCRA0,
    output out1_incPCRA1

);

reg [7:0] PipeLatch;

initial
    PipeLatch <= 'b0;

always @(negedge clk) begin
    if (fetchSuppress || busRequest)
        PipeLatch <= 'b0;
    else
        PipeLatch <= PipeIn;
end

assign PipeOut = PipeLatch;

assign out0_incPCRA0 = !flag5_PCRA_flip;

assign out1_incPCRA1 = !busRequest;

endmodule