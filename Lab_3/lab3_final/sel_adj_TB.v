`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:16:21 05/22/2017
// Design Name:   sel_adj
// Module Name:   C:/Users/JasonLess/Documents/Lab/lab3_notworking/sel_adj_TB.v
// Project Name:  lab3_notworking
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sel_adj
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sel_adj_TB;

	// Inputs
	reg adj;
	reg onehz_clk;
	reg twohz_clk;

	// Outputs
	wire which_clk;

	// Instantiate the Unit Under Test (UUT)
	sel_adj uut (
		.adj(adj), 
		.onehz_clk(onehz_clk), 
		.twohz_clk(twohz_clk), 
		.which_clk(which_clk)
	);

	initial begin
		// Initialize Inputs
		adj = 0;
		onehz_clk = 0;
		twohz_clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

