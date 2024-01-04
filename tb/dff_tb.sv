`timescale 1ns/1ps
`include "../lib/common_defs.svh"

module tb;

logic clk, d, q;

// Instantiate the Device Under Test (DUT)
dff dut (
    .clk(clk),
    .d(d),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a clock with 10 ns period
end

// Test sequence
initial begin
    d = 0;
    @(posedge clk); #1;
    `ASSERT(q == 0, "Test failed at time ", $time);

    d = 1;
    @(posedge clk); #1;
    `ASSERT(q == 1, "Test failed at time ", $time);

    $display("Test completed successfully.");
    $finish;
end

endmodule
