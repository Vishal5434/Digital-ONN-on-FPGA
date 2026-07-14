//`timescale 1ns / 1ps
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



////function integer clog2(input integer value);
////    integer i;
////    begin
////        clog2 = 0;
////        for (i = value - 1; i > 0; i = i >> 1)
////            clog2 = clog2 + 1;
////    end
////endfunction






//module synapses #(parameter n = 15)(input s_clk, [n-1:0]n_out, output reg [n-1:0]n_in);


//reg signed [4:0] weights [n-1:0][n-1:0];
//reg signed [4:0] weights_flat[n*n-1:0];
////initial begin

////localparam SUM_BITS = clog2(n*n);

//localparam integer N2 = n * n;
//localparam integer SUM_BITS = (N2 <=      2) ? 1 :
//                             (N2 <=      4) ? 2 :
//                             (N2 <=      8) ? 3 :
//                             (N2 <=     16) ? 4 :
//                             (N2 <=     32) ? 5 :
//                             (N2 <=     64) ? 6 :
//                             (N2 <=    128) ? 7 :
//                             (N2 <=    256) ? 8 :
//                             (N2 <=    512) ? 9 :
//                             (N2 <=   1024) ? 10 :
//                             (N2 <=   2048) ? 11 :
//                             (N2 <=   4096) ? 12 :
//                             (N2 <=   8192) ? 13 :
//                             (N2 <=  16384) ? 14 :
//                             (N2 <=  32768) ? 15 :
//                             (N2 <=  65536) ? 16 :
//                             32;


//reg signed [SUM_BITS-1:0] sum;
//integer i, j;

//initial begin
//    $readmemh("C:\\Users\\visha\\weights.mem", weights_flat);
//    for (i = 0; i < n; i = i + 1) begin
//        for (j = 0; j < n; j = j + 1) begin
//            weights[i][j] = weights_flat[i*n + j];
//        end
//    end

//end




//always @(posedge s_clk) begin

//for (i = 0; i < n; i = i + 1) begin
//    sum = 0;
//    for (j = 0; j < n; j = j + 1) begin
//        if (n_out[j] == 1)
//            sum = sum + weights[i][j];
//        else if (n_out[j] == 0)
//            sum = sum - weights[i][j];
//    if (sum > 0)
//        n_in[i] <= 1;
//    else
//        n_in[i] <= 0;
    

//    end
//    end
   
//end

//endmodule


//module synapses #(parameter n = 50)(
//    input s_clk,
//    input [n-1:0] n_out,
//    output reg [n-1:0] n_in
//);

//parameter WEIGHT_BITS = 16;
//localparam TOTAL_WEIGHTS = n * n;

//// Flattened weight array: 1D array with all weights
//reg signed [WEIGHT_BITS-1:0] weights [0:TOTAL_WEIGHTS-1];

//localparam integer N2 = n * n;
//localparam integer SUM_BITS = (N2 <=      2) ? 1 :
//                             (N2 <=      4) ? 2 :
//                             (N2 <=      8) ? 3 :
//                             (N2 <=     16) ? 4 :
//                             (N2 <=     32) ? 5 :
//                             (N2 <=     64) ? 6 :
//                             (N2 <=    128) ? 7 :
//                             (N2 <=    256) ? 8 :
//                             (N2 <=    512) ? 9 :
//                             (N2 <=   1024) ? 10 :
//                             (N2 <=   2048) ? 11 :
//                             (N2 <=   4096) ? 12 :
//                             (N2 <=   8192) ? 13 :
//                             (N2 <=  16384) ? 14 :
//                             (N2 <=  32768) ? 15 :
//                             (N2 <=  65536) ? 16 :
//                             32;

//reg signed [SUM_BITS-1:0] sum;
//integer i, j;
//integer idx;

//initial begin
//    $readmemh("C:/Users/Administrator/Desktop/weights_50x50.mem", weights);
//end

//always @(posedge s_clk) begin
//    for (i = 0; i < n; i = i + 1) begin
//        sum = 0;
//        for (j = 0; j < n; j = j + 1) begin
//            idx = i * n + j;  // Compute linear index into flat array
//            if (n_out[j] == 1)
//                sum = sum + weights[idx];
//            else
//                sum = sum - weights[idx];
//        end
//        if (sum > 0)
//            n_in[i] <= 1;
//        else
//            n_in[i] <= 0;
//    end
//end

//endmodule







`timescale 1ns / 1ps

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
    weights[0][0] = 5'd0;
    weights[0][1] = 5'd0;
    weights[0][2] = 5'd2;
    weights[0][3] = 5'd0;
    weights[0][4] = -5'd2;
    weights[0][5] = 5'd2;
    weights[0][6] = 5'd2;
    weights[0][7] = -5'd2;
    weights[0][8] = 5'd2;
    weights[0][9] = 5'd2;
    weights[0][10] = -5'd2;
    weights[0][11] = 5'd2;
    weights[0][12] = 5'd0;
    weights[0][13] = 5'd0;
    weights[0][14] = 5'd0;
    weights[1][0] = 5'd0;
    weights[1][1] = 5'd0;
    weights[1][2] = 5'd2;
    weights[1][3] = 5'd0;
    weights[1][4] = 5'd0;
    weights[1][5] = 5'd0;
    weights[1][6] = 5'd0;
    weights[1][7] = 5'd0;
    weights[1][8] = 5'd0;
    weights[1][9] = 5'd0;
    weights[1][10] = 5'd2;
    weights[1][11] = 5'd2;
    weights[1][12] = 5'd2;
    weights[1][13] = 5'd2;
    weights[1][14] = 5'd0;
    weights[2][0] = 5'd0;
    weights[2][1] = 5'd0;
    weights[2][2] = -5'd2;
    weights[2][3] = 5'd2;
    weights[2][4] = 5'd2;
    weights[2][5] = -5'd2;
    weights[2][6] = 5'd2;
    weights[2][7] = 5'd2;
    weights[2][8] = -5'd2;
    weights[2][9] = 5'd2;
    weights[2][10] = 5'd0;
    weights[2][11] = 5'd0;
    weights[2][12] = 5'd0;
    weights[2][13] = 5'd0;
    weights[2][14] = 5'd2;
    weights[3][0] = 5'd0;
    weights[3][1] = 5'd0;
    weights[3][2] = 5'd0;
    weights[3][3] = 5'd0;
    weights[3][4] = 5'd0;
    weights[3][5] = 5'd0;
    weights[3][6] = 5'd0;
    weights[3][7] = 5'd0;
    weights[3][8] = 5'd0;
    weights[3][9] = 5'd2;
    weights[3][10] = 5'd2;
    weights[3][11] = 5'd2;
    weights[3][12] = -5'd2;
    weights[3][13] = 5'd0;
    weights[3][14] = -5'd2;
    weights[4][0] = 5'd0;
    weights[4][1] = 5'd0;
    weights[4][2] = -5'd2;
    weights[4][3] = -5'd2;
    weights[4][4] = 5'd2;
    weights[4][5] = -5'd2;
    weights[4][6] = -5'd2;
    weights[4][7] = 5'd2;
    weights[4][8] = -5'd2;
    weights[4][9] = 5'd0;
    weights[4][10] = 5'd0;
    weights[4][11] = 5'd0;
    weights[4][12] = 5'd2;
    weights[4][13] = 5'd0;
    weights[4][14] = 5'd2;
    weights[5][0] = 5'd0;
    weights[5][1] = -5'd2;
    weights[5][2] = 5'd0;
    weights[5][3] = 5'd2;
    weights[5][4] = -5'd2;
    weights[5][5] = 5'd2;
    weights[5][6] = 5'd2;
    weights[5][7] = -5'd2;
    weights[5][8] = 5'd2;
    weights[5][9] = 5'd0;
    weights[5][10] = 5'd0;
    weights[5][11] = 5'd0;
    weights[5][12] = 5'd2;
    weights[5][13] = 5'd0;
    weights[5][14] = 5'd2;
    weights[6][0] = 5'd0;
    weights[6][1] = -5'd2;
    weights[6][2] = 5'd2;
    weights[6][3] = 5'd0;
    weights[6][4] = -5'd2;
    weights[6][5] = 5'd2;
    weights[6][6] = 5'd2;
    weights[6][7] = -5'd2;
    weights[6][8] = 5'd2;
    weights[6][9] = 5'd0;
    weights[6][10] = 5'd0;
    weights[6][11] = 5'd0;
    weights[6][12] = -5'd2;
    weights[6][13] = 5'd0;
    weights[6][14] = -5'd2;
    weights[7][0] = 5'd0;
    weights[7][1] = 5'd2;
    weights[7][2] = -5'd2;
    weights[7][3] = -5'd2;
    weights[7][4] = 5'd0;
    weights[7][5] = -5'd2;
    weights[7][6] = -5'd2;
    weights[7][7] = 5'd2;
    weights[7][8] = -5'd2;
    weights[7][9] = 5'd0;
    weights[7][10] = 5'd0;
    weights[7][11] = 5'd0;
    weights[7][12] = 5'd2;
    weights[7][13] = 5'd0;
    weights[7][14] = 5'd2;
    weights[8][0] = 5'd0;
    weights[8][1] = -5'd2;
    weights[8][2] = 5'd2;
    weights[8][3] = 5'd2;
    weights[8][4] = -5'd2;
    weights[8][5] = 5'd0;
    weights[8][6] = 5'd2;
    weights[8][7] = -5'd2;
    weights[8][8] = 5'd2;
    weights[8][9] = 5'd0;
    weights[8][10] = 5'd0;
    weights[8][11] = 5'd0;
    weights[8][12] = 5'd2;
    weights[8][13] = 5'd0;
    weights[8][14] = 5'd2;
    weights[9][0] = 5'd0;
    weights[9][1] = -5'd2;
    weights[9][2] = 5'd2;
    weights[9][3] = 5'd2;
    weights[9][4] = -5'd2;
    weights[9][5] = 5'd2;
    weights[9][6] = 5'd0;
    weights[9][7] = -5'd2;
    weights[9][8] = 5'd2;
    weights[9][9] = 5'd0;
    weights[9][10] = 5'd0;
    weights[9][11] = 5'd0;
    weights[9][12] = -5'd2;
    weights[9][13] = 5'd0;
    weights[9][14] = -5'd2;
    weights[10][0] = 5'd0;
    weights[10][1] = 5'd2;
    weights[10][2] = -5'd2;
    weights[10][3] = -5'd2;
    weights[10][4] = 5'd2;
    weights[10][5] = -5'd2;
    weights[10][6] = -5'd2;
    weights[10][7] = 5'd0;
    weights[10][8] = -5'd2;
    weights[10][9] = 5'd0;
    weights[10][10] = 5'd0;
    weights[10][11] = 5'd0;
    weights[10][12] = 5'd2;
    weights[10][13] = 5'd0;
    weights[10][14] = 5'd2;
    weights[11][0] = 5'd0;
    weights[11][1] = -5'd2;
    weights[11][2] = 5'd2;
    weights[11][3] = 5'd2;
    weights[11][4] = -5'd2;
    weights[11][5] = 5'd2;
    weights[11][6] = 5'd2;
    weights[11][7] = -5'd2;
    weights[11][8] = 5'd0;
    weights[11][9] = 5'd0;
    weights[11][10] = 5'd0;
    weights[11][11] = 5'd0;
    weights[11][12] = 5'd0;
    weights[11][13] = 5'd2;
    weights[11][14] = 5'd0;
    weights[12][0] = 5'd2;
    weights[12][1] = 5'd0;
    weights[12][2] = 5'd0;
    weights[12][3] = 5'd0;
    weights[12][4] = 5'd0;
    weights[12][5] = 5'd0;
    weights[12][6] = 5'd0;
    weights[12][7] = 5'd0;
    weights[12][8] = 5'd0;
    weights[12][9] = 5'd2;
    weights[12][10] = 5'd2;
    weights[12][11] = 5'd0;
    weights[12][12] = 5'd2;
    weights[12][13] = 5'd0;
    weights[12][14] = 5'd2;
    weights[13][0] = 5'd0;
    weights[13][1] = 5'd0;
    weights[13][2] = 5'd0;
    weights[13][3] = 5'd0;
    weights[13][4] = 5'd0;
    weights[13][5] = 5'd0;
    weights[13][6] = 5'd0;
    weights[13][7] = 5'd2;
    weights[13][8] = 5'd0;
    weights[13][9] = 5'd2;
    weights[13][10] = 5'd0;
    weights[13][11] = 5'd2;
    weights[13][12] = 5'd0;
    weights[13][13] = 5'd2;
    weights[13][14] = 5'd0;
    weights[14][0] = 5'd0;
    weights[14][1] = 5'd0;
    weights[14][2] = 5'd0;
    weights[14][3] = 5'd0;
    weights[14][4] = 5'd0;
    weights[14][5] = 5'd0;
    weights[14][6] = 5'd0;
    weights[14][7] = 5'd2;
    weights[14][8] = 5'd2;
    weights[14][9] = 5'd0;
    weights[14][10] = 5'd2;
    weights[14][11] = 5'd2;
    weights[14][12] = 5'd0;
    weights[14][13] = 5'd0;
    weights[14][14] = 5'd0;
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









