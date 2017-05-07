`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang
// 
// Create Date:    21:07:31 05/06/2017 
// Design Name: 
// Module Name:    C:/Users/JasonLess/Documents/Lab/lab2_completed/preexp_and_presig.v
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
module preexp_and_presig(
  //Inputs
  converted_sig,
  //Outputs
  pre_exp, presignificand
  );
  
  input [11:0] converted_sig;
  output [2:0] pre_exp;
  output [4:0] presignificand;
  
  // Temp variables to assign values to output wires via regs
  reg [2:0] temp_pre_exp;
  reg [4:0] temp_presignificand;
  reg [3:0] four_bit_converted_sig;
  reg [11:0] pre_truncate;
  // Temp variables to count leading zeros
  // And calculate shift value
  reg [3:0] num_zeros;
  reg [2:0] shift_value;
  
  always @ (*) begin
      temp_pre_exp = 0;
		temp_presignificand = 0;
		num_zeros = 0;
		shift_value = 0;
      if (converted_sig[11] == 0) begin
			num_zeros = num_zeros + 1;
			if (converted_sig[10] == 0) begin
				num_zeros = num_zeros + 1;
				if (converted_sig[9] == 0) begin
					num_zeros = num_zeros + 1;
					if (converted_sig[8] == 0) begin
						num_zeros = num_zeros + 1;
						if (converted_sig[7] == 0) begin
							num_zeros = num_zeros + 1;
							if (converted_sig[6] == 0) begin
								num_zeros = num_zeros + 1;
								if (converted_sig[5] == 0) begin
									num_zeros = num_zeros + 1;
									if (converted_sig[4] == 0) begin
										num_zeros = num_zeros + 1;
										end
								   end
								end
							end
						end
					end
				end
			end
		
		if (num_zeros >= 8) begin
			num_zeros = 8;
		end
		
		//5 is the size of the presignificand
		shift_value = 12 - (num_zeros + 5);
		if (num_zeros == 8) begin
			four_bit_converted_sig = converted_sig[3:0];
			temp_presignificand = {four_bit_converted_sig, 1'b0};
		end
		else begin
			pre_truncate = converted_sig >> shift_value;
			temp_presignificand = pre_truncate[4:0];
		end
	   temp_pre_exp = 8 - num_zeros;
	end
  
	assign pre_exp = temp_pre_exp;
	assign presignificand = temp_presignificand;
	
endmodule