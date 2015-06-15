`timescale 1ns / 1ps

module tester(
	 input clock,
    input [7:0] r_data,
    input rx_empty,
    output reg rd_uart,
    output reg [7:0] t_data,
    output reg tx_done
    );

initial
begin
rd_uart=0;
tx_done=0;

end

always@(posedge clock)

	if(rx_empty)
	begin
	t_data=r_data+1;
	rd_uart=1;
	tx_done=1;
	end
	else
	begin
	rd_uart=0;
	tx_done=0;
	end

endmodule

