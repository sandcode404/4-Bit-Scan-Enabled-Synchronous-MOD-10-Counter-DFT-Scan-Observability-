module modN_scan #(
    parameter N     = 10,
    parameter WIDTH = 4
)(
    input clk,
    input rstn,
    input scan_en,
    input scan_in,
    output scan_out,
    output [WIDTH-1:0] out
);

initial begin
    if (N < 1 || N > (2**WIDTH))
        $error("Invalid parameters: require 1 <= N <= 2^WIDTH");
end

wire [WIDTH-1:0] next;

assign next = (out >= N-1) ? 0 : out + 1'b1;

scan_dff ff0 (
    .clk(clk),
    .rstn(rstn),
    .scan_en(scan_en),
    .d(next[0]),
    .scan_in(scan_in),
    .q(out[0])
);

scan_dff ff1 (
    .clk(clk),
    .rstn(rstn),
    .scan_en(scan_en),
    .d(next[1]),
    .scan_in(out[0]),
    .q(out[1])
);


scan_dff ff2 (
    .clk(clk),
    .rstn(rstn),
    .scan_en(scan_en),
    .d(next[2]),
    .scan_in(out[1]),
    .q(out[2])
);

scan_dff ff3 (
    .clk(clk),
    .rstn(rstn),
    .scan_en(scan_en),
    .d(next[3]),
    .scan_in(out[2]),
    .q(out[3])
);

assign scan_out = out[3];

endmodule
