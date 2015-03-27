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
	input clk,
	input [31:0] MemDataIn,
	input	[31:0] ALUDataIn,
	input [4:0] WriteBackRegIn,
	output reg [31:0] MemDataOut,
	output reg [31:0] ALUDataOut,
	output reg [4:0] WriteBackRegOut
    );

always@(clk)
begin
	MemDataOut<=MemDataIn;
	ALUDataOut<=ALUDataIn;
	WriteBackRegOut<=WriteBackRegIn;
end


endmodule