`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:44 03/04/2015 
// Design Name: 
// Module Name:    ShiftIzq 
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
module ShiftIzq( input [31:0] data_in,
	output [31:0] data_out
	);
	assign data_out={data_in[29:1], 2'b00};

endmodule
