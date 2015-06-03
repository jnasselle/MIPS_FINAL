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
	output reg [31:0] RegData1Out=0,
	output reg [31:0] RegData2Out=0,
	output reg [31:0] ExtendidoOut=0,
	output reg [4:0] rsOut=0,
	output reg [4:0] rtOut=0,
	output reg [4:0] rdOut=0,	
	output reg	[5:0] ALUControlOut=0,
	output reg	ALUSrcOut=0,
	output reg	RegWriteOut=0,
	output reg	MemtoRegOut=0,
	output reg	MemWriteOut=0,
	output reg	RegDstOut=0
    );

always@(*)
begin
	if (le == 1'b1)
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
