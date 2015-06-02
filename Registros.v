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
	output reg[31:0] RD2Out,	//Datos almacenados en la dir rd
	output [1023:0] Registros
    );
	reg [31:0] registros[31:0];
	assign Registros= {
	registros[0],
registros[1],
registros[2],
registros[3],
registros[4],
registros[5],
registros[6],
registros[7],
registros[8],
registros[9],
registros[10],
registros[11],
registros[12],
registros[13],
registros[14],
registros[15],
registros[16],
registros[17],
registros[18],
registros[19],
registros[20],
registros[21],
registros[22],
registros[23],
registros[24],
registros[25],
registros[26],
registros[27],
registros[28],
registros[29],
registros[30],
registros[31]
};
	always@(posedge clk)
	begin
		if(WE3) registros[A3In]<=WD3In;
		RD1Out<=registros[A1In];
		RD2Out<=registros[A2In];
	end
	
endmodule
