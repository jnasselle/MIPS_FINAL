`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:56:26 03/04/2015
// Design Name:   ALU
// Module Name:   D:/Ultrabook/Documents/Facultad/Trabajo Arquitectura/MIPS_FINAL/TB_ALU.v
// Project Name:  MIPS_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_ALU;

	// Inputs
	reg [3:0] AluCon;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] AluOut;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.AluCon(AluCon), 
		.A(A), 
		.B(B), 
		.AluOut(AluOut), 
		.Zero(Zero)
	);

	initial begin
		// Initialize Inputs
		AluCon = 0;
		A = 0;
		B = 0;

		// Wait 10 ns for global reset to finish
		#10;
		AluCon = 4'b0000;
		A = 1;
		B = 1;
		
		#10;
		
		
        
		// Add stimulus here

	end
      
endmodule

