module scan_dff (
    input  clk,
    input  rstn,
    input  scan_en,
    input  d,
    input  scan_in,
    output reg q
);

always @(posedge clk) begin
    if (!rstn)
        q <= 1'b0;
    else if (scan_en)
        q <= scan_in;
    else
        q <= d;
end

endmodule
