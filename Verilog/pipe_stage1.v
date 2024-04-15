module pipe_stage1
#(
    parameter DATA_WIDTH = 16
)
(
    input clk,
    input [DATA_WIDTH-1:0] PipeIn,
    
    output [DATA_WIDTH-1:0] PipeOut,
    output reg [1:0] lhs,
    output reg [1:0] rhs,
    output reg [1:0] out_shift,
    output reg [2:0] out_logic,
    output reg [1:0] out_carry,
    output out_FetchSuppress

);

reg [DATA_WIDTH-1:0] PipeLatch;

initial begin
    PipeLatch <= 0;
    lhs <= 0;
    rhs <= 0;
    out_shift <= 0;
    out_logic <= 0;
    out_carry <= 0;
end

always @(posedge clk) begin
    PipeLatch <= PipeIn;

end

always @(PipeLatch) begin
    out_shift <= 0;
    out_logic <= 4;
    out_carry <= 0;
    lhs <= PipeLatch[12:10];
    rhs <= PipeLatch[9:7];
    case (PipeLatch[6:0]) // opcode
        96: begin       // add
            out_shift <= 0;
            out_logic <= 4;
            out_carry <= 0;
        end
        97, 3: begin    // sub cmp
            out_shift <= 0;
            out_logic <= 1;
            out_carry <= 1;
        end
        98: begin       // inc
            out_shift <= 0;
            out_logic <= 0;
            out_carry <= 1;
        end
        99: begin       // dec
            out_shift <= 0;
            out_logic <= 6;
            out_carry <= 0;
        end
        100: begin      // shl
            out_shift <= 1;
            out_logic <= 0;
            out_carry <= 0;
        end
        101: begin      // shr
            out_shift <= 2;
            out_logic <= 0;
            out_carry <= 0;
        end
        102: begin      // and
            out_shift <= 3;
            out_logic <= 3;
            out_carry <= 0;
        end
        103: begin      // or
            out_shift <= 3;
            out_logic <= 5;
            out_carry <= 0;
        end
        104: begin      // xor
            out_shift <= 3;
            out_logic <= 2;
            out_carry <= 0;
        end
        105: begin      // not
            out_shift <= 0;
            out_logic <= 1;
            out_carry <= 0;
        end
    
    endcase

end


assign PipeOut = PipeLatch;

assign out_FetchSuppress = (PipeLatch[6:0] == 2);

endmodule