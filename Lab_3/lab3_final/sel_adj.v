`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:49 05/08/2017 
// Design Name: 
// Module Name:    sel_adj
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
module sel_adj(
	//Input
	adj, onehz_clk, twohz_clk,
	//Ouput
	which_clk
    );

	input adj;
	input onehz_clk;
	input twohz_clk;
	output which_clk;

	reg which_clk_temp;
	
	always @ (*) begin
		// Adjust Mode
		if (adj) begin
			which_clk_temp = twohz_clk;
		end
		// Normal Mode
		else begin
			which_clk_temp = onehz_clk;
		end
	end

	assign which_clk = which_clk_temp;

endmodule