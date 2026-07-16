`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2024 11:54:13
// Design Name: 
// Module Name: onn
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




`timescale 1ns / 1ps

module onn #(parameter n = 15)(
    input  wire clk,
    input  wire reset,
    input  wire [1:0] sw,
    output wire [3:0] led
);

//----------------------------------
wire [n-1:0] n_in;
wire [n-1:0] n_out;
wire s_clk;

wire [(4*n)-1:0] phi_input;
wire [(4*n)-1:0] phi_output;

wire [4:0] hamming_dist0;
wire [4:0] hamming_dist1;
wire [1:0] closest_pattern;

//----------------------------------
// CLOCK
//----------------------------------
clk_divider clk_divider_inst (
    .clk(clk),
    .s_clk(s_clk)
);

//----------------------------------
// INPUT PATTERNS
//----------------------------------
reg [(4*n)-1:0] phi_input_reg;

always @(*) begin
    case (sw)
        2'b00: phi_input_reg = 60'h888808808080888;
        2'b01: phi_input_reg = 60'h080880080080888;
        2'b10: phi_input_reg = 60'h880808808080888;
        2'b11: phi_input_reg = 60'h080880080080880;
    endcase
end

assign phi_input = phi_input_reg;

//----------------------------------
// FULL TICK (1-cycle pulse)
//----------------------------------
reg [1:0] sw_prev;
reg full;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        sw_prev <= 0;
        full <= 0;
    end else begin
        full <= (sw != sw_prev);   // ? FIXED
        sw_prev <= sw;
    end
end

//----------------------------------
// NEURONS
//----------------------------------
neurons #(.n(n)) neurons_inst (
    .clk(clk),
    .s_clk(s_clk),
    .reset(reset),          // ? FIXED (removed full)
    .full_tick(full),
    .n_in(n_in),
    .phi_input(phi_input),
    .n_out(n_out),
    .phi_output(phi_output)
);

//----------------------------------
// SYNAPSES
//----------------------------------
synapses #(.n(n)) synapses_inst (
    .s_clk(s_clk),
    .n_out(n_out),
    .n_in(n_in)
);

//----------------------------------
// HAMMING
//----------------------------------
hamming_distance_bipolar #(.n(n)) hamming_inst (
    .phi_output(phi_output),
    .hamming_dist0(hamming_dist0),
    .hamming_dist1(hamming_dist1),
    .closest_pattern(closest_pattern)
);

//----------------------------------
// OUTPUT REGISTER (STABLE LED)
//----------------------------------
reg [1:0] result_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        result_reg <= 2'b00;
    else
        result_reg <= closest_pattern;   // ? always update
end

//----------------------------------
assign led = {2'b00, result_reg};

endmodule
