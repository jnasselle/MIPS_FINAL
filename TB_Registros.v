`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:55:12 03/04/2015
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
	reg [4:0] rs_addr;
	reg [4:0] rt_addr;
	reg [4:0] rd_addr;
	reg [31:0] rd_data;
	reg write_en;

	// Outputs
	wire [31:0] rs_data;
	wire [31:0] rt_data;

	// Instantiate the Unit Under Test (UUT)
	Registros uut (
		.clk(clk), 
		.reset(reset), 
		.rs_addr(rs_addr), 
		.rt_addr(rt_addr), 
		.rd_addr(rd_addr), 
		.rd_data(rd_data), 
		.write_en(write_en), 
		.rs_data(rs_data), 
		.rt_data(rt_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		rs_addr = 0;
		rt_addr = 0;
		rd_addr = 0;
		rd_data = 12345;
		write_en = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10
		rt_addr=1;
		#10
		rd_addr=1;

	end
	always
	#5 clk=~clk;
      
endmodule

