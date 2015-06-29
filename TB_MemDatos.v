`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:00:26 06/26/2015
// Design Name:   MemDatos
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_MemDatos.v
// Project Name:  FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MemDatos
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_MemDatos;

	// Inputs
	reg clk;
	reg we;
	reg [2:0] op;
	reg [31:0] addr;
	reg [31:0] din;

	// Outputs
	wire [31:0] dout;
	wire [255:0] mem;

	// Instantiate the Unit Under Test (UUT)
	MemDatos uut (
		.clk(clk), 
		.we(we), 
		.op(op), 
		.addr(addr), 
		.din(din), 
		.dout(dout), 
		.mem(mem)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		we = 0;
		op = 0;
		addr = 0;
		din = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10
		we=1;
		op=3'b100;
		din=255;
		#32
		we=0;
		#30
		op=3'b010;
		//op=3'b010;
		
		

	end
	always
	#10 clk=~clk;
      
endmodule

