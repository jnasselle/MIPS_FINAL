`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:24 06/28/2015 
// Design Name: 
// Module Name:    JumpAddr 
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
module JumpAddr(
	input [3:0] PC_relative,
	input [25:0] Offset,
	output [31:0] JAddr
    );
assign JAddr={PC_relative,Offset,2'b0};



endmodule
