`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:28:56 06/15/2015 
// Design Name: 
// Module Name:    TOP 
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
module TOP(
	input clk,
	input reset,
	input rx,
	output tx
    );
	 
// Instantiate UART
UART TOP_UART (
    .clk(clk), 
    .reset(reset), 
    .rd_uart(rd_uart), 
    .wr_uart(wr_uart), 
    .rx(rx), 
    .w_data(w_data), 
    .tx_full(tx_full), 
    .rx_empty(rx_empty), 
    .tx(tx), 
    .r_data(r_data)
    );



endmodule
