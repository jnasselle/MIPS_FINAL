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
	input [5:0] ALUCon,
	input [31:0] A, //rs
	input [31:0] B, //rt o shamt
	output [31:0] ALUOut
	);
	
	/*
	http://billauer.co.il/blog/2012/10/signed-arithmetics-verilog/
	Se deben implementar 16 operaciones,por lo que el ALUCon debe ser de 4bits.
	Desventaja: El controlador va a tener que tener logica para routear la operacion
					mientras que si mandamos los 6 bits de ALUOp es directo.
	Sacar flag de overflow,no se si la vamos a usar despues pero tiene que estar
	Operaciones de shift: Fixed vs Variable
		->FIXED: La cantidad a desplazar viene en la instruccion (campo shamt)
		->VARIABLE: La cantidad a desplazar son los ultimos 5 bits del contenido de un registro
	*/
	reg [31:0] ALURes;
	
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
		case(ALUCon)
			//Aritmeticas
			ADD:	ALURes <= A+B;
			ADDU:	ALURes <= A+B;
			SUB:	ALURes <= A-B;
			SUBU:	ALURes <= A-B; //Falta
			//Logicas
			AND:	ALURes <= A&B;
			NOR:	ALURes <= ~(A|B);
			OR:	ALURes <= A|B;
			SLT:	ALURes <= A<B ? 1:0;
			XOR:	ALURes <= A^B;
			SLTU:	ALURes <=A<B ? 1:0; //Falta
			//Shiftings Fixed
			SLL:	ALURes <= A<<B;
			SRA:	ALURes <= A>>>B;
			SRL:	ALURes <= A>>B;
			//Shiftings Variable
			SLLV:	ALURes <= A<<B[4:0];
			SRAV:	ALURes <= A>>>B[4:0];
			SRLV:	ALURes <= A>>B[4:0];
			default: ALURes <=0;
		endcase
	end
	
	assign Zero = (ALUOut == 0) ? 1'b1 : 1'b0;
	assign ALUOut = ALURes;


endmodule
