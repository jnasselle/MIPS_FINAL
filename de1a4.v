`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:21 06/03/2015 
// Design Name: 
// Module Name:    de1a4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module de1a4(
    input in,
    output reg [3:0]out
    );

always@(*)
begin
	out[0]<=in;
	out[1]<=in;
	out[2]<=in;
	out[3]<=in;
end


endmodule
