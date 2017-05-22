`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:56:56 05/21/2017
// Design Name:   clk_div
// Module Name:   C:/Users/JasonLess/Documents/Lab/lab3_notworking/clock_div_TB.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_div
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_div_TB;

	// Inputs
	reg sys_clk;
	reg rst;

	// Outputs
	reg onehz_clk;
	reg twohz_clk;
	reg fast_clk;
	reg blink_clk;

	// Instantiate the Unit Under Test (UUT)
	clk_div uut (
		.sys_clk(sys_clk), 
		.rst(rst), 
		.onehz_clk(onehz_clk), 
		.twohz_clk(twohz_clk), 
		.fast_clk(fast_clk), 
		.blink_clk(blink_clk)
	);

	initial begin
		// Initialize Inputs
		sys_clk = 0;
		onehz_clk = 0;
		twohz_clk = 0;
		fast_clk = 0;
		blink_clk = 0;
		#100;
	end
	
	always begin
		#10 sys_clk = ~sys_clk;
	end     
	always begin
		#5 onehz_clk = ~onehz_clk;
	end
	always begin
		#2.5 twohz_clk = ~twohz_clk;
	end
	always begin
		#1.25 blink_clk = ~blink_clk;
	end
	always begin
		#0.0125 fast_clk = ~fast_clk;
	end
	initial begin
		#1000;
		$finish;
	end
endmodule

