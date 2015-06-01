`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:11 06/01/2015 
// Design Name: 
// Module Name:    Mux3 
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
module Mux3
  #(
	 //parameter WIDTH = 5   //Ancho de la direccion de memoria.
	 )
	(
    input  [4:0] in0,
    input  [4:0] in1,
    output reg [4:0] out,
    input sel
    );

	always @(*)
	begin
		case (sel)
			1'b0: 	out <= in0;
			1'b1:		out <= in1;
		endcase
	end
endmodule
