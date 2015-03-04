`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:53 03/04/2015 
// Design Name: 
// Module Name:    Mux4 
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
    input  [WIDTH-1:0] in2,
	input  [WIDTH-1:0] in3,
    output reg [WIDTH-1:0] out,
    input  [1:0] sel
    );

	always @(*)
	begin
		case (sel)
			2'b00: 	out <= in0;
			2'b01:	out <= in1;
			2'b10:	out <= in2;
			2'b10:	out <= in3;
		endcase
	end
endmodule
