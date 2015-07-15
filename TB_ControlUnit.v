`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:39:10 07/15/2015
// Design Name:   ControlUnit
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_ControlUnit.v
// Project Name:  FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_ControlUnit;

	// Inputs
	reg [5:0] Op;
	reg [5:0] Funct;

	// Outputs
	wire MemtoReg;
	wire MemWrite;
	wire MemtoRegSign;
	wire ALUSrc;
	wire RegDst;
	wire RegWrite;
	wire Branch;
	wire TipoBranch;
	wire Jump;
	wire [5:0] ALUControl;
	wire TipoExtension;
	wire [2:0] MemOp;
	wire Halt;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.Op(Op), 
		.Funct(Funct), 
		.MemtoReg(MemtoReg), 
		.MemWrite(MemWrite), 
		.MemtoRegSign(MemtoRegSign), 
		.ALUSrc(ALUSrc), 
		.RegDst(RegDst), 
		.RegWrite(RegWrite), 
		.Branch(Branch), 
		.TipoBranch(TipoBranch), 
		.Jump(Jump), 
		.ALUControl(ALUControl), 
		.TipoExtension(TipoExtension), 
		.MemOp(MemOp), 
		.Halt(Halt)
	);

	initial begin
		// Initialize Inputs
		Op = 0;
		Funct = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		/*
			----Simulacion de instrucciones tipo R---
			Intrucciones:
			ADD
			ADDU
			AND
			NOR
			OR
			SLL
			SLLV
			SLT
			SLTU
			SRA
			SRAV
			SRL
			SRLV
			SUB
			SUBU
			XOR
		*/
		#10
		Funct=6'b100000;
		#10
		Funct=6'b100001;
		#10
		Funct=6'b100100;
		#10
		Funct=6'b100111;
		#10
		Funct=6'b100101;
		#10
		Funct=6'b000000;
		#10
		Funct=6'b000100;
		#10
		Funct=6'b101010;
		#10
		Funct=6'b101011;
		#10
		Funct=6'b000011;
		#10
		Funct=6'b000111;
		#10
		Funct=6'b000010;
		#10
		Funct=6'b000110;
		#10
		Funct=6'b100010;
		#10
		Funct=6'b100011;
		#10
		Funct=6'b100110;
	
		/* ----Simulacion de instrucciones tipo I---
		Instrucciones:
			ADDI
			ADDIU
			ANDI
			BEQ
			BNE
			LB
			LBU
			LH
			LHU
			LUI
			LW
			LWU
			ORI
			SB
			SH
			SLTI
			SLTIU
			SW
			XORI
		*/
		
		#10;Op=6'b001000;
		#10;Op=6'b001001;
		#10;Op=6'b001100;
		#10;Op=6'b000100;
		#10;Op=6'b000101;
		#10;Op=6'b100000;
		#10;Op=6'b100100;
		#10;Op=6'b100001;
		#10;Op=6'b100101;
		#10;Op=6'b001111;
		#10;Op=6'b100011;
		#10;Op=6'b100111;
		#10;Op=6'b001101;
		#10;Op=6'b101000;
		#10;Op=6'b101001;
		#10;Op=6'b001010;
		#10;Op=6'b001011;
		#10;Op=6'b101011;
		#10;Op=6'b001110;
	end
      
endmodule

