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
	input rst,
	input rx,
	//input [1400:0] bus,
	//input halt,
	output tx
    );
	 
//Wires
wire TOP_tx_start;
wire TOP_rx_rdy;
wire TOP_rx_done;
wire TOP_tx_done;
wire [7:0] TOP_rx_data;
wire [7:0] TOP_tx_data;
wire TOP_halt;
wire [1400:0] TOP_DataPath_bus;
wire TOP_DataPath_clk;
	 
// Instantiate UART
uart TOP_uart(
    .clk(clk), 
    .rst(rst), 
    .rx(rx), 
    .w_data(TOP_tx_data), 
    .tx_start(TOP_tx_start), 
    .tx(tx), 
    .r_data(TOP_rx_data), 
    .rx_done(TOP_rx_done), 
    .tx_done(TOP_tx_done)
    );


DebugUnit TOP_DebugUnit (
    .clk(clk), 
    .rx_rdy(TOP_rx_done),
	 .tx_done(TOP_tx_done), 	 
    .rx_bus(TOP_rx_data), 
    .dp_bus(24'b011000010110001001100011), 
    .dp_halt(1'b0), 
    .Datapath_clk(Datapath_clk), 
    .tx_write(TOP_tx_start), 
    .tx_bus(TOP_tx_data)
    );
 



endmodule
