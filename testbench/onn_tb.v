`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2024 12:50:43
// Design Name: 
// Module Name: onn_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module onn_tb #(parameter n = 15)();

reg                  clk;
reg                  reset;
reg                  full_tick;
reg  [(4*n)-1:0]     phi_input;
wire                 s_clk;
wire [(4*n)-1:0]     phi_output;
//wire [3:0]           hamming_dist0;
//wire [3:0]           hamming_dist1;
wire [1:0]           closest_pattern;

onn #(.n(n)) uut (
    .clk            (clk),
    .reset          (reset),
    .full_tick      (full_tick),
    .phi_input      (phi_input),
    .s_clk          (s_clk),
    .phi_output     (phi_output),
//    .hamming_dist0  (hamming_dist0),
//    .hamming_dist1  (hamming_dist1),
    .closest_pattern(closest_pattern)
);

// clock
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // reset
    reset     = 1;
    full_tick = 0;
    phi_input = 60'h0;
    #100;

    reset = 0;
    #50;

    // ------------------------------------------------
    // feeding corrupted digit 0
    // clean digit 0:     60'h888808808808888
    // corrupted digit 0: 60'h888808808808880
    //                                      ?
    //                               n0 flipped 8?0
    // ------------------------------------------------
    $display("=================================");
    $display("TEST: corrupted digit 0");
    $display("n0 flipped: 8 to 0");
    $display("expected: closest_pattern = 00 (digit 0)");
    $display("=================================");

    phi_input = 60'h886808808808886;
    full_tick = 1;
    #150;
    full_tick = 0;

    // run for 800000ns and monitor output
    #800000;

    $display("=================================");
    $display("FINAL RESULT at T=%0t", $time);
    $display("phi_input    = %h", phi_input);
    $display("phi_output   = %h", phi_output);
//    $display("hamming_dist0= %0d", hamming_dist0);
//    $display("hamming_dist1= %0d", hamming_dist1);
    $display("closest      = %b (%s)",
        closest_pattern,
        (closest_pattern == 2'b00) ? "DIGIT 0" : "DIGIT 1");
    $display("=================================");

    $finish;
end


endmodule
