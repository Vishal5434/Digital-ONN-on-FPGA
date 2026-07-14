////`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////
////// Company: 
////// Engineer: 
////// 
////// Create Date: 23.08.2025 18:21:21
////// Design Name: 
////// Module Name: hamming_tb
////// Project Name: 
////// Target Devices: 
////// Tool Versions: 
////// Description: 
////// 
////// Dependencies: 
////// 
////// Revision:
////// Revision 0.01 - File Created
////// Additional Comments:
////// 
//////////////////////////////////////////////////////////////////////////////////////



//`timescale 1ns / 1ps

//module hamming_tb;

//    reg  [59:0] sample;
//    wire [1:0]  digit_out;
//    wire [3:0]  min_dist;

//    // Instantiate the device under test (DUT)
//    onn_digit_recog dut (
//        .sample    (sample),
//        .digit_out (digit_out),
//        .min_dist  (min_dist)
//    );

//    // Utility: Build sample bit vector from 15x 4b
//    function [59:0] build_sample;
//        input [3:0] n0;  input [3:0] n1;  input [3:0] n2;  input [3:0] n3;
//        input [3:0] n4;  input [3:0] n5;  input [3:0] n6;  input [3:0] n7;
//        input [3:0] n8;  input [3:0] n9;  input [3:0] n10; input [3:0] n11;
//        input [3:0] n12; input [3:0] n13; input [3:0] n14;
//        begin
//            build_sample = {n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14};
//            // Ordering: n14 MSB, n0 LSB, consistent with [i*4 +: 4]
//        end
//    endfunction

//    initial begin
//        // Display header
//        $display("Time\tDigit_Out\tMin_Dist");

//        // 1. Perfect digit 0 (from template)
//        sample = build_sample(
//            4'd8,4'd8,4'd8,4'd8,4'd0,
//            4'd8,4'd8,4'd0,4'd8,4'd8,
//            4'd0,4'd8,4'd8,4'd8,4'd8
//        );
//        #10;
//        $display("%0t\td0 (should be 0)\t%d", $time, digit_out);

//        // 2. Perfect digit 1
//        sample = build_sample(
//            4'd0,4'd0,4'd8,4'd0,4'd0,
//            4'd8,4'd0,4'd0,4'd8,4'd0,
//            4'd0,4'd8,4'd0,4'd0,4'd8
//        );
//        #10;
//        $display("%0t\td1 (should be 1)\t%d", $time, digit_out);

//        // 3. Perfect digit 2
//        sample = build_sample(
//            4'd8,4'd8,4'd8,4'd0,4'd0,
//            4'd8,4'd8,4'd8,4'd8,4'd0,
//            4'd0,4'd8,4'd8,4'd8,4'd8
//        );
//        #10;
//        $display("%0t\td2 (should be 2)\t%d", $time, digit_out);

//        // 4. Noisy digit 0: one mismatch in neuron 8 (change to 4'd9)
//        sample = build_sample(
//            4'd8,4'd8,4'd8,4'd8,4'd0,
//            4'd8,4'd8,4'd0,4'd9,4'd8,
//            4'd0,4'd8,4'd8,4'd8,4'd8
//        );
//        #10;
//        $display("%0t\tNoise0 (should be 0)\t%d, mismatches: %d", $time, digit_out, min_dist);

//        // 5. Noisy digit 1: 2 unmatched (positions 1 and 4 changed to gray 4'd5)
//        sample = build_sample(
//            4'd0,4'd5,4'd8,4'd0,4'd5,
//            4'd8,4'd0,4'd0,4'd8,4'd0,
//            4'd0,4'd8,4'd0,4'd0,4'd8
//        );
//        #10;
//        $display("%0t\tNoise1 (should be 1)\t%d, mismatches: %d", $time, digit_out, min_dist);

//        // 6. Unmatched random pattern
//        sample = build_sample(
//            4'd3,4'd7,4'd4,4'd11,4'd5,
//            4'd6,4'd1,4'd12,4'd13,4'd15,
//            4'd2,4'd9,4'd10,4'd2,4'd11
//        );
//        #10;
//        $display("%0t\tRandom (should be 3=none)\t%d, mismatches: %d", $time, digit_out, min_dist);

//        // 7. 3 mismatches: Should return "0"
//        sample = build_sample(
//            4'd9,4'd15,4'd9,4'd8,4'd0,
//            4'd8,4'd10,4'd0,4'd8,4'd7, // neuron 6, neuron 9 mismatch
//            4'd0,4'd8,4'd5,4'd8,4'd8 // neuron 12 mismatch
//        );
//        #10;
//        $display("%0t\t3errs (should be 0)\t%d, mismatches: %d", $time, digit_out, min_dist);

//        sample = build_sample( 4'd8, 4'd4, 4'd8,
//    4'd6, 4'd0, 4'd8 ,
//    4'd10, 4'd15, 4'd8 ,
//    4'd8, 4'd0, 4'd6,
//    4'd0, 4'd8, 4'd0);
//        #10;
//        $finish;
//    end

//endmodule

`timescale 1ns / 1ps

module tb_hamming_distance_bipolar #(parameter n = 15);
localparam HAM_BITS =  $clog2(2*n);  // For SystemVerilog, use $clog2. For Verilog-2001, use user-defined function as before.

    reg [(2*n)-1:0] input_vec;
    wire [HAM_BITS-1:0] hamming_dist0;
    wire [HAM_BITS-1:0] hamming_dist1;
    wire [HAM_BITS-1:0] hamming_dist2;
    wire [1:0] closest_pattern;

    // Instantiate the module
    hamming_distance_bipolar uut (
        .input_vec(input_vec),
        .hamming_dist0(hamming_dist0),
        .hamming_dist1(hamming_dist1),
        .hamming_dist2(hamming_dist2),
        .closest_pattern(closest_pattern)
    );

    // Convenience task for printing results
    task print_results;
        input [(2*n)-1:0] pattern;
        input [HAM_BITS-1:0] dist0, dist1, dist2;
        input [1:0] closest;
        begin
            $display("Input pattern: %b", pattern);
            $display("Hamming Distances -> 0: %d, 1: %d, 2: %d", dist0, dist1, dist2);
            $display("Closest stored pattern: %d", closest);
            $display("-----------------------------");
        end
    endtask

    initial begin
        // Allow some time for simulation to start
        #10;

        // Apply corrupted pattern for digit 0
        // Using 2-bit encoding '10' for black (8) and '00' for white (0)
        // Example corrupted0 pattern (need to encode accordingly)
        // Here is an example input with some bits flipped compared to pattern0
        input_vec =100'b00_00_00_10_00_00_00_00_00_10_00_00_00_10_00_00_00_00_10_10_00_00_00_10_10_00_00_00_00_10_00_00_00_00_10_00_00_00_10_00_00_00_00_00_10_00_00_00_00_10;
        #10;
        print_results(input_vec, hamming_dist0, hamming_dist1, hamming_dist2, closest_pattern);

        // Apply corrupted pattern for digit 1
       input_vec =100'b00_00_00_10_10_00_00_00_10_10_00_00_00_00_10_00_00_00_10_00_00_00_00_10_10_00_00_00_00_00_00_00_00_00_10_00_00_00_10_00_00_00_00_10_10_00_00_00_10_00;
        #10;
        print_results(input_vec, hamming_dist0, hamming_dist1, hamming_dist2, closest_pattern);

        // Apply corrupted pattern for digit 2
        input_vec =100'b00_00_00_00_00_00_00_00_10_00_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_00_00_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_00_10;
        #10;
        print_results(input_vec, hamming_dist0, hamming_dist1, hamming_dist2, closest_pattern);

        // Finish simulation
        $finish;
    end

endmodule





















