`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 13:47:34
// Design Name: 
// Module Name: neuron
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

module neurons #(parameter n = 15)(input clk,s_clk,reset,full_tick,[n-1:0]n_in,[(4*n)-1:0]phi_input, output [n-1:0]n_out,[(4*n)-1:0]phi_output);

wire [3:0]phi_in[n-1:0];
wire [3:0]phi_out[n-1:0];
//assign {phi_in[0], phi_in[1], phi_in[2], phi_in[3], phi_in[4], phi_in[5], phi_in[6], phi_in[7], phi_in[8], phi_in[9], phi_in[10], phi_in[11], phi_in[12], phi_in[13], phi_in[14]} = phi_input;
//assign phi_output = {phi_out[0], phi_out[1], phi_out[2], phi_out[3], phi_out[4], phi_out[5], phi_out[6], phi_out[7], phi_out[8], phi_out[9], phi_out[10], phi_out[11], phi_out[12], phi_out[13], phi_out[14]};
genvar i;
generate
    for (i=0; i<n; i=i+1) begin : unpack_phi_in
        assign phi_in[i] = phi_input[4*(n - 1 - i) + 3 : 4*(n - 1 - i)];
        // Explanation: slice 4 bits starting at bit 4*(n-1 - i)
    end
endgenerate

// Pack phi_out array into phi_output vector
// phi_out[0] assigned to MSB 4 bits of phi_output
generate
    for (i=0; i<n; i=i+1) begin : pack_phi_out
       assign phi_output[4*(n - 1 - i) + 3 : 4*(n - 1 - i)] = phi_out[i];

    end
endgenerate
//genvar i;
generate
    for (i = 0; i < n; i = i + 1) begin : neuron
        neuron neuron_inst (
            .clk(clk),
            .s_clk(s_clk),
            .reset(reset),
            .full_tick(full_tick),
            .n_in(n_in[i]),
            .phi_in(phi_in[i]),
            .n_out(n_out[i]),
            .phi_out(phi_out[i])
        );
    end
endgenerate

endmodule

//module neuron(input clk,s_clk,reset,full_tick,n_in,[3:0]phi_in, output [3:0]phi_out, output n_out);
//reg [3:0]phi_reg;
//wire [3:0] phi_calc_out; 
//always @(posedge clk ) begin
//    if (full_tick)
//        phi_reg <= phi_in;   
//     else
//     phi_reg <= phi_calc_out;
//end
//assign phi_out = phi_calc_out;
////always @(*) begin
////    phi_reg = phi_out;
////end

//phase_calculator ph_cal_inst (s_clk,reset,n_in,n_out,phi_reg,phi_calc_out);
//phase_controlled_osci ph_osci_inst ( reset,s_clk,phi_reg, n_out );

//endmodule
module neuron(
    input clk, s_clk, reset, full_tick, n_in,
    input  [3:0] phi_in,
    output [3:0] phi_out,
    output n_out
);

reg  [3:0] phi_reg;
wire [3:0] phi_calc_out;

// phi_reg is the ONLY driver of itself
always @(posedge clk) begin
    if (reset)
        phi_reg <= 4'd0;
    else if (full_tick)
        phi_reg <= phi_in;
    else
        phi_reg <= phi_calc_out;
end

// phi_calc_out driven ONLY by phase_calculator
// Pass phi_reg (current phase) into calculator, get next phase out
phase_calculator ph_cal_inst (
    .clk    (s_clk),
    .reset  (reset),
    .nin    (n_in),
    .nout   (n_out),
    .phi_in (phi_reg),       // <-- feed REGISTERED phi, not phi_calc_out
    .phi_out(phi_calc_out)
);

// Oscillator uses the stable registered phase
phase_controlled_osci ph_osci_inst (
    .reset  (reset),
    .clk    (s_clk),
    .phi_out(phi_reg),       // <-- use registered value
    .n_out  (n_out)
);

assign phi_out = phi_reg;   // output the registered phase

endmodule

module phase_controlled_osci(input reset,clk,[3:0]phi_out,output reg n_out );

reg [15:0]cir_shift_reg;
always @(posedge clk or posedge reset)
begin
    if (reset)
        cir_shift_reg <= 16'b1111111100000000;
    else
        cir_shift_reg <= {cir_shift_reg[0], cir_shift_reg[15:1]}; // Circular shift
    
end

always @(phi_out,cir_shift_reg) begin
    case (phi_out)
        4'b0000: n_out = cir_shift_reg[0];
        4'b0001: n_out = cir_shift_reg[1];
        4'b0010: n_out = cir_shift_reg[2];
        4'b0011: n_out = cir_shift_reg[3];
        4'b0100: n_out = cir_shift_reg[4];
        4'b0101: n_out = cir_shift_reg[5];
        4'b0110: n_out = cir_shift_reg[6];
        4'b0111: n_out = cir_shift_reg[7];
        4'b1000: n_out = cir_shift_reg[8];
        4'b1001: n_out = cir_shift_reg[9];
        4'b1010: n_out = cir_shift_reg[10];
        4'b1011: n_out = cir_shift_reg[11];
        4'b1100: n_out = cir_shift_reg[12];
        4'b1101: n_out = cir_shift_reg[13];
        4'b1110: n_out = cir_shift_reg[14];
        4'b1111: n_out = cir_shift_reg[15];
    endcase
end

endmodule

module phase_calculator (
    input clk,
    input reset,
    input nin,
    input nout,
    input [3:0] phi_in,
    output reg [3:0] phi_out
);

// Edge detectors
reg nin_prev, nout_prev;
wire nin_rising_edge, nout_rising_edge;

assign nin_rising_edge = ~nin_prev & nin;
assign nout_rising_edge = ~nout_prev & nout;

always @(posedge clk) begin
    nin_prev <= nin;
    nout_prev <= nout;
end

// Finite State Machine (FSM)
localparam IDLE = 2'b00,
            WAIT_NOUT = 2'b01,
            WAIT_NIN = 2'b10;

reg [1:0] state;
reg [3:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 4'd0;
        phi_out <= 4'd0;
    end else begin
        case (state)
            IDLE: begin
                if (nin_rising_edge) begin
                    state <= WAIT_NOUT;
                    counter <= 4'd0;
                end
                if (nout_rising_edge) begin
                    state <= WAIT_NIN;
                    counter <= 4'd0;
                end
            end
            WAIT_NOUT: begin
                if (nout_rising_edge) begin
                    state <= IDLE;
                    phi_out <= phi_in + counter;
                end else begin
                    counter <= counter + 4'd1;
                end
            end
            WAIT_NIN: begin
                if (nin_rising_edge) begin
                    state <= IDLE;
                    phi_out <= phi_in - counter;
                end else begin
                    counter <= counter + 4'd1;
                end
            end
        endcase
    end
end

endmodule