`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:22 06/10/2015
// Design Name:   DataPath
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_DataPath.v
// Project Name:  FINAL
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
	reg reset;

	// Outputs
	wire tx;

	// Instantiate the Unit Under Test (UUT)
	DataPath uut (
		.clk(clk), 
		.rx(rx), 
		.reset(reset), 
		.tx(tx)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rx = 0;
		reset = 0;
        
		// Add stimulus here
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		#10 clk=~clk;
		

	end

endmodule

