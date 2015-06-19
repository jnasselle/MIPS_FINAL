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
	output tx
    );
	 
//Wires
wire TOP_write_enable;
	 
// Instantiate UART
UART TOP_UART (
    .clk(clk), 
    .rst(rst), 
    .rx(rx), 
    .w_data(w_data), 
    .write_enable(write_enable), 
    .tx(tx), 
    .rx_data(rx_data), 
    .rx_data_rdy(rx_data_rdy)
    );
	 
// Instantiate DebugUnit
DebugUnit TOP_DebugUnit (
    .clk(clk), 
    .rx_done_tick(rx_done_tick), 
    .rx_bus(rx_bus), 
    .DataPath_bus(DataPath_bus), 
    .Datapath_clk(Datapath_clk), 
    .Datapath_reset(Datapath_reset), 
    .tx_write(tx_write), 
    .tx_bus(tx_bus)
    );




endmodule
