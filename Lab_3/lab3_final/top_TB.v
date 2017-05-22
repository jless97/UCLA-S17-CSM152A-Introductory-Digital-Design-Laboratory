`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:08:26 05/22/2017
// Design Name:   top
// Module Name:   C:/Users/JasonLess/Documents/Lab/lab3_notworking/top_TB.v
// Project Name:  lab3_notworking
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_TB;

	// Inputs
	reg sel;
	reg adj;
	reg rst;
	reg pause;
	reg clk;

	// Outputs
	wire [3:0] anode_vec;
	wire [6:0] cathode_vec;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.sel(sel), 
		.adj(adj), 
		.rst(rst), 
		.pause(pause), 
		.clk(clk), 
		.anode_vec(anode_vec), 
		.cathode_vec(cathode_vec)
	);

	initial begin
		// Initialize Inputs
		sel = 0;
		adj = 0;
		rst = 0;
		pause = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always begin
		#10 clk = ~clk;
   end
	
	initial begin
		adj = 0;
		#100
		adj = 1;
		sel = 0;
		#200
		adj = 1;
		sel = 1;
		#300
		adj = 0;
		sel = 0;
		pause = 1;
		#400
		pause = 0;
		rst = 1;
		#500
		rst = 0;
		#1000;
		$finish;
	end	
endmodule

