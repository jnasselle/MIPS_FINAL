`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:31:17 07/15/2015
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
	reg reset;

	// Outputs
	wire [1023:0] du_reg;
	wire [255:0] du_mem;
	wire [63:0] du_if_id;
	wire [126:0] du_id_ex;
	wire [76:0] du_ex_mem;
	wire [71:0] du_mem_wb;
	wire du_halt;

	// Instantiate the Unit Under Test (UUT)
	DataPath uut (
		.clk(clk), 
		.reset(reset), 
		.du_reg(du_reg), 
		.du_mem(du_mem), 
		.du_if_id(du_if_id), 
		.du_id_ex(du_id_ex), 
		.du_ex_mem(du_ex_mem), 
		.du_mem_wb(du_mem_wb), 
		.du_halt(du_halt)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
	#5 clk=~clk;
      
endmodule

