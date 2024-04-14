module pipe_stage2
(
    input clk,
    input [7:0] PipeIn,
    
    output [7:0] PipeOut,
    output reg [3:0] MainAssert,
    output reg [3:0] MainLoad
);

reg [7:0] PipeLatch;

initial
    PipeLatch <= 0;

always @(posedge clk) begin
    PipeLatch <= PipeIn;

end

always @(PipeLatch) begin
    MainLoad = 0;

     if (PipeLatch[7:6] == 1) begin             // mov
        MainLoad <= PipeLatch[5:3];
        MainAssert <= PipeLatch[2:0];
    end else if (PipeLatch[7:4] == 1 
                    || PipeLatch[7:4] == 2 
                    || PipeLatch[7:4] == 9 
                    || PipeLatch[7:4] == 10 
                    || PipeLatch[7:4] == 11) begin     // add  sub  and  or  xor
        MainAssert <= 8;
        MainLoad <= PipeLatch[3:2] + 1'b1;
     end else if (PipeLatch[7:3] == 1) begin    // mvi
        MainLoad <= PipeLatch[2:0];
        MainAssert <= 5;
     end else if (PipeLatch[7:2] == 1 
                    || PipeLatch[7:2] == 12 
                    || PipeLatch[7:2] == 32 
                    || PipeLatch[7:2] == 33
                    || PipeLatch[7:2] == 34) begin    // adi  sui  shl  shr  not
        MainAssert <= 8;
        MainLoad <= PipeLatch[1:0] + 1'b1;
     end
end



assign PipeOut = PipeLatch;

endmodule