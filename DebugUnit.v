`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:38 06/15/2015 
// Design Name: 
// Module Name:    DebugUnit 
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
module DebugUnit(
	
	input clk,
	
	//Entradas desde UART
	input wire rx_rdy,	//rx-ready que llego un mensaje
	input wire tx_done,
	input wire [7:0] rx_bus,
	
	//Entradas desde DataPath
	input [1619:0] dp_bus,
	input dp_halt,
	 
	//Salidas para DataPath
	output reg Datapath_clk,
	//output reg Datapath_reset,
	 
	//Salidas para UART
	output reg tx_write,		//WR para que mande a la cola el nuevo daato
	output reg [7:0] tx_bus		//ver bien
	);
	 
	reg [1375:0] datos = 0;
	reg [7:0] contador = 0;
	//reg [5:0] contador_fin = 0;

   parameter IDLE = 7'b0000001;
	parameter PAP1 = 7'b0000010;
	parameter PAP2 = 7'b0000100;
	parameter CONT = 7'b0001000;
	parameter SEND = 7'b0010000;
	parameter SENDING = 7'b0100000;
	parameter FIN = 7'b1000000;
	parameter BYTES=203;
	
	//reg [6:0] state = IDLE;
	reg [6:0] next_state = IDLE;
	reg [6:0] current_state=IDLE;

	
//Actualizacion de estado y salidas, asignacion sincrona
always @(posedge clk)
	begin		
		case (current_state)
			
			IDLE:
			begin
				contador=0;
				Datapath_clk=0;
				if(rx_rdy==1)
				begin
					if(rx_bus==8'b01110000)
					begin
						next_state=PAP1;
					end
					if(rx_bus==8'b01100011)
					begin
						next_state=CONT;
					end
				end
				else
				next_state=IDLE;
			end
			
			PAP1:
			begin
				Datapath_clk=1;
				next_state=SEND;
			end
			
			PAP2:
			begin
				Datapath_clk=0;
				next_state=SEND;
			end
			
			CONT: 
			begin
				Datapath_clk=~Datapath_clk;
				tx_write=0;
				tx_bus=0;
				
				if(dp_halt==1)
				begin
					next_state=SEND;
				end
				else
				begin
					next_state=CONT;
				end
			end
			
			
			
			SEND: 
			begin

				tx_bus = dp_bus[contador*8 +: 8];

				if(dp_halt==1)
				begin
					if(contador!=BYTES)
					begin
						next_state=SENDING;
						tx_write=1;
						contador=contador+1;
					end
					else
					begin
						next_state=FIN;
						tx_write=0;
					end
				end
				else
					if(contador!=BYTES)
						begin 
							contador=contador+1;
							next_state=SENDING;
							tx_write=1;
						end
					else
						begin
						next_state=IDLE;
						tx_write=0;
						end
			end
			
			SENDING:
			begin
				tx_write=0;
				if(tx_done==1)
				begin
					next_state=SEND;
				end
				else
				next_state=SENDING;
			end
			
			FIN: 
			begin
				next_state=FIN;
				contador=0;
			end
			
			default: 
			begin
				next_state=FIN;
				contador=0;
			end
			
		endcase
		current_state<=next_state;
	end


endmodule
