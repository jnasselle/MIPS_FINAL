`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:30:20 06/19/2015 
// Design Name: 
// Module Name:    uart_rx 
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


module uart_rx (
  // Write side inputs
  input            clk_rx,       // Clock input
  input            rst_clk_rx,   // Active HIGH reset - synchronous to clk_rx

  input            rxd_i,        // RS232 RXD pin - Directly from pad

  output     [7:0] rx_data,      // 8 bit data output
                                 //  - valid when rx_data_rdy is asserted
  output           rx_data_rdy,  // Ready signal for rx_data
  output           frm_err       // The STOP bit was not detected
);


//***************************************************************************
// Parameter definitions
//***************************************************************************

  parameter BAUD_RATE    = 14400;             // Baud rate 2400
  parameter CLOCK_RATE   = 3_125_000;

//***************************************************************************
// Reg declarations
//***************************************************************************

//***************************************************************************
// Wire declarations
//***************************************************************************

  wire             rxd_clk_rx;   // RXD pin, synchronized to clk_rx

  wire             baud_x16_en;  // 1-in-N enable for uart_rx_ctl FFs
  
//***************************************************************************
// Code
//***************************************************************************

  /* Synchronize the RXD pin to the clk_rx clock domain. Since RXD changes
  * very slowly wrt. the sampling clock, a simple metastability hardener is
  * sufficient */
  meta_harden meta_harden_rxd_i0 (
    .clk_dst      (clk_rx),
    .rst_dst      (rst_clk_rx), 
    .signal_src   (rxd_i),
    .signal_dst   (rxd_clk_rx)
  );

  uart_baud_gen #
  ( .BAUD_RATE  (BAUD_RATE),
    .CLOCK_RATE (CLOCK_RATE)
  ) uart_baud_gen_rx_i0 (
    .clk         (clk_rx),
    .rst         (rst_clk_rx),
    .baud_x16_en (baud_x16_en)
  );

  uart_rx_ctl uart_rx_ctl_i0 (
    .clk_rx      (clk_rx),
    .rst_clk_rx  (rst_clk_rx),
    .baud_x16_en (baud_x16_en),

    .rxd_clk_rx  (rxd_clk_rx),
    
    .rx_data_rdy (rx_data_rdy),
    .rx_data     (rx_data),
    .frm_err     (frm_err)
  );

endmodule