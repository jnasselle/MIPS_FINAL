`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:47 03/10/2015 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	input clk,
	input reset,
	input RegWriteIn,
	input MemtoRegIn,
	input MemWriteIn,
	input [31:0] ALUResultIn,
	input [4:0] WriteRegIn,	//Para cuando se quiere el resultado en un registro o un load
	input [31:0] WriteDataIn, //Para cuando se quiere hacer un store
	input HaltIn,
	output reg RegWriteOut,
	output reg MemtoRegOut,
	output reg MemWriteOut,
	output reg [31:0] ALUResultOut,
	output reg [4:0] WriteRegOut,		//Para cuando se quiere el resultado en un registro o un load
	output reg [31:0] WriteDataOut,
	output reg HaltOut

    );

initial
begin
	RegWriteOut<=0;
	MemtoRegOut<=0;
	MemWriteOut<=0;
	ALUResultOut<=0;
	WriteRegOut<=0;		
	WriteDataOut<=0;
end

always@(posedge clk)
begin
	ALUResultOut	<=ALUResultIn;
	WriteRegOut		<=WriteRegIn;
	WriteDataOut	<=WriteDataIn;
	RegWriteOut		<=RegWriteIn;
	MemtoRegOut		<=MemtoRegIn;
	MemWriteOut		<=MemWriteIn;
	HaltOut			<=HaltIn;
end

endmodule
