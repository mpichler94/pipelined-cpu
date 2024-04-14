module pipe_stage1
(
    input clk,
    input [7:0] PipeIn,
    
    output [7:0] PipeOut,
    output reg [1:0] lhs,
    output reg [1:0] rhs,
    output reg [1:0] out_shift,
    output reg [2:0] out_logic,
    output reg [1:0] out_carry,
    output out_FetchSuppress

);

reg [7:0] PipeLatch;

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

    if (PipeLatch[7:4] == 1) begin              // add
        lhs <= PipeLatch[3:2];
        rhs <= PipeLatch[1:0];
        out_shift <= 0;
        out_logic <= 4;
        out_carry <= 0;
    end else if (PipeLatch[7:4] == 2 || PipeLatch[7:4] == 12) begin     // sub  cmp
        lhs <= PipeLatch[3:2];
        rhs <= PipeLatch[1:0];
        out_shift <= 0;
        out_logic <= 1;
        out_carry <= 1;
    end else if (PipeLatch[7:4] == 9) begin     // and
        lhs <= PipeLatch[3:2];
        rhs <= PipeLatch[1:0];
        out_shift <= 3;
        out_logic <= 3;
        out_carry <= 0;
    end else if (PipeLatch[7:4] == 10) begin     // or
        lhs <= PipeLatch[3:2];
        rhs <= PipeLatch[1:0];
        out_shift <= 3;
        out_logic <= 5;
        out_carry <= 0;
    end else if (PipeLatch[7:4] == 11) begin     // xor
        lhs <= PipeLatch[3:2];
        rhs <= PipeLatch[1:0];
        out_shift <= 3;
        out_logic <= 2;
        out_carry <= 0;
    end else if (PipeLatch[7:2] == 1) begin     // inc
        lhs <= PipeLatch[1:0];
        rhs <= 0;
        out_shift <= 0;
        out_logic <= 0;
        out_carry <= 1;
    end else if (PipeLatch[7:2] == 12) begin     // dec
        lhs <= PipeLatch[3:2];
        rhs <= 5;
        out_shift <= 0;
        out_logic <= 6;
        out_carry <= 0;
    end else if (PipeLatch[7:2] == 32) begin    // shl
        lhs <= PipeLatch[3:2];
        rhs <= 0;
        out_shift <= 1;
        out_logic <= 0;
        out_carry <= 0;
    end else if (PipeLatch[7:2] == 33) begin    // shr
        lhs <= PipeLatch[3:2];
        rhs <= 0;
        out_shift <= 2;
        out_logic <= 0;
        out_carry <= 0;
    end else if (PipeLatch[7:2] == 34) begin     // not
        lhs <= PipeLatch[3:2];
        rhs <= 0;
        out_shift <= 0;
        out_logic <= 1;
        out_carry <= 0;
    end

end


assign PipeOut = PipeLatch;

assign out_FetchSuppress = (PipeLatch[7:3] == 1);

endmodule