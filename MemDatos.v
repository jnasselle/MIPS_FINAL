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
  wire clka, // input clka
  input [2:0] write, // input [3 : 0] wea
  input [2:0] read,
  input [31:0] addr, // input [31 : 0] addra
  input [31:0] dina, // input [31 : 0] dina
  output reg [31:0] dout,
  output reg [31:0] memoria[15:0]	//Para almacenar 16 palabra
    );
localparam WORD = 0;
localparam HALFWORD = 1;
localparam BYTE = 2;

// TODO: ver ENDIANESS de la memoria
always@(posedge clka)
begin
	case (read)
		WORD:
			dout<=memoria[addr];
		HALFWORD:
			dout<=memoria[addr] & 32'hFFFF0000;
		BYTE:
			dout<=memoria[addr] & 32'hFF000000;
	endcase
end


always@(posedge clka)
begin
	case (write)
		WORD:
			memoria[addr]<=din;
		HALFWORD:
			memoria[addr]<=din & 32'hFFFF0000;
		BYTE:
			memoria[addr]<=din & 32'hFF000000;	
	endcase
end
endmodule
