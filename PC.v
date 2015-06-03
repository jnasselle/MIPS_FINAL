`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:28:04 06/02/2015 
// Design Name: 
// Module Name:    PC 
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
module PC(
	input clk,
	input en,
	input [31:0] PCIn,
	output reg [31:0] PCOut
    );
	always @(posedge clk)
	begin
		if(en == 1'b1)
			begin
			PCOut <= PCIn;
			end
		else
			begin
			PCOut <= PCOut;
			end
		
	end


endmodule
