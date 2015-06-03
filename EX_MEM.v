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
	input le,
	input RegWriteIn,
	input MemtoRegIn,
	input MemWriteIn,
	input [31:0] ALUResultIn,
	input [4:0] WriteRegIn,	//Para cuando se quiere el resultado en un registro o un load
	input [31:0] WriteDataIn, //Para cuando se quiere hacer un store
	output reg RegWriteOut = 0,
	output reg MemtoRegOut = 0,
	output reg MemWriteOut = 0,
	output reg [31:0] ALUResultOut = 0,
	output reg [4:0] WriteRegOut = 0,		//Para cuando se quiere el resultado en un registro o un load
	output reg [31:0] WriteDataOut = 0
    );

always@(*)
begin
	if (le == 1'b1)
	begin
	ALUResultOut	<=ALUResultIn;
	WriteRegOut		<=WriteRegIn;
	WriteDataOut	<=WriteDataIn;
	RegWriteOut		<=RegWriteIn;
	MemtoRegOut		<=MemtoRegIn;
	MemWriteOut		<=MemWriteIn;
	end
end

endmodule
