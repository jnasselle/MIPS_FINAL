`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:13 03/11/2015 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	input [5:0] Op,
	input [5:0] Funct, //Es necesario que pase por este modulo?
//	input zero,
	output MemtoReg,
	output MemWrite,
//	output pcscr,			para la AND
	output ALUSrc,
	output RegDst,
	output RegWrite,
	output Branch,
	output [5:0] ALUControl //salida en caso de ser necesario.
   );
	
//	reg [6:0] controls;
//	assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Branch} controls;
	
	// Establecer las lineas de control segun la opcion.
//	always @ (*)
//	case(opcion)
//		6'b000000: controls <= 9'b1100000; //R
//		6'b100011: controls <= 9'b1010010; //LW
//		6'b101011: controls <= 9'b0010100; //SW
//		6'b000100: controls <= 9'b0001000; //BEQ
//		6'b001000: controls <= 9'b1010000; //ADDI
//		6'b000010: controls <= 9'b0000001; //J
//		default:	controls <= 9'bxxxxxxx; //NODEF
		
//	endcase

endmodule
