`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12.08.2025 17:44:42
//// Design Name: 
//// Module Name: synapse
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

module synapses #(parameter n = 15)(
    input              s_clk,
    input  [n-1:0]     n_out,
    output reg [n-1:0] n_in
);

reg signed [4:0] weights [n-1:0][n-1:0];

localparam integer N2 = n * n;
localparam integer SUM_BITS = (N2 <=     16) ? 4  :
                              (N2 <=     32) ? 5  :
                              (N2 <=     64) ? 6  :
                              (N2 <=    128) ? 7  :
                              (N2 <=    256) ? 8  :
                              (N2 <=    512) ? 9  :
                              (N2 <=   1024) ? 10 :
                              (N2 <=   2048) ? 11 :
                              (N2 <=   4096) ? 12 : 32;

reg signed [SUM_BITS-1:0] sum;
integer i, j;

initial begin
    $readmemh("weights.mem", weights);
end

always @(posedge s_clk) begin
    for (i = 0; i < n; i = i + 1) begin
        sum = 0;
        for (j = 0; j < n; j = j + 1) begin
            if (n_out[j] == 1)
                sum = sum + weights[i][j];
            else
                sum = sum - weights[i][j];
        end
        if (sum > 0)
            n_in[i] <= 1;
        else
            n_in[i] <= 0;
    end
end

endmodule









