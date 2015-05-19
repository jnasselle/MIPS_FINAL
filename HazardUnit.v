`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:59 05/19/2015 
// Design Name: 
// Module Name:    HazardUnit 
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
module HazardUnit(
	input [5:0] RsD,
	input [5:0] RtD,
	input [5:0] RsE,
	input [5:0] RtE,
	input [5:0] WriteRegE,
	input [5:0] WriteRegM,
	input [5:0] WriteRegW,
	output StallF,
	output StallD,
	output BranchD,
	output ForwardAD
	output ForwardBD,
	output FlushE,
	output ForwardAE,
	output ForwardBE,
	output MemToReg,
	output RegWriteE,
	output RegWriteM,
	output RegWriteW
   );


endmodule
