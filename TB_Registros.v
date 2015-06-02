`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:22:44 06/02/2015
// Design Name:   Registros
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_Registros.v
// Project Name:  FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Registros
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_Registros;

	// Inputs
	reg clk;
	reg reset;
	reg [4:0] A1In;
	reg [4:0] A2In;
	reg [4:0] A3In;
	reg [31:0] WD3In;
	reg WE3;

	// Outputs
	wire [31:0] RD1Out;
	wire [31:0] RD2Out;
	wire [1023:0] Registros;

	// Instantiate the Unit Under Test (UUT)
	Registros uut (
		.clk(clk), 
		.reset(reset), 
		.A1In(A1In), 
		.A2In(A2In), 
		.A3In(A3In), 
		.WD3In(WD3In), 
		.WE3(WE3), 
		.RD1Out(RD1Out), 
		.RD2Out(RD2Out), 
		.Registros(Registros)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		A1In = 0;
		A2In = 0;
		A3In = 0;
		WD3In = 0;
		WE3 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		A3In=0;
		WD3In=63;
		WE3=1;
		#10
		A3In=1;
      
		// Add stimulus here

	end
	always
	#5 clk=!clk;
      
endmodule

