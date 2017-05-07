`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang
//
// Create Date:   22:09:12 04/24/2017
// Design Name:   Floating Point Converter
// Module Name:   C:/Users/JasonLess/Documents/Lab/lab2_completed/fp_converter_refactor_TB.v
// Project Name:  Floating Point Converter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fp_converter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fp_converter_TB_final;

	// Inputs
	reg [11:0] linear_enc_sign;

	// Outputs
	wire sign;
	wire [2:0] exp;
	wire [3:0] significand;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(linear_enc_sign), 
		.S(sign), 
		.E(exp), 
		.F(significand)
	);

	initial begin
		// Initialize Inputs
		linear_enc_sign = 0; // 0
		// Wait 100 ns for global reset to finish
		#20;
		linear_enc_sign = 1;
		#20;
		linear_enc_sign = 12'b000111110000;
		#20;
		linear_enc_sign = 10; // 10
		#20;
		linear_enc_sign = 20; // 20 
		#20;
      linear_enc_sign = 30; // 30
		#20;
		linear_enc_sign = 40; // 40
		#20;
		linear_enc_sign = 55; // 56
		#20;
		linear_enc_sign = 100; // 104
		#20;
		linear_enc_sign = 422; // 416
		#20;
		linear_enc_sign = 416; // 416
		#20;
		linear_enc_sign = 0; // 0
		#20;
		linear_enc_sign = -40; // -40
		#20;
		linear_enc_sign = 56; // 56
		#20;
		linear_enc_sign = 125; // 128
		#20;
		linear_enc_sign = 128; // 128
		#20;
		linear_enc_sign = 2047; // 1920
		#20;
		linear_enc_sign = -2048; // -1920
		#20;
	end
      
endmodule

