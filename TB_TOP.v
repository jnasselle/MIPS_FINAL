`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:29:42 07/01/2015
// Design Name:   TOP
// Module Name:   D:/Ultrabook/Documents/Facultad/Trabajo Arquitectura/MIPS_FINAL/TB_TOP.v
// Project Name:  MIPS_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TOP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_TOP;

	// Inputs
	reg clk;
	reg rst;
	reg rx;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	TOP uut (
		.clk(clk), 
		.rst(rst), 
		.rx(rx), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		rx = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		

	end
	always
	#10 clk=~clk;
      
endmodule

