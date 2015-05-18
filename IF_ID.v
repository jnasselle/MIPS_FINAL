`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:22 03/10/2015 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	input clk,
	input [31:0] instruccionIn,
	input [31:0] PC4In,	//PC+4
	output reg [31:0] instruccionOut,
	output reg [31:0] PC4Out
    );

always@ (clk)	//Latch,por nivel
begin
	instruccionOut<=instruccionIn;
	NextPCOut<= NextPCIn;
end


endmodule
