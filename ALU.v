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
	localparam ADD = 6'b100000;
	localparam ADDU =6'b100001;
	localparam SUB = 6'b100010;
	localparam SUBU = 6'b100011;
	//Logicas
	localparam AND = 6'b100100;
	localparam NOR = 6'b100111;
	localparam OR	= 6'b100101;
	localparam XOR = 6'b100110;
	localparam SLT = 6'b101010;
	localparam SLTU = 6'b101011;
	//Shifting Fixed
	localparam SLL = 6'b000000;
	localparam SRA = 6'b000011;
	localparam SRL = 6'b000010;
	//Shifting Variable
	localparam SLLV = 6'b000100;
	localparam SRAV = 6'b000111;
	localparam SRLV = 6'b000110;
	
   always@*
   begin 
		case(AluCon)
			//Aritmeticas
			ADD:	AluRes <= A+B;
			ADDU:	AluRes <= A+B;
			SUB:	AluRes <= A-B;
			SUBU:	AluRes <= A-B; //Falta
			//Logicas
			AND:	AluRes <= A&B;
			NOR:	AluRes <= ~(A|B);
			OR:	AluRes <= A|B;
			SLT:	AluRes <= A<B ? 1:0;
			XOR:	AluRes <= A^B;
			SLTU:	AluRes <=A<B ? 1:0; //Falta
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
