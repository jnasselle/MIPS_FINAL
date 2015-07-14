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
	input clk, // input clka
	input we,
	input [2:0] op,
	input signo,
	input [31:0] addr, // input [31 : 0] addra
	input [31:0] din, // input [31 : 0] dina
	output reg [31:0] dout,
	output [255:0] mem//Para almacenar 16 palabra
    );
	 
reg [7:0] memoria[31:0];	//Se pueden almacenar 8 palabras de 32 bits

/*
	Memoria Little Endian

*/
assign mem={
	memoria[3],
	memoria[2],
	memoria[1],
	memoria[0],
	memoria[7],
	memoria[6],
	memoria[5],
	memoria[4],
	memoria[11],
	memoria[10],
	memoria[9],
	memoria[8],
	memoria[15],
	memoria[14],
	memoria[13],
	memoria[12],
	memoria[19],
	memoria[18],
	memoria[17],
	memoria[16],
	memoria[23],
	memoria[22],
	memoria[21],
	memoria[20],
	memoria[27],
	memoria[26],
	memoria[25],
	memoria[24],
	memoria[31],
	memoria[30],
	memoria[29],
	memoria[28]
	};


localparam BYTE=3'b001;
localparam HALFWORD=3'b010;
localparam WORD=3'b100;

always@(negedge clk)
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
		if(signo)
			begin
				case (op)
						BYTE:
							dout<={{24{memoria[addr][7]}},memoria[addr]};
						HALFWORD:
							dout<={{16{memoria[addr+1][7]}},memoria[addr+1],memoria[addr]};
						WORD:
							dout<={memoria[addr+3],memoria[addr+2],memoria[addr+1],memoria[addr]};
				endcase
			end
		else
			case (op)
						BYTE:
							dout<={{24{1'b0}},memoria[addr]};
						HALFWORD:
							dout<={{16{1'b0}},memoria[addr+1],memoria[addr]};
						WORD:
							dout<={memoria[addr+3],memoria[addr+2],memoria[addr+1],memoria[addr]};
			endcase
end


endmodule
