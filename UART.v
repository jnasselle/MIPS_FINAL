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
  
  
  	//Wires
	//wire clk;
	wire fifo_full;

	

	//Bloque testeado
	reg debugMode,debugClk;
	reg [31:0] DebugAddress=-1;
	wire [31:0]instruction,Read_Data_2_MEM,instructionID,Read_Data_1_ID,Read_Data_2_ID,Read_data_MEM,Read_data_WB,ALU_result_WB,ALU_result_EX,ALU_result_MEM;
	reg clkPipe = 0;
	wire [31:0] reg_array0,reg_array1,reg_array2,reg_array3,reg_array4,reg_array5,reg_array6,reg_array7,reg_array8,reg_array9;
	wire [31:0] reg_array10,reg_array11,reg_array12,reg_array13,reg_array14,reg_array15,reg_array16,reg_array17,reg_array18,reg_array19;
	wire [31:0] reg_array20,reg_array21,reg_array22,reg_array23,reg_array24,reg_array25,reg_array26,reg_array27,reg_array28,reg_array29;
	wire [31:0] reg_array30,reg_array31,PC_sumado_EX,Read_Data_1_EX,Read_Data_2_EX,instruction_EX;
	wire RegDest_ID,BranchEQ_ID,BranchNE_ID,MemRead_ID,MemToReg_ID,ALUOp1_ID,ALUOp2_ID,MemWrite_ID;
	wire ALUSrc_ID,RegWrite_ID,ShiftToTrunk_ID,RegDest_EX,BranchEQ_EX,BranchNE_EX,MemRead_EX,MemToReg_EX;
	wire MemWrite_EX,ALUSrc_EX,RegWrite_EX,Jump_EX;
	wire [1:0] trunkMode_ID,trunkMode_EX;
	wire ShiftToTrunk_EX,Zero_EX,BranchEQ_MEM,BranchNE_MEM,MemRead_MEM,MemToReg_MEM,MemWrite_MEM,RegWrite_MEM;
	wire [4:0] Write_register_EX,Write_register_MEM,Write_register_WB;
	wire Jump_MEM,Zero_MEM,MemToReg_WB,RegWrite_WB,BranchTaken,Jump_ID,IF_Flush,forwardA;
	wire savePc_ID,savePc_EX,savePc_MEM,savePc_WB,JReg_ID;
	
	wire fifo_empty;
	wire [7:0] fifo_out;
	
	
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
	
	reg [7:0] fifo_din = 5;
	reg fifo_wr_en=0;
	reg fifo_reset=0;
	
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
	wire [7:0] rx_data;
	uart_rx UART_rx(
		.clk_rx(clk),
		.rst_clk_rx(1'b0),
		.rxd_i(rx),
		.rx_data(rx_data),
		.rx_data_rdy(rx_data_rdy)
	);	
 
endmodule
