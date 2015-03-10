`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:21:44 03/10/2015 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
	input clk,
	input rx,
	output tx
    );
	 
IF_ID DataPath_IF_ID(
	.clk(clk)
);

ID_EX DataPath_ID_EX(
	.clk(clk)
);

EX_MEM DataPath_EX_MEM(
	.clk(clk)
);

MEM_WB DataPath_MEM_WB(
	.clk(clk)
);
	 

	 

	 
	 
	 



endmodule
