`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:13 03/11/2015 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	input [5:0] Op,
	input [5:0] Funct, //Es necesario que pase por este modulo?
//	input zero,
	output reg MemtoReg,
	output reg MemWrite,
//	output pcscr,			para la AND
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg Branch,
	output reg [5:0] ALUControl //salida en caso de ser necesario.
   );
	
localparam TIPOR = 6'b000000;
localparam ADDI = 6'b001000;
localparam ADDIU = 6'b010001;
localparam ANDI = 6'b001100;
localparam BEQ = 6'b000100;
localparam BNE = 6'b000101;
localparam LB = 6'b100000;
localparam LBU = 6'b100100;
localparam LH = 6'b100001;
localparam LHU = 6'b100101;
localparam LUI = 6'b001111;
localparam LW = 6'b100011;
localparam LWU = 6'b100111;
localparam ORI = 6'b001101;
localparam SB = 6'b101000;
localparam SH = 6'b101001;
localparam SLTI = 6'b001010;
localparam SLTIU = 6'b001011;
localparam SW = 6'b101011;
localparam XORI = 6'b001110;


always @(*)
begin
case(Op)
	TIPOR:
		begin
			ALUControl=Funct;	
			MemtoReg=0;
			MemWrite=0;
			ALUSrc=0;
			RegDst=1;
			RegWrite=1;
			Branch=0;
		end
	ADDI:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end
	ADDIU:
		begin
			ALUControl= 6'b100001;	
			MemtoReg=0;
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	ANDI:
		begin
			ALUControl= 6'b100100;	
			MemtoReg=0;
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	BEQ:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;//
			MemWrite=0;//
			ALUSrc=1;//
			RegDst=0;//
			RegWrite=0;//
			Branch=1;
		end  
	BNE:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;//
			MemWrite=0;//
			ALUSrc=1;//
			RegDst=0;//
			RegWrite=0;//
			Branch=1;
		end   
	LB:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end  
	LBU:
		begin
			ALUControl= 6'b100001;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	LH:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	LHU:
		begin
			ALUControl= 6'b100001;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	LUI:
		begin
			ALUControl= 6'b000000;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	LW:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	LWU:
		begin
			ALUControl= 6'b100001;	
			MemtoReg=1;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end 
	ORI:
		begin
			ALUControl= 6'b100101;	
			MemtoReg=0;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=1;//
			RegWrite=1;
			Branch=0;
		end 
	SB:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;//
			MemWrite=1;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=0;
			Branch=0;
		end 
	SH:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;//
			MemWrite=1;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=0;
			Branch=0;
		end
	SLTI:
		begin
			ALUControl= 6'b101010;	
			MemtoReg=0;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end  
	SLTIU:
		begin
			ALUControl= 6'b101011;	
			MemtoReg=0;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=0;
			Branch=0;
		end  
	SW:
		begin
			ALUControl= 6'b100000;	
			MemtoReg=0;//
			MemWrite=1;
			ALUSrc=1;
			RegDst=0;//
			RegWrite=1;
			Branch=0;
		end
	XORI:
		begin
			ALUControl= 6'b100110;	
			MemtoReg=0;//
			MemWrite=0;
			ALUSrc=1;
			RegDst=1;//
			RegWrite=1;
			Branch=0;
		end  
endcase	
end		
		
//	reg [6:0] controls;
//	assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Branch} controls;
	
	// Establecer las lineas de control segun la opcion.
//	always @ (*)
//	case(opcion)
//		6'b000000: controls <= 9'b1100000; //R
//		6'b100011: controls <= 9'b1010010; //LW
//		6'b101011: controls <= 9'b0010100; //SW
//		6'b000100: controls <= 9'b0001000; //BEQ
//		6'b001000: controls <= 9'b1010000; //ADDI
//		6'b000010: controls <= 9'b0000001; //J
//		default:	controls <= 9'bxxxxxxx; //NODEF
		
//	endcase

endmodule
