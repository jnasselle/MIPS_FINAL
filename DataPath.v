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
	input reset,
	output [1023:0] du_reg,
	output [255:0] du_mem,
	output [63:0] du_if_id,
	output [125:0] du_id_ex,
	output du_halt
	);


	

/*
	ETAPA DE FETCH
*/
wire [31:0] IF_PC_Out4;
wire [31:0] IF_PC_In;
wire [31:0] IF_RD;
wire [31:0] IF_PC;
wire IF_Stall;


/*
	ETAPA DE DECODE
*/

wire [31:0] ID_PC4;
wire [31:0] ID_Instruccion;
wire ID_RegWrite;	//Se debe escribir un registro?
wire ID_MemToReg;	//Existe writeback?
wire ID_MemtoRegSign;
wire ID_MemWrite;	//Se graba la memoria de dato? 
wire [2:0] ID_MemOp;		//Indica si la operatoria de la memoria es por byte,halfword o word
wire [5:0] ID_ALUControl;	//Control de la ALU
wire ID_ALUSrc;	//El operando de la ALU es un reg o un imm?
wire ID_RegDest;	//El registro destino es rd o rt?
wire	ID_RegDst;
wire	ID_Branch;
wire ID_TipoBranch;
wire [31:0] ID_RD1;
wire [31:0] ID_RD2;
wire [31:0] ID_ImmExtendido;
wire [31:0] ID_PCBranch;
wire ID_ForwardA;
wire ID_ForwardB;
wire [31:0] ID_Mux2_RD1_Out;
wire [31:0] ID_Mux2_RD2_Out;
wire [1:0] ID_PCSrc;		//ID_PCSrc[1] es del Jump,[0] salida del equal
wire ID_Stall;
wire ID_Halt;
wire ID_TipoExtension;
wire [31:0] ID_JAddr;
wire ID_Jump;

assign ID_PCSrc[1]=ID_Jump;

/*
	ETAPA DE EXECUTION
*/

wire EX_RegWrite;	//Se debe escribir un registro?
wire EX_MemtoReg;	//Existe writeback?
wire EX_MemtoRegSign;
wire EX_MemWrite;	//Se graba la memoria de dato?
wire [2:0] EX_MemOp;
wire [5:0] EX_ALUControl;	//Control de la ALU
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
wire EX_Flush;
wire EX_Halt;


/*
	ETAPA DE MEMORY
*/

wire MEM_RegWrite;	//Se debe escribir un registro?
wire MEM_MemtoReg;	//Existe writeback?
wire MEM_MemtoRegSign;
wire MEM_MemWrite;	//Se graba la memoria de datos?
wire [2:0] MEM_MemOp;
wire [31:0] MEM_ALUOut;
wire [31:0] MEM_WriteData;
wire [4:0] MEM_WriteReg;
wire [31:0] MEM_RD;
wire MEM_Halt;


/*
	ETAPA DE WRITEBACK
*/

wire WB_RegWrite;	//Se debe escribir un registro?
wire WB_MemToReg;	//Existe writeback?
wire [31:0] WB_ReadData;
wire [31:0] WB_ALUOut;
wire [4:0] WB_WriteReg;
wire [31:0] WB_Result;
wire WB_Halt;



Sumador IF_Sumador (
    .op1(IF_PC), //valor del PC
    .op2(32'd4), //sumamos 4
    .result(IF_PC_Out4)
    );
	 
	 
JumpAddr ID_JumpAddr (
    .PC_relative(ID_PC4[31:28]), 
    .Offset(ID_Instruccion[25:0]), 
    .JAddr(ID_JAddr)
    );

Mux4 IF_Mux4 (
	 .in0(IF_PC_Out4), //Salida del sumador
    .in1(ID_PCBranch), 	//Direccion de Branch
	 .in2(ID_JAddr),	//Para J
	 .in3(ID_RD1),		//Para JR
    .out(IF_PC_In), //Va al PC
    .sel(ID_PCSrc)
    );

	 
MemInstrucciones IF_MemInstrucciones (
  .clka(~clk), 	// input clka
  .addra(IF_PC), 	// input [31 : 0] addra
  .douta(IF_RD) 	// output [31 : 0] douta
);

/*
	LATCH IF/ID
*/

/////////////// Program Counter  //////////////

PC IF_PC_Module (
    .clk(clk), 
    .en(IF_Stall), //Activo por bajo
	 .reset(reset),
    .PCIn(IF_PC_In), 
    .PCOut(IF_PC)
    );

IF_ID DataPath_IF_ID(
	.clk(clk),
	.clear(ID_PCSrc[0] || ID_PCSrc[1]),
	.reset(reset),
	.enable(ID_Stall),
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
    .A3In(WB_WriteReg), 
    .WD3In(WB_Result),
    .WE3(WB_RegWrite),
    .RD1Out(ID_RD1), 
    .RD2Out(ID_RD2),
	 .Registros(du_reg)
    );


Mux2 ID_Mux2_RD1 (
    .in0(ID_RD1), 
    .in1(MEM_ALUOut),
    .out(ID_Mux2_RD1_Out),
    .sel(ID_ForwardA)
    );


Mux2 ID_Mux2_RD2 (
    .in0(ID_RD2), 
    .in1(MEM_ALUOut),
    .out(ID_Mux2_RD2_Out),
    .sel(ID_ForwardB)
    );

Equal ID_Equal (
	.BranchD(ID_Branch),
	.Tipo(ID_TipoBranch),
	.Data1(ID_Mux2_RD1_Out), 
	.Data2(ID_Mux2_RD2_Out), 
	.result(ID_PCSrc[0])
    );

Extension ID_Extension (
    .data_in(ID_Instruccion[15:0]), 
    .data_out(ID_ImmExtendido),
    .tipo(ID_TipoExtension)
    );
wire [31:0] ID_ImmExtendidoS2;

ShiftIzq ID_ShiftIzq (
    .data_in(ID_ImmExtendido[29:0]), 
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
		.MemtoRegSign(ID_MemtoRegSign),
    .MemWrite(ID_MemWrite), 
    .ALUSrc(ID_ALUSrc), 
    .RegDst(ID_RegDst), 
    .RegWrite(ID_RegWrite), 
    .Branch(ID_Branch),
	 .TipoBranch(ID_TipoBranch),
	 .Jump(ID_Jump),
    .ALUControl(ID_ALUControl),
	 .TipoExtension(ID_TipoExtension),
	 .MemOp(ID_MemOp),
	 .Halt(ID_Halt)
    );

/////////////////////////////////HazardUnit///////////////////////////////////////	 


HazardUnit DataPath_HazardUnit (
    .RsD(ID_Instruccion[25:21]), 
    .RtD(ID_Instruccion[20:16]), 
    .RsE(EX_Rs), 
    .RtE(EX_Rt), 
    .WriteRegE(EX_WriteReg), 
    .WriteRegM(MEM_WriteReg), 
    .WriteRegW(WB_WriteReg), 
    .RegWriteE(EX_RegWrite), 
    .RegWriteM(MEM_RegWrite), 
    .RegWriteW(WB_RegWrite), 
    .MemToRegE(EX_MemtoReg), 
    .MemToRegM(MEM_MemtoReg), 
    .BranchD(ID_Branch),
	 .JumpD(ID_Jump),
    .StallF(IF_Stall), 
    .StallD(ID_Stall), 
    .ForwardAD(ID_ForwardA), 
    .ForwardBD(ID_ForwardB), 
    .FlushE(EX_Flush), 
    .ForwardAE(EX_ForwardA), 
    .ForwardBE(EX_ForwardB)
    );


	 
//////////////////////////////////ID_EX////////////////////////////////////////////	 
ID_EX DataPath_ID_EX (
	.clk(clk),
	.reset(reset),
	.clear(EX_Flush),
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
		.MemtoRegSignIn(ID_MemtoRegSign),
	.MemWriteIn(ID_MemWrite),
	.MemOpIn(ID_MemOp),	
	.RegDstIn(ID_RegDst), 
	.HaltIn(ID_Halt),
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
.MemtoRegSignOut(EX_MemtoRegSign),	
	.MemWriteOut(EX_MemWrite),
	.MemOpOut(EX_MemOp),	
	.RegDstOut(EX_RegDest),
	.HaltOut(EX_Halt)
    );	 
	 

Mux3 EX_Mux3_RegDst (
    .in0(EX_Rt), 
    .in1(EX_Rd), 
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
    .in3(MEM_ALUOut),
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
    .clk(clk),
	 .reset(reset),
    .RegWriteIn(EX_RegWrite), //Control
    .MemtoRegIn(EX_MemtoReg), //Control
    .MemWriteIn(EX_MemWrite), //Control
	 .MemOpIn(EX_MemOp),
    .ALUResultIn(EX_ALUOut),	//Datos
    .WriteRegIn(EX_WriteReg), //Numero de Registro para writeback
	 .MemtoRegSignIn(EX_MemtoRegSign),
    .WriteDataIn(EX_WriteData), //Datos para writeback
	 .HaltIn(EX_Halt),
	 //Outputs
    .RegWriteOut(MEM_RegWrite), //Control 
    .MemtoRegOut(MEM_MemtoReg), //Control 
    .MemWriteOut(MEM_MemWrite), //Control 
	 .MemOpOut(MEM_MemOp),
    .ALUResultOut(MEM_ALUOut), //Datos
    .WriteDataOut(MEM_WriteData),	//DATOS
    .WriteRegOut(MEM_WriteReg), //Direccion de Registro
	 .MemtoRegSignOut(MEM_MemtoRegSign),
	 .HaltOut(MEM_Halt)
    );


MemDatos MEM_MemDatos (
  .clk(clk), // input clka
  .we(MEM_MemWrite),
  .op(MEM_MemOp),
  .signo(MEM_MemtoRegSign),
  .addr(MEM_ALUOut), // input [31 : 0] addra
  .din(MEM_WriteData), // input [31 : 0] dina
  .dout(MEM_RD), // output [31 : 0] douta
  .mem(du_mem)	//Debug Unit
);

/*
	LATCH MEM_WB
*/

MEM_WB DataPath_MEM_WB (
    .clk(clk), 
	 .reset(reset),
    .MemDataIn(MEM_RD), 
    .ALUDataIn(MEM_ALUOut), 
    .WriteRegIn(MEM_WriteReg), 
    .RegWriteIn(MEM_RegWrite), 
    .MemtoRegIn(MEM_MemtoReg),
	 .HaltIn(MEM_Halt),
	//Outputs	 
    .MemDataOut(WB_ReadData), 
    .ALUDataOut(WB_ALUOut), 
    .WriteRegOut(WB_WriteReg), 
    .RegWriteOut(WB_RegWrite), 
    .MemtoRegOut(WB_MemToReg),
	 .HaltOut(WB_Halt)
    );


Mux2 WB_Mux2_MemToReg ( 
    .in0(WB_ALUOut), 
	 .in1(WB_ReadData),
    .out(WB_Result), 
    .sel(WB_MemToReg)
    );

/*
	WIRES PARA DEBUG UNIT
*/
assign du_if_id = {ID_Instruccion,ID_PC4};
assign du_id_ex = {
	EX_RD1, 
	EX_RD2, 
	EX_ImmExtendido, 
	EX_Rs, 
	EX_Rt, 
	EX_Rd, 
	EX_ALUControl, 
	EX_ALUSrc, 
	EX_RegWrite, 
	EX_MemtoReg, 
	EX_MemWrite,
	EX_MemOp,	
	EX_RegDest,
	EX_Halt
};

assign du_halt=WB_Halt;
endmodule
