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
	input reset,
	input [31:0] MemDataIn,
	input	[31:0] ALUDataIn,
	input [4:0] WriteRegIn,
	input	RegWriteIn,
	input MemtoRegIn,
	output reg [31:0] MemDataOut,
	output reg [31:0] ALUDataOut,
	output reg [4:0] WriteRegOut,
	output reg	RegWriteOut,
	output reg MemtoRegOut
    );

initial
begin
MemDataOut<=0;
ALUDataOut<=0;
WriteRegOut<=0;
RegWriteOut<=0;
MemtoRegOut<=0;
end

always@(*)
begin
	if(reset == 1)
		begin
		MemDataOut<=0;
		ALUDataOut<=0;
		WriteRegOut<=0;
		RegWriteOut<=0;
		MemtoRegOut<=0;
		end
	else if (le)
		begin
		MemDataOut<=MemDataIn;
		ALUDataOut<=ALUDataIn;
		WriteRegOut<=WriteRegIn;
		RegWriteOut<=RegWriteIn;
		MemtoRegOut<=MemtoRegIn;
		end
end


endmodule