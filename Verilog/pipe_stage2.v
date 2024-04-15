module pipe_stage2
#(
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input [DATA_WIDTH-1:0] PipeIn,
    
    output [DATA_WIDTH-1:0] PipeOut,
    output reg [3:0] MainAssert,
    output reg [3:0] MainLoad
);

reg [DATA_WIDTH-1:0] PipeLatch;

initial
    PipeLatch <= 0;

always @(posedge clk) begin
    PipeLatch <= PipeIn;

end

always @(PipeLatch) begin
    MainLoad <= PipeLatch[12:10];

    case (PipeLatch[6:0]) // opcode
        1: begin                        // mov
            MainAssert <= PipeLatch[9:7];
        end
        96, 97, 102, 103, 104: begin    // add sub and or xor
            MainAssert <= 8;
        end
        2: begin                        // mvi
            MainAssert <= 5;
        end
        98, 99, 100, 101, 105: begin    // inc dec shl shr not
            MainAssert <= 8;
        end
        default: begin
            MainLoad <= 0;
            MainAssert <= 0;
        end

    endcase

end



assign PipeOut = PipeLatch;

endmodule