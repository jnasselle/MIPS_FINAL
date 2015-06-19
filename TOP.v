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
	input [1400:0] bus,
	input halt,
	output tx
    );
	 
//Wires
wire TOP_write_enable;
wire TOP_rx_rdy;
wire [7:0] TOP_rx_data;
wire [7:0] TOP_tx_data;
wire TOP_halt;
wire [1400:0] TOP_DataPath_bus;
wire TOP_clk_DataPath;
	 
// Instantiate UART
UART TOP_UART (
    .clk(clk), 
    .rst(rst), 
    .rx(rx), 
    .w_data(TOP_tx_data), 
    .write_enable(TOP_write_enable), 
    .tx(tx), 
    .rx_data(TOP_rx_data), 
    .rx_data_rdy(TOP_rx_rdy)
    );
	 
// Instantiate DebugUnit
DebugUnit instance_name (
    .clk(clk), 
    .rx_rdy(TOP_rx_rdy), 
    .rx_bus(TOP_rx_data), 
    .DataPath_bus(bus), 
    .halt_in(halt), 
    .Datapath_clk(Datapath_clk), 
    .tx_write(TOP_write_enable), 
    .tx_bus(TOP_tx_data)
    );




endmodule
