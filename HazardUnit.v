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
	input [4:0] RsD,
	input [4:0] RtD,
	input [4:0] RsE,
	input [4:0] RtE,
	input [4:0] WriteRegE,
	input [4:0] WriteRegM,
	input [4:0] WriteRegW,
	input RegWriteE,
	input RegWriteM,
	input RegWriteW,
	input MemToRegE,
	input MemToRegM,
	input BranchD,
	input JumpD,
	output reg StallF,
	output reg StallD,
	output reg ForwardAD,
	output reg ForwardBD,
	output reg FlushE,
	output reg [1:0] ForwardAE,
	output reg [1:0] ForwardBE
   );
	
	reg lwstall;  		// stall para operaciones lw
	reg branchstall;	// stall para branches
	
always@(*)
begin

	//Para resolver riesgos de datos de LDE - Explicado en paginas 407 y 410
	
	//La unidad detecta si debe cortocircuitar, establece selectores MUXs
	//Debe cortocircuitar si la etapa escribe un registro destino que es orgien de otra etapa.
	
	//Para cortocircuitar SrcA en etapa EX evalua RsE
	if ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)
	ForwardAE = 2'b10;
	else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW)
	ForwardAE = 2'b01;
	else
	ForwardAE = 2'b00;
	
	//Para cortocircuitar SrcB en etapa EX evalua RtE
	if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
	ForwardBE = 2'b10;
	else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW)
	ForwardBE = 2'b01;
	else
	ForwardBE = 2'b00;
	
	//Para cortocircuitar SrcA en etapa ID evalua RsD
	ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
	
	//Para cortocircuitar SrcB en etapa ID evalua RtD
	ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;
	
	//Para resolver riesgos de datos LW se debe generar un stall
	lwstall = ((RsD == RtE) || (RtD == RtE)) && MemToRegE;
	
	//Para resolver riesgo de control BEQ se puede introducir stall o predictor.
	
	//Para detectar stall para un branch se evalua:
	branchstall = (BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) || (BranchD && MemToRegM && (WriteRegM == RsD || WriteRegM == RtD));
	
	//Finalmente establece signals de stall por load o branch.
	StallF = lwstall || branchstall;
	StallD = lwstall || branchstall;
	FlushE = lwstall || branchstall || JumpD;
	
end

endmodule
