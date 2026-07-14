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



//module onn #(parameter n = 15)(input clk,reset,full_tick,[(4*n)-1:0]phi_input,output s_clk,[(4*n)-1:0]phi_output);
//wire [n-1:0]n_in;
//wire [n-1:0]n_out;
//clk_divider clk_divider_inst (.clk(clk),.s_clk(s_clk));

//neurons neurons_inst (.clk(clk),.s_clk(s_clk),.reset(reset),.full_tick(full_tick),.n_in(n_in),.phi_input(phi_input),.n_out(n_out),.phi_output(phi_output));
//synapses synapses_inst (.s_clk(s_clk),.n_out(n_out),.n_in(n_in));

//endmodule




//module onn #(parameter n = 15)(
//    input                clk,
//    input                reset,
//    input                full_tick,
//    input  [(4*n)-1:0]   phi_input,
//    output               s_clk,
//    output [(4*n)-1:0]   phi_output,
//    output [3:0]         hamming_dist0,
//    output [3:0]         hamming_dist1,
//    output [1:0]         closest_pattern
//);

//wire [n-1:0] n_in;
//wire [n-1:0] n_out;

//clk_divider clk_divider_inst (
//    .clk   (clk),
//    .s_clk (s_clk)
//);

//neurons neurons_inst (
//    .clk        (clk),
//    .s_clk      (s_clk),
//    .reset      (reset),
//    .full_tick  (full_tick),
//    .n_in       (n_in),
//    .phi_input  (phi_input),
//    .n_out      (n_out),
//    .phi_output (phi_output)
//);

//synapses synapses_inst (
//    .s_clk (s_clk),
//    .n_out (n_out),
//    .n_in  (n_in)
//);

//hamming_distance_bipolar #(.n(n)) hamming_inst (
//    .phi_output      (phi_output),
//    .hamming_dist0   (hamming_dist0),
//    .hamming_dist1   (hamming_dist1),
//    .closest_pattern (closest_pattern)
//);

//endmodule


//`timescale 1ns / 1ps

//`timescale 1ns / 1ps

//module onn #(
//    parameter n = 15
//)(
//    input  wire clk,
//    input  wire reset,
//    input  wire phi_in_serial,

//    output wire [3:0] led
    
//);

//    //-------------------------------
//    // Internal Signals
//    //-------------------------------
//    wire [n-1:0] n_in;
//    wire [n-1:0] n_out;
//    wire         s_clk;

//    reg  [63:0] phi_shift;
//    wire [(4*n)-1:0] phi_input;

//    reg  [2:0] byte_count;

//    wire        dv;
//    wire [7:0]  rx_data;

//    wire [3:0] hamming_dist0;
//    wire [3:0] hamming_dist1;
//    wire [(4*n)-1:0] phi_output;
//     reg  full;
//     wire [1:0] closest_pattern;
//    assign phi_input = phi_shift[59:0];

//    //-------------------------------
//    // Clock Divider
//    //-------------------------------
//    clk_divider clk_divider_inst (
//        .clk   (clk),
//        .s_clk (s_clk)
//    );

//    //-------------------------------
//    // UART RX (YOUR VERSION)
//    //-------------------------------
//    uart_rx #(
//        .CLK_FREQ(125000000),
//        .BAUD_RATE(9600)
//    ) uart_rx_inst (
//        .clk(clk),
//        .reset(reset),
//        .rx(phi_in_serial),
//        .data_valid(dv),
//        .data_out(rx_data)
//    );

//    //-------------------------------
//    // UART ? 60-bit Loader
//    //-------------------------------
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            phi_shift  <= 0;
//            byte_count <= 0;
//            full       <= 0;
//        end else begin
//            full <= 0;  // 1-cycle pulse

//            if (dv) begin
//                phi_shift <= {phi_shift[55:0], rx_data};

//                if (byte_count == 3'd7) begin
//                    byte_count <= 0;
//                    full <= 1;   // trigger ONN
//                end else begin
//                    byte_count <= byte_count + 1;
//                end
//            end
//        end
//    end

//    //-------------------------------
//    // Neurons
//    //-------------------------------
//    neurons #(.n(n)) neurons_inst (
//        .clk        (clk),
//        .s_clk      (s_clk),
//        .reset      (reset),
//        .full_tick  (full),
//        .n_in       (n_in),
//        .phi_input  (phi_input),
//        .n_out      (n_out),
//        .phi_output (phi_output)
//    );

//    //-------------------------------
//    // Synapses
//    //-------------------------------
//    synapses #(.n(n)) synapses_inst (
//        .s_clk (s_clk),
//        .n_out (n_out),
//        .n_in  (n_in)
//    );

//    //-------------------------------
//    // Hamming Distance (YOUR MODULE)
//    //-------------------------------
//    hamming_distance_bipolar #(.n(n)) hamming_inst (
//        .phi_output       (phi_output),
//        .hamming_dist0    (hamming_dist0),
//        .hamming_dist1    (hamming_dist1),
//        .closest_pattern  (closest_pattern)
//    );

//    //-------------------------------
//    // LED OUTPUT (4 LEDs ONLY)
//    //-------------------------------
//     assign led = rx_data[3:0];

//endmodule

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
