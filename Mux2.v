`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:38 02/03/2015 
// Design Name: 
// Module Name:    mux
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
module Mux2
  #(
	 parameter WIDTH = 32   //Ancho de la direccion de memoria.
	 )
	(
    input  [WIDTH-1:0] in0,
    input  [WIDTH-1:0] in1,
    output reg [WIDTH-1:0] out,
    input sel
    );

	always @(*)
	begin
		case (sel)
			1'b0: 	out <= in0;
			1'b1:		out <= in1;
			default: out <= in0;
		endcase
	end
endmodule