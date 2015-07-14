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
wire [1623:0] TOP_DataPath_bus;
wire TOP_DataPath_clk;


wire [1023:0] du_reg;
wire [255:0] du_mem;
wire [63:0] du_if_id;
wire [126:0] du_id_ex;
wire [76:0] du_ex_mem;
wire [71:0] du_mem_wb;

assign TOP_DataPath_bus = {
	du_reg,
	du_mem,
	du_if_id,
	du_id_ex,
	du_ex_mem,
	du_mem_wb,
	4'b0
};
	 
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
    .dp_bus(TOP_DataPath_bus), 
    .dp_halt(TOP_halt), 
    .Datapath_clk(TOP_DataPath_clk), 
    .tx_write(TOP_tx_start), 
    .tx_bus(TOP_tx_data)
    );
 
DataPath TOP_DataPath (
    .clk(TOP_DataPath_clk), 
    .reset(rst), 
    .du_reg(du_reg), 
    .du_mem(du_mem), 
    .du_if_id(du_if_id), 
    .du_id_ex(du_id_ex), 
    .du_ex_mem(du_ex_mem), 
    .du_mem_wb(du_mem_wb), 
    .du_halt(TOP_halt)
    );



endmodule
