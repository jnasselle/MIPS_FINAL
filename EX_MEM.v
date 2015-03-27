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
	input [31:0] ALUResultIn,
	input [5:0] WriteBackRegIn,	//Para cuando se quiere el resultado en un registro o un load
	input [31:0] RegToMemDataIn, //Para cuando se quiere hacer un store
	output reg [31:0] ALUResultOut,
	output reg [5:0] WriteBackRegOut,	//Para cuando se quiere el resultado en un registro o un load
	output reg [31:0] RegToMemDataOut
    );

always@(clk)
begin
	ALUResultOut<=ALUResultIn;
	WriteBackRegOut<=WriteBackRegIn;
	RegToMemDataOut<=RegToMemDataIn;
end

endmodule
