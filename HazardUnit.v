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
	
	/* ===================Riesgos de Load===================
		La unidad de riesgo examina la instruccion que se encuentra
		en la etapa de EX.Si es un load(se ve el bit IE_MemToReg)
		y su destino(EX_Rt o EX_WriteReg) es el mismo que el que
		se esta en la etapa de ID, la instruccion debe ser parada en
		ID hasta que el registro este disponible.
		Cuando se dan las condiciones anteriormente expuestas:
			#Se mantienen los valores viejos de IF(PC) y IF_ID(instruccion)
			#Introducir un NOP en ID_EX (mediante CLR)
	*/
	
	lwstall = ((RsD == RtE) || (RtD == RtE)) && MemToRegE;
	
	
	/*===================Riesgos de Branch===================
	Para minimizar la penalizacion que se genera al obtener la siguiente
	instruccion a un branch,suponiendo que el branch no se va a tomar,
	se mueve a la etapa de decodificacion la comparacion entre los registros
	(ID_Equal), siendo entonces la penalizacion de una instruccion y no de tres
	cuando la compracion se realizaba en la etapa EX.
	
	La decicion de branch en la etapa ID implica un riesgo de datos RAW ya
	que los operandos del branch puede estar siendo computado por
	una instruccion previa.Para solucionar dicho problema se va a 
	cortocircuitar desde las etapas posteriores.
	
	*/
	ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
	ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;
	branchstall = (BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) || (BranchD && MemToRegM && (WriteRegM == RsD || WriteRegM == RtD));
	/*===================Riesgos de Jump===================
	Ya que el Jump es incondicional y es decodificado en ID,existe una
	penalizacion ya que en la etapa IF esta la proxima instruccion(mal).
	Ya que la la insercion de un NOP en IF_ID se hace fuera de la HazardUnit,
	solamente se debe hacer el flush de ID_EX
	*/
	//Finalmente establece signals de stall por load o branch.
	StallF = lwstall || branchstall;
	StallD = lwstall || branchstall;
	FlushE = lwstall || branchstall || JumpD;
	
end

endmodule
