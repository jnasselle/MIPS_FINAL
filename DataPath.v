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
wire [31:0] IF_PC_Out4;
wire [31:0] IF_PC_In;
wire [31:0] IF_RD;
reg [31:0] IF_PC;	//Program Counter.Ver si no hacer un modulo
wire IF_Stall;


always@(clk)
begin	//falta if para ver si es por nivel positivo o negativo
	IF_PC<=IF_PC_In;
end

/*
	ETAPA DE DECODE
*/

wire [31:0] ID_PC4;
wire [31:0] ID_Instruccion;
wire ID_RegWrite;	//Se debe escribir un registro?
wire ID_MemToReg;	//Existe writeback?
wire ID_MemWrite;	//Se graba la memoria de dato? 
wire [5:0] ID_ALUControl;	//Control de la ALU
wire ID_ALUSrc;	//El operando de la ALU es un reg o un imm?
wire ID_RegDest;	//El registro destino es rd o rt?
wire	ID_RegDst;
wire	ID_Branch;
wire [31:0] ID_RD1;
wire [31:0] ID_RD2;
wire [31:0] ID_ImmExtendido;
wire [31:0] ID_ImmExtendidoS2;	//ID_ImmExtendido<<2
wire [31:0] ID_PCBranch;
wire ID_ForwardA;
wire ID_ForwardB;
wire [31:0] ID_Mux2_RD1_Out;
wire [31:0] ID_Mux2_RD2_Out;
wire ID_Equal;
wire ID_PCSrc;

/*
	ETAPA DE EXECUTION
*/

wire EX_RegWrite;	//Se debe escribir un registro?
wire EX_MemtoReg;	//Existe writeback?
wire EX_MemWrite;	//Se graba la memoria de dato? 
wire [6:0] EX_ALUControl;	//Control de la ALU
wire EX_ALUSrc;	//El operando de la ALU es un reg o un imm?
wire EX_RegDest;	//El registro destino es rd o rt?
wire [31:0] EX_ALUOut;	//Salida de la ALU
wire [4:0] EX_Rs;		// Salida Latch ID/IE
wire [4:0] EX_Rt;		// Salida Latch ID/IE
wire [4:0] EX_Rd; 	// Salida Latch ID/IE
wire [31:0] EX_RD1;	// Salida Latch ID/IE
wire [31:0] EX_RD2;	// Salida Latch ID/IE
wire [4:0] EX_WriteReg;	//Salida EX_Mux2_RegDst
wire [31:0] EX_SrcA;
wire [31:0] EX_SrcB;
wire [1:0] EX_ForwardA;
wire [1:0] EX_ForwardB;
wire [31:0] EX_WriteData;
wire [31:0] EX_ImmExtendido;

/*
	ETAPA DE MEMORY
*/

wire MEM_RegWrite;	//Se debe escribir un registro?
wire MEM_MemtoReg;	//Existe writeback?
wire MEM_MemWrite;	//Se graba la memoria de datos?
wire [31:0] MEM_ALUOut;
wire [31:0] MEM_WriteData;
wire [4:0] MEM_WriteReg;
wire [31:0] MEM_RD;

/*
	ETAPA DE WRITEBACK
*/

wire WB_RegWrite;	//Se debe escribir un registro?
wire WB_MemToReg;	//Existe writeback?
wire [31:0] WB_ReadData;
wire [31:0] WB_ALUOut;
wire [4:0] WB_WriteReg;
wire [31:0] WB_Result;

Sumador IF_Sumador (
    .op1(IF_PC), //valor del PC
    .op2(32'd4), //sumamos 4
    .result(IF_PC_Out4)
    );
	 
Mux2 IF_Mux2 (
    .in0(ID_PCBranch), 	//Direccion de Jump
    .in1(IF_PC_Out4), //Salida del sumador
    .out(IF_PC_In), //Va al PC
    .sel(IF_Stall)
    );

	 
MemInstrucciones MEM_MemInstrucciones (
  .clka(clk), 	// input clka
  .addra(IF_PC), 	// input [31 : 0] addra
  .douta(IF_RD) 	// output [31 : 0] douta
);

/*
	LATCH IF/ID
*/

IF_ID DataPath_IF_ID(
	.le(le),
	.instruccionIn(IF_RD),	//Input
	.PC4In(IF_PC_Out4),
	.PC4Out(ID_PC4),
	.instruccionOut(ID_Instruccion)		//Output
);


Registros ID_Registros (
    .clk(clk), 
    .reset(reset), 
    .A1In(ID_Instruccion[25:21]), 
    .A2In(ID_Instruccion[20:16]), 
    .A3In(ID_Instruccion[15:11]), 
    .WD3In(WB_Result),
    .WE3(WB_RegWrite),
    .RD1Out(ID_RD1), 
    .RD2Out(ID_RD2)
    );


Mux2 ID_Mux2_RD1 (
    .in0(ID_RD1), 
    .in1(EX_ALUOut),
    .out(ID_Mux2_RD1_Out),
    .sel(ID_ForwardA)
    );


Mux2 ID_Mux2_RD2 (
    .in0(ID_RD2), 
    .in1(EX_ALUOut),
    .out(ID_Mux2_RD2_Out),
    .sel(ID_ForwardB)
    );


//Comparador y and para soportar branch
assign ID_Equal=(ID_Mux2_RD1_Out==ID_Mux2_RD2_Out);
assign ID_PCSrc=ID_Branch && ID_Equal;

Extension ID_Extension (
    .data_in(ID_Instruccion[15:0]), 
    .data_out(ID_ImmExtendido), 
    .tipo()	//TODO!!!
    );

ShiftIzq ID_ShiftIzq (
    .data_in(ID_ImmExtendido), 
    .data_out(ID_ImmExtendidoS2)
    );
	 
Sumador ID_Sumador (
    .op1(ID_ImmExtendidoS2), 
    .op2(ID_PC4), 
    .result(ID_PCBranch)
    );

/////////////////////////////////ControlUnit///////////////////////////////////////	 

ControlUnit DataPath_ControlUnit (
    .Op(ID_Instruccion[31:26]), 
    .Funct(ID_Instruccion[5:0]), 
    .MemtoReg(ID_MemtoReg), 
    .MemWrite(ID_MemWrite), 
    .ALUSrc(ID_ALUSrc), 
    .RegDst(ID_RegDst), 
    .RegWrite(ID_RegWrite), 
    .Branch(ID_Branch), 
    .ALUControl(ID_ALUControl)
    );

/////////////////////////////////HazardUnit///////////////////////////////////////	 
HazardUnit DataPath_HazardUnit (
    .RsD(ID_Instruccion[25:21]), 
    .RtD(ID_Instruccion[20:16]), 
    .RsE(EX_Rs), 
    .RtE(EX_Rt), 
    .WriteRegE(WriteRegE), 
    .WriteRegM(MEM_WriteReg), 
    .WriteRegW(WB_WriteReg), 
    .RegWriteE(EX_RegWrite), 
    .RegWriteM(MEM_RegWrite), 
    .RegWriteW(WB_RegWrite), 
    .MemToRegE(EX_MemtoReg), 
    .MemToRegM(MEM_MemtoReg), 
    .BranchD(ID_Branch), 
    .StallF(StallF), 
    .StallD(StallD), 
    .ForwardAD(ID_ForwardA), 
    .ForwardBD(ID_ForwardB), 
    .FlushE(FlushE), 
    .ForwardAE(EX_ForwardA), 
    .ForwardBE(EX_ForwardB)
    );
	 
//////////////////////////////////ID_EX////////////////////////////////////////////	 
ID_EX DataPath_ID_EX (
    .le(le), 
    .RegData1In(ID_RD1), 
    .RegData2In(ID_RD2), 
    .ExtendidoIn(ID_ImmExtendido), 
    .rsIn(ID_Instruccion[25:21]), 
    .rtIn(ID_Instruccion[20:16]), 
    .rdIn(ID_Instruccion[15:11]), 
    .ALUControlIn(ID_ALUControl), 
    .ALUSrcIn(ID_ALUSrc), 
    .RegWriteIn(ID_RegWrite), 
    .MemtoRegIn(ID_MemtoReg), 
    .MemWriteIn(ID_MemWrite), 
    .RegDstIn(ID_RegDst), 
////////////////////////////////////////////////////////////////////////////////////
    .RegData1Out(EX_RD1), 
    .RegData2Out(EX_RD2), 
    .ExtendidoOut(EX_ImmExtendido), 
    .rsOut(EX_Rs), 
    .rtOut(EX_Rt), 
    .rdOut(EX_Rd), 
    .ALUControlOut(EX_ALUControl), 
    .ALUSrcOut(EX_ALUSrc), 
    .RegWriteOut(EX_RegWrite), 
    .MemtoRegOut(EX_MemtoReg), 
    .MemWriteOut(EX_MemWrite), 
    .RegDstOut(EX_RegDest)	 
    );	 
	 

Mux3 EX_Mux3_RegDst (
    .in0(EX_Rt), 
    .in1(EX_Rs), 
    .out(EX_WriteReg), 
    .sel(EX_RegDest)
    );

	 
Mux4 EX_Mux4_ForwardA (
    .in0(EX_RD1), 
    .in1(WB_Result), 
    .in2(MEM_ALUOut), 
    .in3(MEM_ALUOut),
    .out(EX_SrcA), 
    .sel(EX_ForwardA)
    );

Mux4 EX_Mux4_ForwardB (
    .in0(EX_RD2), 
    .in1(WB_Result), 
    .in2(MEM_ALUOut), 
    .in3(),
    .out(EX_WriteData), 
    .sel(EX_ForwardB)
    );

Mux2 EX_Mux2_ALUSrc (
    .in0(EX_WriteData), 
    .in1(EX_ImmExtendido), 
    .out(EX_SrcB), 
    .sel(EX_ALUSrc)
    );

ALU EX_ALU (
    .ALUCon(EX_ALUControl), 
    .A(EX_SrcA), 	//rs
    .B(EX_SrcB), 	//rt o shamt o imm
    .ALUOut(EX_ALUOut) 
    );
	 
	 
/*
	LATCH EX_MEM
*/

EX_MEM DataPath_EX_MEM (
	  //Inputs
    .le(le),
    .RegWriteIn(EX_RegWrite), //Control
    .MemtoRegIn(EX_MemtoReg), //Control
    .MemWriteIn(EX_MemWrite), //Control
    .ALUResultIn(EX_ALUOut),	//Datos
    .WriteRegIn(EX_WriteReg), //Numero de Registro para writeback
    .WriteDataIn(EX_WriteData), //Datos para writeback
	 //Outputs
    .RegWriteOut(MEM_RegWrite), //Control 
    .MemtoRegOut(MEM_MemtoReg), //Control 
    .MemWriteOut(MEM_MemWrite), //Control 
    .ALUResultOut(MEM_ALUOut), //Datos
    .WriteDataOut(MEM_WriteData),	//DATOS
    .WriteRegOut(MEM_WriteReg) //Direccion de Registro
    );



MemDatos IF_MemDatos (
  .clka(clk), // input clka
  .wea(MEM_MemWrite), // input [3 : 0] wea
  .addra(MEM_ALUOut), // input [31 : 0] addra
  .dina(MEM_WriteData), // input [31 : 0] dina
  .douta(MEM_RD) // output [31 : 0] douta
);

/*
	LATCH MEM_WB
*/

MEM_WB DataPath_MEM_WB (
    .le(le), 
    .MemDataIn(MEM_RD), 
    .ALUDataIn(MEM_ALUOut), 
    .WriteRegIn(MEM_WriteReg), 
    .RegWriteIn(MEM_RegWrite), 
    .MemtoRegIn(MEM_MemtoReg),
	//Outputs	 
    .MemDataOut(WB_ReadData), 
    .ALUDataOut(WB_ALUOut), 
    .WriteRegOut(WB_WriteReg), 
    .RegWriteOut(WB_RegWrite), 
    .MemtoRegOut(WB_MemToReg)
    );


Mux2 WB_Mux2_MemToReg (
    .in0(WB_ReadData), 
    .in1(WB_ALUOut), 
    .out(WB_Result), 
    .sel(WB_MemToReg)
    );



endmodule
