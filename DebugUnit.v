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
	//input wire tx_done_tick,
	input wire [7:0] rx_bus,
	
	//Entradas desde DataPath
	input [1375:0] DataPath_bus,
	input halt_in,
	 
	//Salidas para DataPath
	output reg Datapath_clk,
	//output reg Datapath_reset,
	 
	//Salidas para UART
	output reg tx_write,		//WR para que mande a la cola el nuevo daato
	output wire [7:0] tx_bus
	);
	 
	reg [1375:0] datos = 0;
	reg [7:0] contador = 0;
	//reg [5:0] contador_fin = 0;

   parameter IDLE = 5'b00001;
	parameter PAP = 5'b00010;
	parameter CONT = 5'b00100;
	parameter SEND = 5'b01000
	parameter FIN = 5'b10000;
	
	reg [4:0] state = IDLE;
	reg [4:0] next_state = IDLE;

	always@(posedge clk)
	begin
		
		case (state)
		
			IDLE: 
			begin
				if(rx_rdy==1)
					begin
						if(rx_bus==1)
							next_state=PAP;
						else
							next_state=CONT;
					end
				 else
					next_state=IDLE;
			end
			
			PAP: 
			begin
				next_state=SEND;
				Datapath_clk=1;
			end	
			
			CONT: 
			begin
				if(halt_in==1)
					begin
						next_state=SEND;
					end
				else
					begin
						next_state=CONT;
						Datapath_clk=~Datapath_clk;
					end
			end
			
			SEND: 
			begin
				if(halt_in==1)
					if(contador!=175)
						begin 
							next_state=SEND;
							tx_write=1;
							tx_bus=8'b11111111; //case
						end
					else
						next_state=FIN;
				else
					if(contador!=175)
						begin 
							next_state=SEND;
							tx_write=1;
							tx_bus=8'b11111111; //case
						end
					else
						next_state=IDLE;					
			end
			
			FIN: 
			begin
				next_state=FIN;
			end

						
		endcase
	end


endmodule
