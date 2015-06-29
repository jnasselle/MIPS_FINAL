`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:07 06/02/2015 
// Design Name: 
// Module Name:    Equal 
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
module Equal(
    input BranchD,
	 input [31:0] Data1,
	 input [31:0] Data2,
	 output reg result
	 );

always@(*)
	begin
	result = (Data1 == Data2) && BranchD;
	end

endmodule
