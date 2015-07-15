`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:07 07/15/2015
// Design Name:   HazardUnit
// Module Name:   /home/jnasselle/Facu/Arquitectura_de_Computadoras/FINAL/TB_HazardUnit.v
// Project Name:  FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HazardUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_HazardUnit;

	// Inputs
	reg [4:0] RsD;
	reg [4:0] RtD;
	reg [4:0] RsE;
	reg [4:0] RtE;
	reg [4:0] WriteRegE;
	reg [4:0] WriteRegM;
	reg [4:0] WriteRegW;
	reg RegWriteE;
	reg RegWriteM;
	reg RegWriteW;
	reg MemToRegE;
	reg MemToRegM;
	reg BranchD;
	reg JumpD;

	// Outputs
	wire StallF;
	wire StallD;
	wire ForwardAD;
	wire ForwardBD;
	wire FlushE;
	wire [1:0] ForwardAE;
	wire [1:0] ForwardBE;

	// Instantiate the Unit Under Test (UUT)
	HazardUnit uut (
		.RsD(RsD), 
		.RtD(RtD), 
		.RsE(RsE), 
		.RtE(RtE), 
		.WriteRegE(WriteRegE), 
		.WriteRegM(WriteRegM), 
		.WriteRegW(WriteRegW), 
		.RegWriteE(RegWriteE), 
		.RegWriteM(RegWriteM), 
		.RegWriteW(RegWriteW), 
		.MemToRegE(MemToRegE), 
		.MemToRegM(MemToRegM), 
		.BranchD(BranchD), 
		.JumpD(JumpD), 
		.StallF(StallF), 
		.StallD(StallD), 
		.ForwardAD(ForwardAD), 
		.ForwardBD(ForwardBD), 
		.FlushE(FlushE), 
		.ForwardAE(ForwardAE), 
		.ForwardBE(ForwardBE)
	);

	initial begin
		// Initialize Inputs
		RsD = 0;
		RtD = 0;
		RsE = 0;
		RtE = 0;
		WriteRegE = 0;
		WriteRegM = 0;
		WriteRegW = 0;
		RegWriteE = 0;
		RegWriteM = 0;
		RegWriteW = 0;
		MemToRegE = 0;
		MemToRegM = 0;
		BranchD = 0;
		JumpD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

