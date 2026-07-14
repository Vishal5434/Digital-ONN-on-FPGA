`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 13:46:32
// Design Name: 
// Module Name: clk_divider
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

module clk_divider(input clk, output s_clk);

reg [1:0] counter;

initial begin
    counter <= 0;
end

always @(posedge clk) begin
    counter <= counter + 1;   // ? FIXED (= ? <=)
end

assign s_clk = counter[1];

endmodule
