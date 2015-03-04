`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:25 03/04/2015 
// Design Name: 
// Module Name:    Registros 
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
module Registros( input clk,
	input reset,
	input [4:0] rs_addr,
	input [4:0] rt_addr,
	input [4:0] rd_addr,
	input [31:0] rd_data,
	input write_en,
	output reg[31:0] rs_data,
	output reg[31:0] rt_data
    );
	reg [31:0] registro[31:0];
	always@(posedge clk)
	begin
		if(write_en) registro[rd_addr]<=rd_data;
		rs_data<=registro[rs_addr];
		rt_data<=registro[rt_addr];
	end
	
endmodule
