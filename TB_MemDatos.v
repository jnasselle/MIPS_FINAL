`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:44:42 07/15/2015
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
	reg signo;
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
		.signo(signo), 
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
		signo = 0;
		addr = 0;
		din = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/*	----Simulacion de almacenar palabra completa (SW)----
			Valor=0xABCDDCBA
			Ubicacion=0
			Ej Intruccion: SW R1,0(R0) siendo R1=0xABCDDCBA
			Resultado esperado:
				Mem[0]=0xBA
				Mem[1]=0xDC
				Mem[2]=0xCD
				Mem[3]=0xAB
			
		*/
		#10
		we=1;
		op=3'b100;
		addr = 0;
		din =32'hABCDDCBA;
		/*	----Simulacion de almacenar media palabra (SH)----
			Valor=0xABCDDCBA
			Ubicacion=4
			Ej Intruccion: SW R1,4(R0) siendo R1=0x0xABCDDCBA
			Resultado esperado:
				Mem[4]=0xBA
				Mem[5]=0xDC
		*/
		#10
		we=1;
		op=3'b010;
		addr = 4;
		din =32'hABCDDCBA;
		/*	----Simulacion de almacenar byte (SB)----
		Valor=0xABCDDCBA
		Ubicacion=6
		Ej Intruccion: SW R1,6(R0) siendo R1=0x0xABCDDCBA
		Resultado esperado:
			Mem[6]=0xBA
		*/
		#10
		we=1;
		op=3'b010;
		addr = 4;
		din =32'hABCDDCBA;
		
		
		/*	----Simulacion de extraer palabra con signo(LW)----
		Ubicacion=0
		Ej Intruccion: LW R2,0(R0) siendo
				Mem[0]=0xBA
				Mem[1]=0xDC
				Mem[2]=0xCD
				Mem[3]=0xAB
		Resultado esperado:
			R2=0xABCDDCBA
		*/
		#10
		we=0;
		op=3'b100;
		signo = 1;
		addr = 0;
		/*	----Simulacion de extraer media palabra con signo(LH)----
		Ubicacion=0
		Ej Intruccion: LW R2,0(R0) siendo
				Mem[0]=0xBA
				Mem[1]=0xDC
				Mem[2]=0xCD
				Mem[3]=0xAB
		Resultado esperado:
			R2=0xFFFFDCBA
		*/
		#10
		we=0;
		op=3'b010;
		signo = 1;
		addr = 0;
		/*	----Simulacion de extraer media palabra sin signo(LHU)----
		Ubicacion=0
		Ej Intruccion: LW R2,0(R0) siendo
				Mem[0]=0xBA
				Mem[1]=0xDC
				Mem[2]=0xCD
				Mem[3]=0xAB
		Resultado esperado:
			R2=0x0000DCBA
		*/
		#10
		we=0;
		op=3'b010;
		signo = 0;
		addr = 0;
	end
	always
	#5 clk=~clk;
      
endmodule

