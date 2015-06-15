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
	input wire rx_done_tick,
	input wire tx_done_tick,
	input wire [7:0] rx_bus,
	
	//Entradas desde DataPath
	input [1375:0] DataPath_bus,
	 
	//Salidas para DataPath
	output reg Datapath_clk,
	output reg Datapath_reset,
	 
	//Salidas para UART
	output reg tx_start,
	output wire [7:0] tx_bus
	);
	 
	reg [1375:0] datos = 0;
	//reg [7:0] contador = 0;
	//reg [5:0] contador_fin = 0;

   parameter IDLE = 4'b0001;
	parameter PAP = 4'b0010;
	parameter CONT = 4'b0100;
	parameter FIN = 4'b1000;
	
	reg [3:0] estado = IDLE;

	always@(posedge clk)
	begin
		
		case (estado)
		
			IDLE: 
			begin

			end
			
			PAP: 
			begin
			
			end	
			
			CONT: 
			begin
			
			end
			
			FIN: 
			begin

			end

						
		endcase
	end


endmodule
