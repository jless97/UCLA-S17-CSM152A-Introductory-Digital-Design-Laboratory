`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:29:03 05/21/2017
// Design Name:   counter
// Module Name:   C:/Users/JasonLess/Documents/Lab/lab3_notworking/counter_TB.v
// Project Name:  lab3_notworking
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_TB;

	// Inputs
	reg onehz_clk;
	reg twohz_clk;
	reg pause;
	reg rst;
	reg sel;
	reg adj;

	// Outputs
	wire [5:0] minutes;
	wire [5:0] seconds;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.onehz_clk(onehz_clk), 
		.twohz_clk(twohz_clk), 
		.pause(pause), 
		.rst(rst), 
		.sel(sel), 
		.adj(adj), 
		.minutes(minutes), 
		.seconds(seconds)
	);

	initial begin
		// Initialize Inputs
		onehz_clk = 0;
		twohz_clk = 0;
		pause = 0;
		rst = 0;
		sel = 0;
		adj = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
	end
	always begin
		#10 onehz_clk = ~onehz_clk;
	end
	always begin
		#5 twohz_clk = ~twohz_clk;
	end
	initial begin
		adj = 0;
		#100
		// adjust minutes
		adj = 1;
		sel = 0;
		#200
		// adjust seconds
		adj = 1;
		sel = 1;
		#300
		// reset values
		rst = 1;
		#400
		// unreset
		rst = 0;
		#500
		// pause vaues
		pause = 1;
		#600
		// unpause values
		pause = 0;
		#700
		adj = 1; 
		sel = 0;
		
		#1000;
		$finish;
		
	end
      
endmodule

