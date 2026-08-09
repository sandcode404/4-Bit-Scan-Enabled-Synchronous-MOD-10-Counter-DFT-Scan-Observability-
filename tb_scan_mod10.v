`timescale 1ns/1ps

module tb_modN_scan;
    reg clk, rstn;
    reg scan_en, scan_in;
    wire scan_out;
    wire [3:0] out;
    reg [3:0] response;
    integer i;

    modN_scan #(
        .N(10),
        .WIDTH(4)
    ) dut (
        .clk(clk),
        .rstn(rstn),
        .scan_en(scan_en),
        .scan_in(scan_in),
        .scan_out(scan_out),
        .out(out)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk     = 0;
        rstn    = 0;
        scan_en = 0;
        scan_in = 0;

        // functional access
        repeat (2) @(posedge clk);
        rstn = 1;

        // Normal counter operation
        scan_en = 0;
        repeat (7) begin
            @(posedge clk);
            #1;
        end

        // scan access
        // Target state = 0111
        rstn    = 0;
        scan_en = 0;
        scan_in = 0;

        repeat (2) @(posedge clk);
        rstn = 1;

        // SHIFT IN
        scan_en = 1;
        @(negedge clk);
        scan_in = 0;
        @(negedge clk);
        scan_in = 1;
        @(negedge clk);
        scan_in = 1;
        @(negedge clk);
        scan_in = 1;

        // Capture final scan bit
        @(posedge clk);
        #1;

        // CAPTURE
        scan_en = 0;
        @(posedge clk);
        #1;

        // SHIFT OUT
        scan_en = 1;
        response = 4'b0000;
        for (i = 3; i >= 0; i = i - 1) begin
            response[i] = scan_out;
            @(posedge clk);
            #1;
        end
        $finish;
    end
endmodule
