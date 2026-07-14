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


////module hamming(input signed [29:0] nin, 
////input [2:0] threshold, output reg signed [29:0] nout);
////reg signed[1:0] zero[14:0];
////reg signed[1:0] one[14:0];
////reg signed[1:0] two[14:0];
////reg  [5:0] sum0 ;
////reg  [5:0] sum1 ;
////reg  [5:0] sum2 ;
////reg signed [1:0] nin_unpacked[14:0];
////reg [5:0] hd0 ; // divide sum0 by 2
////reg [5:0] hd1 ;// divide sum1 by 2
////reg [5:0] hd2 ;  // divide sum2 by 2

////integer i;
////always@(*)begin
////nout = 0;
////zero[14] = -1; 
////zero[13] = -1; 
////zero[12] = -1; 
////zero[11] = -1; 
////zero[10] = 1; 
////zero[9] = -1; 
////zero[8] = -1; 
////zero[7] = 1; 
////zero[6] = -1; 
////zero[5] = -1; 
////zero[4] = 1; 
////zero[3] = -1; 
////zero[2] = -1; 
////zero[1] = -1; 
////zero[0] = -1; 

////one[14] = 1; 
////one[13] = 1; 
////one[12] = -1; 
////one[11] = 1; 
////one[10] = 1; 
////one[9] = -1; 
////one[8] = 1; 
////one[7] = 1; 
////one[6] = -1; 
////one[5] = 1; 
////one[4] = 1; 
////one[3] = -1; 
////one[2] = 1; 
////one[1] = 1; 
////one[0] = -1;

////two[14]= -1;
////two[13]= -1;
////two[12]= -1;
////two[11]= 1;
////two[10]= 1;
////two[9]= -1;
////two[8]= -1;
////two[7]= -1;
////two[6]= -1;
////two[5]= -1;
////two[4]= 1;
////two[3]= 1;
////two[2]= -1;
////two[1]= -1;
////two[0]= -1;

//////nin_unpacked[0]= nin[1:-1];
//////nin_unpacked[1]= nin[3:-1];
//////nin_unpacked[2]= nin[5:-1];
//////nin_unpacked[3]= nin[7:-1];
//////nin_unpacked[4]= nin[9:-1];
//////nin_unpacked[5]= nin[11:-1];
//////nin_unpacked[6]= nin[13:-1];
//////nin_unpacked[7]= nin[15:-1];
//////nin_unpacked[8]= nin[17:-1];
//////nin_unpacked[9]= nin[19:-1];
//////nin_unpacked[10]= nin[21:-1];
//////nin_unpacked[11]= nin[23:-1];
//////nin_unpacked[12]= nin[25:-1];
//////nin_unpacked[13]= nin[27:-1];
//////nin_unpacked[14]= nin[29:-1];


//// for (i = 0; i < 15; i = i + 1) begin
////        nin_unpacked[i] = nin[(2*i+1) -: 2]; 
////    end
    
////sum0 =0;sum1=0; sum2=0;

////for(i=0;i <15;i= i+1)begin : Hamming_Distance

//// sum0 = sum0 + ((zero[i] - nin_unpacked[i]) < 0 ?
////  -(zero[i] - nin_unpacked[i]) : (zero[i] - nin_unpacked[i]));
////        // For one pattern
////  sum1 = sum1 + ((one[i] - nin_unpacked[i]) < 0?
////   -(one[i] - nin_unpacked[i]) : (one[i] - nin_unpacked[i]));
////        // For two pattern
////   sum2 = sum2 + ((two[i] - nin_unpacked[i]) < 0? 
////    -(two[i] - nin_unpacked[i]) : (two[i] - nin_unpacked[i]));

////end

////hd0 = sum0>>1;
////hd1 = sum1>>1;
////hd2 = sum2>>1;

////$display("nin_unpacked: %d", {nin_unpacked[14], nin_unpacked[13], nin_unpacked[12], nin_unpacked[11],
////                              nin_unpacked[10], nin_unpacked[9], nin_unpacked[8], nin_unpacked[7],
////                              nin_unpacked[6], nin_unpacked[5], nin_unpacked[4], nin_unpacked[3], 
////                              nin_unpacked[2], nin_unpacked[1], nin_unpacked[0]});

////$display("sum0=%d sum1=%d sum2=%d hd0=%d hd1=%d hd2=%d threshold=%d ", 
////sum0, sum1, sum2, hd0, hd1, hd2, threshold);
////$display("zero: %d", {zero[14], zero[13], zero[12], zero[11],
////                              zero[10], zero[9], zero[8], zero[7],
////                              zero[6], zero[5], zero[4], zero[3], 
////                              zero[2], zero[1], zero[0]});


////if(hd0 <= threshold)begin
////for (i = 0; i < 15; i = i + 1) begin
////            nout[2*i +: 2] = zero[i];
////        end
////end
////else if( hd1<= threshold) begin
////for (i = 0; i < 15; i = i + 1) begin
////            nout[2*i +: 2] = one[i];
////        end
////end

////else if (hd2<= threshold)begin
////for (i = 0; i < 15; i = i + 1) begin
////            nout[2*i +: 2] = two[i];
////        end

////end

////else begin nout=0;
////end
////end
////endmodule


//module onn_digit_recog (
//    input  wire [59:0] sample,    // 15 neurons x 4 bits phase = 60 bits
//    output reg  [1:0]  digit_out, // 2'b00 = digit0, 2'b01 = digit1, 2'b10 = digit2, 2'b11 = no match
//    output reg  [3:0]  min_dist   // Number of neuron mismatches for best match
//);

//    // Templates as packed 2D array (digit x neuron)
//    // [digit][neuron] -- leftmost bit neuron 0, rightmost neuron 14
//    reg [3:0] template [0:2][0:14];
//    initial begin
//        // Digit 0
//        template[0][ 0]=4'd8; template[0][ 1]=4'd8; template[0][ 2]=4'd8; template[0][ 3]=4'd8; template[0][ 4]=4'd0;
//        template[0][ 5]=4'd8; template[0][ 6]=4'd8; template[0][ 7]=4'd0; template[0][ 8]=4'd8; template[0][ 9]=4'd8;
//        template[0][10]=4'd0; template[0][11]=4'd8; template[0][12]=4'd8; template[0][13]=4'd8; template[0][14]=4'd8;
//        // Digit 1
//        template[1][ 0]=4'd0; template[1][ 1]=4'd0; template[1][ 2]=4'd8; template[1][ 3]=4'd0; template[1][ 4]=4'd0;
//        template[1][ 5]=4'd8; template[1][ 6]=4'd0; template[1][ 7]=4'd0; template[1][ 8]=4'd8; template[1][ 9]=4'd0;
//        template[1][10]=4'd0; template[1][11]=4'd8; template[1][12]=4'd0; template[1][13]=4'd0; template[1][14]=4'd8;
//        // Digit 2
//        template[2][ 0]=4'd8; template[2][ 1]=4'd8; template[2][ 2]=4'd8; template[2][ 3]=4'd0; template[2][ 4]=4'd0;
//        template[2][ 5]=4'd8; template[2][ 6]=4'd8; template[2][ 7]=4'd8; template[2][ 8]=4'd8; template[2][ 9]=4'd0;
//        template[2][10]=4'd0; template[2][11]=4'd8; template[2][12]=4'd8; template[2][13]=4'd8; template[2][14]=4'd8;
//    end

//    // Convert phase to bipolar
//    function [1:0] phase2bipolar;
//        input [3:0] p;
//        begin
//            case (p)
//                4'd0, 4'd1, 4'd2, 4'd14, 4'd15: phase2bipolar = 2'b01;  // white
//                4'd6,4'd7,4'd8, 4'd9, 4'd10:                   phase2bipolar = 2'b11;  // black (use binary '11' as -1)
//                default:                             phase2bipolar = 2'b00;  // Gray/unknown/mismatch
//            endcase
//        end
//    endfunction

//    // Returns 1 if sample and template neuron phases match in color (with tolerance), 0 otherwise
//    function is_close;
//        input [3:0] s;
//        input [3:0] t;
//        reg [1:0] bip_s, bip_t;
//        begin
//            bip_s = phase2bipolar(s);
//            bip_t = phase2bipolar(t);
//            if (bip_s == 0 || bip_t == 0)
//                is_close = 0;
//            else if (bip_s == bip_t)
//                is_close = 1;
//            else
//                is_close = 0;
//        end
//    endfunction

//    integer i, d;
//    reg [3:0] dist [0:2]; // Per-digit mismatch counts
//    reg [3:0] temp_phase, sample_phase;

//    always @* begin
//        // Reset mismatch counters
//        dist[0]=0; dist[1]=0; dist[2]=0;
//        // For each digit and each neuron, count mismatches
//        for (d=0; d < 3; d = d + 1)
//            for (i=0; i < 15; i = i + 1) begin
//               sample_phase = sample[59 - i*4 -: 4];
//                temp_phase   = template[d][i];
//                if (!is_close(sample_phase, temp_phase))
//                    dist[d] = dist[d] + 1;
//            end

//        // Find minimum
//        min_dist = dist[0];
//        digit_out = 2'b00;
//        if (dist[1] < min_dist) begin min_dist = dist[1]; digit_out = 2'b01; end
//        if (dist[2] < min_dist) begin min_dist = dist[2]; digit_out = 2'b10; end
//        // Threshold: require less than 3 mismatches
//        if (min_dist > 3)
//            digit_out = 2'b11;
//    end

//endmodule

//module hamming_distance_bipolar #(parameter n = 15)(
//    input [(2*n)-1:0] input_vec,         // 2 bits per neuron * 15 neurons
//    output reg [4:0] hamming_dist0,
//    output reg [4:0] hamming_dist1,
//    output reg [4:0] hamming_dist2,
//    output reg [1:0] closest_pattern
//);

//    // Stored patterns, 2 bits per neuron encoding as before
//    localparam [(2*n)-1:0] pattern0 = 30'b10_10_10_10_00_10_10_00_10_10_00_10_10_10_10;
//    localparam [(2*n)-1:0] pattern1 = 30'b00_00_10_00_00_10_00_00_10_00_00_10_00_00_10;
//    localparam [(2*n)-1:0] pattern2 = 30'b10_10_10_00_00_10_10_10_10_10_00_00_10_10_10;

//    integer i;
//    reg signed [1:0] input_bipolar; // +1 or -1
//    reg signed [1:0] pat0_bipolar;
//    reg signed [1:0] pat1_bipolar;
//    reg signed [1:0] pat2_bipolar;

//    reg signed [5:0] diff0_sum;
//    reg signed [5:0] diff1_sum;
//    reg signed [5:0] diff2_sum;

//    reg signed [2:0] diff;  //3 bit

//    always @(*) begin
//        diff0_sum = 0;
//        diff1_sum = 0;
//        diff2_sum = 0;
//    //00-->1-->white
//        for (i = 0; i < n; i = i + 1) begin
//            // Convert 2-bit to bipolar +1/-1
//            input_bipolar = (input_vec[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//            pat0_bipolar = (pattern0[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//            pat1_bipolar = (pattern1[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//            pat2_bipolar = (pattern2[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;

//            // Calculate difference and sum
//            //diff = input_bipolar - pat0_bipolar;
//           // diff0_sum = diff0_sum + diff;
//            diff = input_bipolar - pat0_bipolar;
//            diff0_sum = diff0_sum + (diff < 0 ? -diff : diff);

//            diff = input_bipolar - pat1_bipolar;
//            //diff1_sum = diff1_sum + diff;
//            diff1_sum = diff1_sum + (diff < 0 ? -diff : diff);
//            diff = input_bipolar - pat2_bipolar;
//            //diff2_sum = diff2_sum + diff;
//             diff2_sum = diff2_sum + (diff < 0 ? -diff : diff);
//        end
//        //right shift--> divide by 2
//        // Hamming distance HD = 0.5 * sum of differences (absolute value)
//        hamming_dist0 = (diff0_sum < 0) ? (-diff0_sum >> 1) : (diff0_sum >> 1);
//        hamming_dist1 = (diff1_sum < 0) ? (-diff1_sum >> 1) : (diff1_sum >> 1);
//        hamming_dist2 = (diff2_sum < 0) ? (-diff2_sum >> 1) : (diff2_sum >> 1);

//        // Determine closest pattern
//        if (hamming_dist0 <= hamming_dist1 && hamming_dist0 <= hamming_dist2)
//            closest_pattern = 2'b00;
//        else if (hamming_dist1 <= hamming_dist0 && hamming_dist1 <= hamming_dist2)
//            closest_pattern = 2'b01;
//        else
//            closest_pattern = 2'b10;
//    end
//endmodule



//module hamming_distance_bipolar #(parameter n = 15)(
//    input [(2*n)-1:0] input_vec,         // 2 bits per neuron * n neurons
//    output reg [clog2(2*n)-1:0] hamming_dist0,
//    output reg [clog2(2*n)-1:0] hamming_dist1,
//    output reg [clog2(2*n)-1:0] hamming_dist2,
//    output reg [1:0] closest_pattern
//);

//// CLOG2 function, for width calculation (parameterizable for synthesis if your tool supports it)
//function integer clog2;
//    input integer value;
//    integer i;
//    begin
//        clog2 = 0;
//        for (i = value - 1; i > 0; i = i >> 1)
//            clog2 = clog2 + 1;
//    end
//endfunction

//// Stored patterns, 2 bits per neuron encoding
//localparam [(2*n)-1:0] pattern0 = 100'b10_10_10_10_10_10_10_10_10_10_10_10_00_10_10_10_10_00_10_10_10_10_00_10_10_10_10_00_10_10_10_10_00_10_10_10_10_00_10_10_10_10_10_10_10_10_10_10_10_10;

//localparam [(2*n)-1:0] pattern1 = 100'b00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10_00_00_00_10_10;
//localparam [(2*n)-1:0] pattern2 = 100'b10_10_10_10_10_10_10_10_10_10_00_00_00_10_10_00_00_00_10_10_10_10_10_10_10_10_10_10_10_10_10_10_00_00_00_10_10_00_00_00_10_10_10_10_10_10_10_10_10_10; 

//integer i;
//reg signed [1:0] input_bipolar; // +1 or -1
//reg signed [1:0] pat0_bipolar, pat1_bipolar, pat2_bipolar;
//reg signed [clog2(2*n+1):0] diff0_sum, diff1_sum, diff2_sum;
//reg signed [2:0] diff;

//always @(*) begin
//    diff0_sum = 0;
//    diff1_sum = 0;
//    diff2_sum = 0;
//    for (i = 0; i < n; i = i + 1) begin
//        input_bipolar = (input_vec[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//        pat0_bipolar = (pattern0[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//        pat1_bipolar = (pattern1[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;
//        pat2_bipolar = (pattern2[i*2 +: 2] == 2'b00) ? 2'd1 : -2'd1;

//        diff = input_bipolar - pat0_bipolar;
//        diff0_sum = diff0_sum + (diff < 0 ? -diff : diff);

//        diff = input_bipolar - pat1_bipolar;
//        diff1_sum = diff1_sum + (diff < 0 ? -diff : diff);

//        diff = input_bipolar - pat2_bipolar;
//        diff2_sum = diff2_sum + (diff < 0 ? -diff : diff);
//    end

//    // Hamming distance HD = 0.5 * sum of absolute differences
//    hamming_dist0 = (diff0_sum < 0 ? -diff0_sum : diff0_sum) >> 1;
//    hamming_dist1 = (diff1_sum < 0 ? -diff1_sum : diff1_sum) >> 1;
//    hamming_dist2 = (diff2_sum < 0 ? -diff2_sum : diff2_sum) >> 1;

//    // Determine closest pattern
//    if (hamming_dist0 <= hamming_dist1 && hamming_dist0 <= hamming_dist2)
//        closest_pattern = 2'b00;
//    else if (hamming_dist1 <= hamming_dist0 && hamming_dist1 <= hamming_dist2)
//        closest_pattern = 2'b01;
//    else
//        closest_pattern = 2'b10;
//end
//endmodule


//`timescale 1ns / 1ps

//module hamming_distance_bipolar #(
//    parameter n            = 15
//)(
//    input                  s_clk,
//    input                  reset,
//    input  [(4*n)-1:0]     phi_output,
//    output reg [3:0]       hamming_dist0,
//    output reg [3:0]       hamming_dist1,
//    output reg [1:0]       closest_pattern,
//    output                 converged
//);
//wire [(4*n)-1:0] phi_output;
//wire [(2*n)-1:0] bipolar_vec;



//// step 2: phase to bipolar
//// takes phi_stable from convergence detector
//phase_to_bipolar #(.n(n)) converter_inst (
//    .phi_output  (phi_output),
//    .bipolar_vec (bipolar_vec)
//);

//// ----------------------------------------------------------------
//// digit0 = [ 1, 1, 1,    n0 =10, n1 =10, n2 =10
////            1,-1, 1,    n3 =10, n4 =00, n5 =10
////            1,-1, 1,    n6 =10, n7 =00, n8 =10
////            1,-1, 1,    n9 =10, n10=00, n11=10
////            1, 1, 1]    n12=10, n13=10, n14=10
////
//// digit1 = [-1, 1,-1,    n0 =00, n1 =10, n2 =00
////            1, 1,-1,    n3 =10, n4 =10, n5 =00
////           -1, 1,-1,    n6 =00, n7 =10, n8 =00
////           -1, 1,-1,    n9 =00, n10=10, n11=00
////            1, 1, 1]    n12=10, n13=10, n14=10
////
//// localparam bit order: n14(MSB) downto n0(LSB)
//// ----------------------------------------------------------------

//localparam [(2*n)-1:0] pattern0 =
//    30'b10_10_10_10_00_10_10_00_10_10_00_10_10_10_10;
////    n14 n13 n12 n11 n10 n9  n8  n7  n6  n5  n4  n3  n2  n1  n0

//localparam [(2*n)-1:0] pattern1 =
//    30'b10_10_10_00_10_00_00_10_00_00_10_10_00_10_00;
////    n14 n13 n12 n11 n10 n9  n8  n7  n6  n5  n4  n3  n2  n1  n0

//integer i;
//reg [1:0] inp_2b;
//reg [1:0] p0_2b;
//reg [1:0] p1_2b;
//reg [3:0] sum0;
//reg [3:0] sum1;

//// step 3: hamming distance
//always @(*) begin
//    sum0 = 0;
//    sum1 = 0;

//    for (i = 0; i < n; i = i + 1) begin
//        inp_2b = bipolar_vec[i*2 +: 2];
//        p0_2b  = pattern0[i*2 +: 2];
//        p1_2b  = pattern1[i*2 +: 2];

//        // skip gray neurons
//        if (inp_2b != 2'b01) begin
//            sum0 = sum0 + (inp_2b[1] ^ p0_2b[1]);
//            sum1 = sum1 + (inp_2b[1] ^ p1_2b[1]);
//        end
//    end

//    hamming_dist0 = sum0;
//    hamming_dist1 = sum1;

//    if (hamming_dist0 <= hamming_dist1)
//        closest_pattern = 2'b00;   // digit 0
//    else
//        closest_pattern = 2'b01;   // digit 1
//end

//endmodule

`timescale 1ns / 1ps

`timescale 1ns / 1ps

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
