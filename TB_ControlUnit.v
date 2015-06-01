`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:04:33 06/01/2015
// Design Name:   ControlUnit
// Module Name:   C:/Users/Andrea/Documents/GitHub/MIPS_FINAL/TB_ControlUnit.v
// Project Name:  MIPS_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_ControlUnit;

	// Inputs
	reg [5:0] Op;
	reg [5:0] Funct;

	// Outputs
	wire MemtoReg;
	wire MemWrite;
	wire ALUSrc;
	wire RegDst;
	wire RegWrite;
	wire Branch;
	wire [5:0] ALUControl;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.Op(Op), 
		.Funct(Funct), 
		.MemtoReg(MemtoReg), 
		.MemWrite(MemWrite), 
		.ALUSrc(ALUSrc), 
		.RegDst(RegDst), 
		.RegWrite(RegWrite), 
		.Branch(Branch), 
		.ALUControl(ALUControl)
	);

	initial begin
		// Initialize Inputs
		#5
		Op = 000000;
		Funct = 100000;
		
		#5
		Op = 000000;
		Funct = 100001;

		#5
		Op = 000000;
		Funct =100100;
		
		#5
		Op = 000000;
		Funct = 100111;
		
		#5
		Op = 000000;
		Funct = 100101;
		
		#5
		Op = 000000;
		Funct = 000000;
		
		#5
		Op = 000000;
		Funct = 000100;
		
		#5
		Op = 000000;
		Funct = 101010;
		
		#5
		Op = 000000;
		Funct = 101011;
		
		#5
		Op = 000000;
		Funct = 0000011;
		
		#5
		Op = 000000;
		Funct = 000111;
		
		#5
		Op = 000000;
		Funct = 000010;
		
		#5
		Op = 000000;
		Funct = 000110;
		
		#5
		Op = 000000;
		Funct = 100010;
		
		#5
		Op = 000000;
		Funct = 100011;
		
		#5
		Op = 000000;
		Funct = 100110;
		
		#15
		Op = 001000;
		Funct = 100000;
		
		#5
		Op = 100000;
		Funct = 100000;
		
		#5
		Op = 100001;
		Funct = 100000;
		
		#5
		Op = 100011;
		Funct = 100000;
		
		#5
		Op = 101000;
		Funct = 100000;
		
		#5
		Op = 101001;
		Funct = 100000;
		
		#5
		Op = 101011;
		Funct = 100000;
		
		#15
		Op = 001001;
		Funct = 100001;
		
		#5
		Op = 001100;
		Funct = 100001;
		
		#5
		Op = 100100;
		Funct = 100001;
		
		#5
		Op = 100101;
		Funct = 100001;
		
		#5
		Op = 100111;
		Funct = 100001;
		
		#5
		Op = 001101;
		Funct = 100001;
		
		#15
		Op = 001111;
		Funct = 000000;
		
		#15
		Op = 001101;
		Funct = 100101;
		
		#15
		Op = 001010;
		Funct = 101010;
		
		#15
		Op = 001011;
		Funct = 101011;
		
		#15
		Op = 001110;
		Funct = 100110;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

