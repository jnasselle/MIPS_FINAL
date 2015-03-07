`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:25 03/02/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [3:0] AluCon,
	input [31:0] A, //rt
	input [31:0] B, //rs o shamt
	output [31:0] AluOut,
	output Zero
	);
	
	/*
	http://billauer.co.il/blog/2012/10/signed-arithmetics-verilog/
	Se deben implementar 16 operaciones,por lo que el AluCon debe ser de 4bits.
	Desventaja: El controlador va a tener que tener logica para routear la operacion
					mientras que si mandamos los 6 bits de AluOp es directo.
	Sacar flag de overflow,no se si la vamos a usar despues pero tiene que estar
	Operaciones de shift: Fixed vs Variable
		->FIXED: La cantidad a desplazar viene en la instruccion (campo shamt)
		->VARIABLE: La cantidad a desplazar son los ultimos 5 bits del contenido de un registro
	*/
	reg [31:0] AluRes;
	
	//Aritmeticas
	localparam ADD = 4'b0000;
	localparam ADDU =;
	localparam SUB = 4'b1110;
	localparam SUBU =;
	//Logicas
	localparam AND = 4'b0100;
	localparam NOR = 4'b0111;
	localparam OR	= 4'b0101;
	localparam XOR = 4'b0110;
	localparam SLT = 4'b1010;
	localparam SLTU = ;
	//Shifting Fixed
	localparam SLL = 4'b1000;
	localparam SRA = 4'b0011;
	localparam SRL = 4'b0010;
	//Shifting Variable
	localparam SLLV = 4'b;
	localparam SRAV = 4'b;
	localparam SRLV = 4'b;
	
   always@*
   begin 
		case(AluCon)
			//Aritmeticas
			ADD:	AluRes <= A+B;
			SUB:	AluRes <= A-B;
			//Logicas
			AND:	AluRes <= A&B;
			NOR:	AluRes <= ~(A|B);
			OR:	AluRes <= A|B;
			SLT:	AluRes = A<B ? 1:0;
			XOR:	AluRes <= A^B;
			//Shiftings Fixed
			SLL:	AluRes <= A<<B;
			SRA:	AluRes <= A>>>B;
			SRL:	AluRes <= A>>B;
			//Shiftings Variable
			SLLV:	AluRes <= A<<B[4:0];
			SRAV:	AluRes <= A>>>B[4:0];
			SRLV:	AluRes <= A>>B[4:0];
		endcase
	end
	
	assign Zero = (AluOut == 0) ? 1'b1 : 1'b0;
	assign AluOut = AluRes;


endmodule
