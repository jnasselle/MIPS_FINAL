`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:17:20 06/15/2015 
// Design Name: 
// Module Name:    MemDatos 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MemDatos(
	wire clk, // input clka
	wire we,
	wire [2:0] op,
	input [31:0] addr, // input [31 : 0] addra
	input [31:0] din, // input [31 : 0] dina
	output reg [31:0] dout,
	output reg [7:0] memoria[63:0]	//Para almacenar 16 palabra
    );

always@(posedge clk)
begin
	if(we)
		begin
			case (op)
				BYTE:
					memoria[addr]<=din[7:0];
				HALFWORD:
					begin
					memoria[addr]<=din[7:0];
					memoria[addr+1]<=din[15:8];
					end
				WORD:
					begin
					memoria[addr]<=din[7:0];
					memoria[addr+1]<=din[15:8];
					memoria[addr+2]<=din[23:16];
					memoria[addr+3]<=din[31:24];
					end
			endcase
		end
	else
		begin
			case (op)
				BYTE:
					dout<={memoria[addr],{24{0}}};
				HALFWORD:
					dout<={memoria[addr],memoria[addr+1],{16{0}}};
				WORD:
					dout<={memoria[addr],memoria[addr+1],memoria[addr+2],memoria[addr+3]};
			endcase
		end
end
endmodule
