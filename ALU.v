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
    input [31:0] A,
	input [31:0] B,
    output [31:0] AluOut,
    output Zero
	);
	
	reg [31:0] AluRes;
	
	localparam ADD = 4'b0000;
	localparam AND = 4'b0100;
	localparam NOR = 4'b0111;
	localparam OR = 4'b0101;
	localparam SLL = 4'b1000;
	localparam SLT = 4'b1010;
	localparam SRA = 4'b0011;
	localparam SRL = 4'b0010;
	localparam SUB = 4'b1110;
	localparam XOR = 4'b0110;
	
   always@*
   begin 
		case(AluCon)
		
			ADD: AluRes <= A+B;
			
			AND: AluRes <= A&B;
			
			NOR: AluRes <= ~(A|B);
			
			OR: AluRes <= A|B;
			
			SLL: AluRes <= (A<<B);
			
			SLT: AluRes = A<B ? 1:0; 
			
			SRA: AluRes = (A>>>B);
			
			SRL: AluRes <= (A>>B);
			
			SUB: AluRes <= A-B;
			
			XOR: AluRes <= A^B;
		  
			default: AluRes = 0;
				
		endcase
	end
	
	assign Zero = (AluOut == 0) ? 1'b1 : 1'b0;
	assign AluOut = AluRes;


endmodule
