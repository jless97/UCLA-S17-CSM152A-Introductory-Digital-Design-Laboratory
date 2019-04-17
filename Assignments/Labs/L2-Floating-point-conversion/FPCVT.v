`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang
// 
// Create Date:    21:05:02 05/06/2017 
// Design Name: 	 Floating Point Converter
// Module Name:    C:/Users/JasonLess/Documents/Lab/lab2_completed/FPCVT.v
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
module FPCVT (
   // Inputs
   D,
   // Outputs
   S, E, F
   );

   // Final inputs and outputs
   input wire [11:0] D;
   output wire S;
   output wire [2:0] E;
   output wire [3:0] F;
   
	// Set sign to the sign bit of the input value
	assign S = D[11];
 
	// Temp variable for sign_mag_converter
   wire [11:0] converted_sig;
	
   //Convert 2's complement to SM (if necessary)
   sign_mag_converter get_sign_mag(
	  // Inputs
	 .linear_enc_sign(D), 
	 .sign(S),
	 // Output
    .conv_sig(converted_sig)
   );
  
   // Temp variables for preexp_and_presig
   wire [4:0] presignificand;
   wire [2:0] pre_exp;
	
	// Obtain the significant and exponent before changes
   preexp_and_presig extract_data(
	 //Inputs
    .converted_sig(converted_sig),
    //Outputs
    .presignificand(presignificand), 
	 .pre_exp(pre_exp)
	);

	//Round (if necessary), and obtain final significand and exp
   round_data final_output(
	 //Inputs
    .presignificand(presignificand), 
	 .pre_exp(pre_exp),
    //Outputs
    .significand(F), 
	 .exp(E)
    );

endmodule
