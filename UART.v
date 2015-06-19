`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:12:48 06/15/2015 
// Design Name: 
// Module Name:    UART 
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

module UART
  (
    input wire clk, rst,
    input wire rx, 
    input wire [7:0] w_data,
	 input wire write_enable,
    output wire tx,
	 output [7:0] rx_data,
	 output rx_data_rdy
    //output wire [7:0] led
  );
  
	//Registros
	reg [7:0] fifo_din = 5;
	reg fifo_wr_en=0;
	reg fifo_reset=0;
  
  	//Wires
	//wire clk;
	wire fifo_full;
	wire fifo_empty;
	wire [7:0] fifo_out;
	wire [7:0] rx_data;
	
	
	//Uart TX
	
	uart_tx UART_tx(
	  .clk_tx(clk),          			// Clock input
	  .rst_clk_tx(1'b0),      			// Active HIGH reset - synchronous to clk_tx
	  .char_fifo_empty(fifo_empty), 	// Empty signal from char FIFO (FWFT)
	  .char_fifo_dout(fifo_out),  		// Data from the char FIFO
	  .char_fifo_rd_en(tx_done), 		// Pop signal to the char FIFO
	  .txd_tx(tx)           		// The transmit serial signal
	);

	//Fifo
	
	fifo UART_fifo(
	  .clk(clk),
	  .rst(1'b0),
	  .din(w_data),
	  .wr_en(write_enable),
	  .rd_en(tx_done),
	  .dout(fifo_out),
	  .full(fifo_full),
	  .empty(fifo_empty)
	);

		
	//Uart RX
	
	uart_rx UART_rx(
		.clk_rx(clk),
		.rst_clk_rx(1'b0),
		.rxd_i(rx),
		.rx_data(rx_data),
		.rx_data_rdy(rx_data_rdy)
	);	
 
endmodule
