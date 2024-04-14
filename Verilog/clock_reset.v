module clock_reset
(
    input clk,
    input reset_in_n,
    
    output reset_out_n
);

reg [2:0] cnt;
reg rdy;

initial begin
    cnt = 3'b111;   // init with max delay
    rdy = 1'b0; // not ready
end

always @(posedge clk) begin
    if (reset_in_n) begin
        cnt <= 3'b111; // reset
        rdy = 1'b0;
    end else if (cnt == 3'b0) begin 
        cnt <= 3'b000;
        rdy <= 1'b1;
    end else begin
        cnt <= cnt - 1'b1;
        rdy <= 1'b0;
    end
end

assign reset_out_n = !rdy;

endmodule