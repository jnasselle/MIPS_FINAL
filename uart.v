`timescale 1ns / 1ps

module uart
  #(  // Configuración por defecto:
      // 38400 baudios (la placa tiene 100MHz), 8 bits de datos, 1 bit de stop
    parameter data_bits = 8,        // Bits de datos
              stop_bit_ticks = 16,  // Ticks para el bit de stop. 16/24/32 para 1/1,5/2 bits
              divisor = 163,        // Divisor para generar el Baudrate. divisor = 50M/(16*baudrate)
              divisor_bits = 8     // Bits del divisor
   )
  (
    input wire clk, rst,
    input wire rx, 
    input wire [7:0] w_data,
	 input wire tx_start,
    output wire tx,
    output wire [7:0] r_data,
	 output wire rx_done,
	 output wire tx_done
  );
  
	// Declaración de señales
	wire tick;
	wire [7:0] rx_data_out, tx_data_in;
	wire [7:0] rx_buf_out, t_data, tx_buf_out;

  
	// Cuerpo
	mod_m_counter 
	#(.M(divisor), .N(divisor_bits))
	baud_gen_unit
	(.clk(clk), .reset(rst), .q(), .max_tick(tick));
    
	uart_rx 
	#(.data_bits(data_bits), .stop_bit_ticks(stop_bit_ticks)) 
	uart_rx_unit
	(.clock(clk), .reset(rst), .rx(rx), .s_tick(tick), .rx_done_tick(rx_done), .data_out(r_data));

	uart_tx 
	#(.data_bits(data_bits), .stop_bit_ticks(stop_bit_ticks)) 
	uart_tx_unit
	(.clock(clk), .reset(rst), .s_tick(tick), .tx_start(tx_start), .tx_done_tick(tx_done), .data_in(8'b1100001), .tx(tx));

/*
					
  flag_buf
  flag_buf_rx
	(.clock(clk), .reset(rst), .clr_flag(rd_uart), .set_flag(rx_done_tick), .din(rx_data_out), .dout(rx_buf_out), .flag(rx_empty));
					
  flag_buf
  flag_buf_tx
	(.clock(clk), .reset(rst), .clr_flag(tx_done_tick), .set_flag(tx_done), .din(t_data), .dout(tx_buf_out), .flag(tx_start));


  tester
  tester_unit
   (.clock(clk), .r_data(rx_buf_out), .rx_empty(rx_empty), .rd_uart(rd_uart), .tx_done(tx_done), .t_data(t_data));
*/
 

assign led = rx_data_out;
 
endmodule
