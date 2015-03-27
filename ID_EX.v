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
	input clk,
	input [31:0] RegData1In,
	input [31:0] RegData2In,
	input [31:0] ExtendidoIn,
	input [4:0] rsIn,
	input [4:0] rtIn,
	input [4:0] rdIn,
	output reg [31:0] RegData1Out,
	output reg [31:0] RegData2Out,
	output reg [31:0] ExtendidoOut,
	output reg [4:0] rsOut,
	output reg [4:0] rtOut,
	output reg [4:0] rdOut	
    );

always@(clk)
begin
	RegData1Out<=RegData1In;
	RegData2Out<=RegData2In;
	ExtendidoOut<=ExtendidoIn;
	rsOut<=rsIn;
	rtOut<=rtIn;
	rdOut<=rdIn;
end


endmodule
