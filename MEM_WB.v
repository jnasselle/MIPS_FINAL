`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:07 03/10/2015 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	input le,
	input [31:0] MemDataIn,
	input	[31:0] ALUDataIn,
	input [4:0] WriteRegIn,
	input	RegWriteIn,
	input MemtoRegIn,
	output reg [31:0] MemDataOut=0,
	output reg [31:0] ALUDataOut=0,
	output reg [4:0] WriteRegOut=0,
	output reg	RegWriteOut=0,
	output reg MemtoRegOut=0
    );

always@(*)
begin
	if (le == 1'b1)
	begin
	MemDataOut<=MemDataIn;
	ALUDataOut<=ALUDataIn;
	WriteRegOut<=WriteRegIn;
	RegWriteOut<=RegWriteIn;
	MemtoRegOut<=MemtoRegIn;
	end
end


endmodule