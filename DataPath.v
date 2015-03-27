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
	 
MemInstrucciones MEM_MemInstrucciones (
  .clka(clka), 	// input clka
  .addra(addra), 	// input [31 : 0] addra
  .douta(douta) 	// output [31 : 0] douta
);

/*
	LATCH IF/ID
*/

IF_ID DataPath_IF_ID(
	.clk(clk),
	.instruccionIn(),	//Input
	.instruccionOut({ID_InstruccionOp,
		ID_InstruccionRs,
		ID_InstruccionRt,
		ID_InstruccionRd		
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
wire	[5:0]	ID_AluControl;
wire	ID_AluSrc;
wire	ID_RegWrite;
wire	ID_MemtoReg;
wire	ID_MemWrite;
wire	ID_RegDst;
wire	ID_Branch;


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
	 
/////////////////////////////////ControlUnit///////////////////////////////////////	 
ControlUnit DataPath_ControlUnit (
    .Op(ID_InstruccionOp), 
    .Funct(ID_InstruccionFunct), 
    .MemtoReg(ID_MemtoReg), 
    .MemWrite(ID_MemWrite), 
    .AluSrc(ID_AluSrc), 
    .RegDst(ID_RegDst), 
    .RegWrite(ID_RegWrite), 
    .Branch(ID_Branch), 
    .AluControl(ID_AluControl)
    );	 
	 
//////////////////////////////////ID_EX////////////////////////////////////////////	 
ID_EX DataPath_ID_EX (
    .clk(clk), 
    .RegData1In(RegData1In), 
    .RegData2In(RegData2In), 
    .ExtendidoIn(ExtendidoIn), 
    .rsIn(rsIn), 
    .rtIn(rtIn), 
    .rdIn(rdIn), 
    .AluControlIn(ID_AluControl), 
    .AluSrcIn(ID_AluSrc), 
    .RegWriteIn(ID_RegWrite), 
    .MemtoRegIn(ID_MemtoReg), 
    .MemWriteIn(ID_MemWrite), 
    .RegDstIn(ID_RegDst), 
    .BranchIn(ID_Branch), 
////////////////////////////////////////////////////////////////////////////////////
    .RegData1Out(RegData1Out), 
    .RegData2Out(RegData2Out), 
    .ExtendidoOut(ExtendidoOut), 
    .rsOut(rsOut), 
    .rtOut(rtOut), 
    .rdOut(rdOut), 
    .AluControlOut(AluControlOut), 
    .AluSrcOut(AluSrcOut), 
    .RegWriteOut(RegWriteOut), 
    .MemtoRegOut(MemtoRegOut), 
    .MemWriteOut(MemWriteOut), 
    .RegDstOut(RegDstOut), 
    .BranchOut(BranchOut)
    );	 
	 
	 
/*
	ETAPA DE EXECUTION
*/

wire IE_RegWrite;	//Se debe escribir un registro?
wire IE_MemtoReg;	//Existe writeback?
wire IE_MemWrite;	//Se graba la memoria de dato? 
wire [6:0] IE_AluControl;	//Control de la ALU
wire IE_AluSrc;	//El operando de la ALU es un reg o un imm?
wire IE_RegDest;	//El registro destino es rd o rt?
wire IE_AluOut;	//Salida de la alu

wire IE_WriteBackReg;



ALU EX_ALU (
    .AluCon(IE_AluControl), 
    .A(A), 	//rs
    .B(B), 	//rt o shamt o imm
    .AluOut(IE_AluOut) 
    );
	 
	 
/*
	LATCH EX_MEM
*/

EX_MEM DataPath_EX_MEM (
	  //Inputs
    .clk(clk),
    .RegWriteIn(IE_RegWrite), //Control
    .MemtoRegIn(IE_MemToReg), //Control
    .MemWriteIn(IE_MemWrite), //Control
    .ALUResultIn(IE_AluOut),	//Datos
    .WriteBackRegIn(WriteBackRegIn), //Numero de Registro  FALTA!
    .RegToMemDataIn(RegToMemDataIn), //Datos FALTA!
	 //Outputs
    .RegWriteOut(MEM_RegWrite), //Control 
    .MemtoRegOut(MEM_MemtoReg), //Control 
    .MemWriteOut(MEM_MemWrite), //Control 
    .ALUResultOut(ALUResultOut), //Datos FALTA!
    .WriteBackRegOut(WriteBackRegOut),	//Numero de Registro FALTA!
    .RegToMemDataOut(RegToMemDataOut) //Datos FALTA!
    );

/*
	ETAPA DE MEMORY
*/

wire MEM_RegWrite;	//Se debe escribir un registro?
wire MEM_MemtoReg;	//Existe writeback?
wire MEM_MemWrite;	//Se graba la memoria de datos? 

MemDatos IF_MemDatos (
  .clka(clka), // input clka
  .wea(wea), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(douta) // output [31 : 0] douta
);

/*
	LATCH MEM_WB
*/

MEM_WB DataPath_MEM_WB (
    .clk(clk), 
    .MemDataIn(MemDataIn), 
    .ALUDataIn(ALUDataIn), 
    .WriteBackRegIn(WriteBackRegIn), 
    .RegWritwIn(MEM_RegWrite), 
    .MemtoRegIn(MEM_MemtoReg), 
    .MemDataOut(MemDataOut), 
    .ALUDataOut(ALUDataOut), 
    .WriteBackRegOut(WriteBackRegOut), 
    .RegWritwOut(RegWritwOut), 
    .MemtoRegOut(MemtoRegOut)
    );




/*
	ETAPA DE WRITEBACK
*/

wire WB_RegWrite;	//Se debe escribir un registro?
wire WB_MemToReg;	//Existe writeback?



endmodule
