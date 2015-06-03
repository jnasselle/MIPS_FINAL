`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:49:21 06/03/2015
// Design Name:   DataPath
// Module Name:   D:/Ultrabook/Documents/Facultad/Trabajo Arquitectura/MIPS_FINAL/TB_DataPath.v
// Project Name:  MIPS_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataPath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_DataPath;

	// Inputs
	reg clk;
	reg rx;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	DataPath uut (
		.clk(clk), 
		.rx(rx), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rx = 0;

		// Wait 100 ns for global reset to finish
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
		#10;
		clk=1;
		#10;
		clk=0;
        
		// Add stimulus here

	end
      
endmodule

