`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:25 03/04/2015 
// Design Name: 
// Module Name:    Extension 
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
module Extension( input [15:0] data_in,
	input [31:0] data_out,
	input tipo	//TRUE=>Con Signo,FALSE=>Sin Signo
    );
	assign data_out= tipo?{{16{data_in[15]}}, data_in}:{{16{0}}, data_in};

endmodule

