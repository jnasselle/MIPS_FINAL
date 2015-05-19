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
	output ForwardAD,
	output ForwardBD,
	output FlushE,
	output reg [1:0] ForwardAE,
	output reg [1:0] ForwardBE,
	output MemToReg,
	output RegWriteE,
	output RegWriteM,
	output RegWriteW
   );
	
always@(*)
begin
	if ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)
	ForwardAE = 2'b10;
	else if ((RsE !=0) && (RsE == WriteRegW) && RegWriteW)
	ForwardAE = 2'b01;
	else
	ForwardAE = 2'b00;
	
	if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
	ForwardBE = 2'b10;
	else if ((RtE !=0) && (RtE == WriteRegW) && RegWriteW)
	ForwardBE = 2'b01;
	else
	ForwardBE = 2'b00;
end

endmodule
