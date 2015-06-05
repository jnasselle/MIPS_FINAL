`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:22 03/10/2015 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	input le,
	input reset,
	input clear,
	input enable,
	input [31:0] instruccionIn,
	input [31:0] PC4In,	//PC+4
	output reg [31:0] instruccionOut,
	output reg [31:0] PC4Out
    );

always@ (*)	//Latch - Falta Clear y Enable
begin
	if (reset == 1)
		begin
		instruccionOut<=0;	//Ver si es cero 0 y si no hay que borrar PC4In
		PC4Out<=0;
		end
	else if (!le)
		begin
		if(clear == 1)
			begin
			instruccionOut<=0;
			PC4Out<= PC4In;
			end
		else
			begin
			instruccionOut<=instruccionIn;
			PC4Out<= PC4In;
			end
		
		end 
end


endmodule
