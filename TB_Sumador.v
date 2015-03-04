`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:57:30 03/04/2015
// Design Name:   Sumador
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_Sumador.v
// Project Name:  FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sumador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_Sumador;

	// Inputs
	reg [31:0] op1;
	reg [31:0] op2;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Sumador uut (
		.op1(op1), 
		.op2(op2), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		op1 = 0;
		op2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10
		op1=-10;
		op2=15;

	end
      
endmodule

