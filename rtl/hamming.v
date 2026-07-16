`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////
////// Company: 
////// Engineer: 
////// 
////// Create Date: 23.08.2025 17:26:06
////// Design Name: 
////// Module Name: hamming
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

module hamming_distance_bipolar #(parameter n = 15)(
    input  [(4*n)-1:0] phi_output,
    output reg [4:0]   hamming_dist0,
    output reg [4:0]   hamming_dist1,
    output reg [1:0]   closest_pattern
);

wire [(2*n)-1:0] bipolar_vec;

phase_to_bipolar #(.n(n)) converter_inst (
    .phi_output  (phi_output),
    .bipolar_vec (bipolar_vec)
);

// Patterns
localparam [(2*n)-1:0] pattern0 =
    30'b10_10_10_10_00_10_10_00_10_10_00_10_10_10_10;

localparam [(2*n)-1:0] pattern1 =
    30'b10_10_10_00_10_00_00_10_00_00_10_10_00_10_00;

integer i;
reg [1:0] inp_2b;
reg [1:0] p0_2b;
reg [1:0] p1_2b;

reg [4:0] sum0;
reg [4:0] sum1;

always @(*) begin
    sum0 = 0;
    sum1 = 0;

    for (i = 0; i < n; i = i + 1) begin
        inp_2b = bipolar_vec[2*i +: 2];
        p0_2b  = pattern0[2*i +: 2];
        p1_2b  = pattern1[2*i +: 2];

        // ? TRUE Hamming
        sum0 = sum0 + (inp_2b != p0_2b);
        sum1 = sum1 + (inp_2b != p1_2b);
    end

    hamming_dist0 = sum0;
    hamming_dist1 = sum1;

    if (hamming_dist0 <= hamming_dist1)
        closest_pattern = 2'b10;
    else
        closest_pattern = 2'b01;
end

endmodule
