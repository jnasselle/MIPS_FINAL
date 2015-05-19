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
	input [4:0] A1In,	//rs direccion.Para lectura de reg
	input [4:0] A2In,	//rt direccion.Para lectura de reg
	input [4:0] A3In,	//rd direccion.Para escritura de reg
	input [31:0] WD3In,	//DATOS
	input WE3,
	output reg[31:0] RD1Out,	//Datos almacenados en la dir rs
	output reg[31:0] RD2Out		//Datos almacenados en la dir rd
    );
	reg [31:0] registro[31:0];
	always@(posedge clk)
	begin
		if(WE3) registro[A3In]<=WD3In;
		RD1Out<=registro[A1In];
		RD2Out<=registro[A2In];
	end
	
endmodule
