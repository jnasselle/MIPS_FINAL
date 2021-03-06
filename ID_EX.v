`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:25 03/10/2015 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	input le,
	input reset,
	input clear,	//Falta Implementar esto
	input [31:0] RegData1In,
	input [31:0] RegData2In,
	input [31:0] ExtendidoIn,
	input [4:0] rsIn,
	input [4:0] rtIn,
	input [4:0] rdIn,
	input	[5:0]	ALUControlIn,
	input	ALUSrcIn,
	input	RegWriteIn,
	input	MemtoRegIn,
	input	MemWriteIn,
	input	RegDstIn,
	output reg [31:0] RegData1Out,
	output reg [31:0] RegData2Out,
	output reg [31:0] ExtendidoOut,
	output reg [4:0] rsOut,
	output reg [4:0] rtOut,
	output reg [4:0] rdOut,	
	output reg	[5:0] ALUControlOut,
	output reg	ALUSrcOut,
	output reg	RegWriteOut,
	output reg	MemtoRegOut,
	output reg	MemWriteOut,
	output reg	RegDstOut
    );
	 
	 initial
	 begin
			RegData1Out<=0;
			RegData2Out<=0;
			ExtendidoOut<=0;
			rsOut<=0;
			rtOut<=0;
			rdOut<=0;	
			ALUControlOut<=0;
			ALUSrcOut<=0;
			RegWriteOut<=0;
			MemtoRegOut<=0;
			MemWriteOut<=0;
			RegDstOut<=0;
	 end

always@(*)
begin
	if (reset || clear) //ver bien esto
		begin
		RegData1Out<=0;
		RegData2Out<=0;
		ExtendidoOut<=0;
		rsOut<=0;
		rtOut<=0;
		rdOut<=0;
		ALUControlOut<=0;
		ALUSrcOut<=0;
		RegWriteOut<=0;
		MemtoRegOut<=0;
		MemWriteOut<=0;
		RegDstOut<=0;
		end 
	else if (le)
		begin
		RegData1Out<=RegData1In;
		RegData2Out<=RegData2In;
		ExtendidoOut<=ExtendidoIn;
		rsOut<=rsIn;
		rtOut<=rtIn;
		rdOut<=rdIn;
		ALUControlOut<=ALUControlIn;
		ALUSrcOut<=ALUSrcIn;
		RegWriteOut<=RegWriteIn;
		MemtoRegOut<=MemtoRegIn;
		MemWriteOut<=MemWriteIn;
		RegDstOut<=RegDstIn;
		end
end


endmodule
