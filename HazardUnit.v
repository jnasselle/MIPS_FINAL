`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:59 05/19/2015 
// Design Name: 
// Module Name:    HazardUnit 
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
module HazardUnit(
	input [5:0] RsD,
	input [5:0] RtD,
	input [5:0] RsE,
	input [5:0] RtE,
	input [5:0] WriteRegE,
	input [5:0] WriteRegM,
	input [5:0] WriteRegW,
	input RegWriteE,
	input RegWriteM,
	input RegWriteW,
	input MemToReg,
	input BranchD,
	output reg StallF,
	output reg StallD,
	output reg ForwardAD,
	output reg ForwardBD,
	output reg FlushE,
	output reg [1:0] ForwardAE,
	output reg [1:0] ForwardBE
   );
	
	reg lwstall;
	
always@(*)
begin

	// Explicado en páginas 407 y 410
	
	//La unidad detecta si debe cortocircuitar, establece selectores MUXs
	//Debe cortocircuitar si la etapa escribe un registro destino que se usa como origen.
	
	if ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)
	ForwardAE = 2'b10;
	else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW)
	ForwardAE = 2'b01;
	else
	ForwardAE = 2'b00;
	
	//Debe cortocircuitar si la etapa escribe un registro destino que se usa como origen.
	
	if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
	ForwardBE = 2'b10;
	else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW)
	ForwardBE = 2'b01;
	else
	ForwardBE = 2'b00;
	
	ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
	ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;
	
	lwstall = ((RsD == RtE) || (RtD == RtE)) && MemToReg;
	StallF = lwstall;
	StallD = lwstall;
	FlushE = lwstall;
	
end

endmodule
