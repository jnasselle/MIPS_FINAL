`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:21:44 03/10/2015 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
	input clk,
	input rx,
	output tx
	);

/*
	ETAPA DE FETCH
*/
reg [31:0] IF_PC;	//Program Counter.Ver si no hacer un modulo
Sumador IF_Sumador (
    .op1(op1), //valor del PC
    .op2(32'd4), //sumamos 4
    .result(result)
    );
MemDatos IF_MemDatos (
  .clka(clka), // input clka
  .wea(wea), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(douta) // output [31 : 0] douta
);
/*
	LATCH IF/ID
*/

IF_ID DataPath_IF_ID(
	.clk(clk)
	.instruccionIn(),	//Input
	.instruccionOut({ID_InstruccionOp,
		ID_InstruccionRs,
		ID_InstruccionRt,
		ID_InstruccionRd,
		
		})		//Output
);

/*
	ETAPA DE DECODE
*/

wire [5:0] ID_InstruccionOp;
wire [4:0] ID_InstruccionRs;
wire [4:0] ID_InstruccionRt;
wire [4:0] ID_InstruccionRd;
wire [4:0] ID_InstruccionShamt;
wire [5:0] ID_InstruccionFunct;
wire [15:0] ID_InstruccionImm
		= {ID_InstruccionRd,
			ID_InstruccionShamt,
			ID_InstruccionFunct}; // El valor imm se construye.


wire ID_RegWrite;	//Se debe escribir un registro?
wire ID_MemToReg;	//Existe writeback?
wire ID_MemWrite;	//Se graba la memoria de dato? 
wire [6:0] ID_AluControl;	//Control de la ALU
wire ID_AluSrc;	//El operando de la ALU es un reg o un imm?
wire ID_RegDest;	//El registro destino es rd o rt?


Registros ID_Registros (
    .clk(clk), 
    .reset(reset), 
    .rs_addr(rs_addr), 
    .rt_addr(rt_addr), 
    .rd_addr(rd_addr), 
    .rd_data(rd_data), 
    .write_en(write_en), 
    .rs_data(rs_data), 
    .rt_data(rt_data)
    );
ShiftIzq ID_ShiftIzq (
    .data_in(data_in), 
    .data_out(data_out)
    );
Extension ID_Extension (
    .data_in(data_in), 
    .data_out(data_out), 
    .tipo(tipo)
    );
/*
	ETAPA DE EXECUTION
*/

wire IE_RegWrite;	//Se debe escribir un registro?
wire IE_MemToReg;	//Existe writeback?
wire IE_MemWrite;	//Se graba la memoria de dato? 
wire [6:0] IE_AluControl;	//Control de la ALU
wire IE_AluSrc;	//El operando de la ALU es un reg o un imm?
wire IE_RegDest;	//El registro destino es rd o rt?


ALU EX_ALU (
    .AluCon(AluCon), 
    .A(A), 
    .B(B), 
    .AluOut(AluOut), 
    .Zero(Zero)
    );
/*
	ETAPA DE MEMORY
*/

wire MEM_RegWrite;	//Se debe escribir un registro?
wire MEM_MemToReg;	//Existe writeback?
wire MEM_MemWrite;	//Se graba la memoria de datos? 

MemInstrucciones MEM_MemInstrucciones (
  .clka(clka), 	// input clka
  .addra(addra), 	// input [31 : 0] addra
  .douta(douta) 	// output [31 : 0] douta
);

/*
	ETAPA DE WRITEBACK
*/

wire WB_RegWrite;	//Se debe escribir un registro?
wire WB_MemToReg;	//Existe writeback?



	 
	



ID_EX DataPath_ID_EX(
	.clk(clk)
);

EX_MEM DataPath_EX_MEM(
	.clk(clk)
);

MEM_WB DataPath_MEM_WB(
	.clk(clk)
);
	 

	 

	 
	 
	 



endmodule
