module modN_ctr #(
    parameter N = 10,
    parameter WIDTH = 4
)(
    input clk,
    input rstn,
    output reg [WIDTH-1:0] out
);

initial begin
    if (N < 1 || N > (2**WIDTH))
        $error("Invalid parameters: require 1 <= N <= 2^WIDTH");
end

always @(posedge clk) begin
    if (!rstn)
        out <= 0;
    else if (out >= N-1)
        out <= 0;
    else
        out <= out + 1'b1;
end

endmodule
