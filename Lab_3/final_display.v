`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:04:49 05/12/2017 
// Design Name: 
// Module Name:    final_display 
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
module final_display(
	// Inputs
	fast_clk, blink_clk, sel, adj, left_light, middleleft_light, middleright_light, right_light,
	// Outputs
	cathode_vec, anode_vec
    );
	 
	// Inputs and Outputs
	input fast_clk;
   	input blink_clk;
	input sel;
	input adj;
	input [6:0] left_light;
	input [6:0] middleleft_light;
	input [6:0] middleright_light;
	input [6:0] right_light;
	 
	output [6:0] cathode_vec;
	output [3:0] anode_vec;

	// Temp Variables

	reg [1:0] switch_segment = 2'b00;
	reg [6:0] cathode_vec_temp;
	reg [3:0] anode_vec_temp;
	
	always @ (posedge fast_clk) begin
		if (switch_segment == 0) begin
			switch_segment <= switch_segment + 2'b1;
			anode_vec_temp <= 4'b0111;
			// Adjust minutes (10's spot)
			if (adj && !sel) begin
				if (blink_clk) begin
					cathode_vec_temp <= left_light;
				end
				else begin
					cathode_vec_temp <= 7'b1111111;
				end
			end
			// If not Adjust Clock Mode, or adjusting seconds, minutes don't change
			else begin
				cathode_vec_temp <= left_light;
			end
		end
		else if (switch_segment == 1) begin
			switch_segment <= switch_segment + 2'b1;
			anode_vec_temp <= 4'b1011;
			// Adjust minutes (1's spot)
			if (adj && !sel) begin
				if (blink_clk) begin
					cathode_vec_temp <= middleleft_light;
				end
				else begin
					cathode_vec_temp <= 7'b1111111;
				end
			end
			// If not Adjust Clock Mode, or adjusting seconds, minutes don't change
			else begin
				cathode_vec_temp <= middleleft_light;
			end
		end 
		else if (switch_segment == 2) begin
			switch_segment <= switch_segment + 2'b1;
			anode_vec_temp <= 4'b1101;
			// Adjust seconds (10's spot)
			if (adj && sel) begin
				if (blink_clk) begin
					cathode_vec_temp <= middleright_light;
				end
				else begin
					cathode_vec_temp <= 7'b1111111;
				end
			end
			// If not Adjust Clock Mode, or adjusting minutes, seconds don't change
			else begin
				cathode_vec_temp <= middleright_light;
			end
		end 
		else if (switch_segment == 3) begin
			switch_segment <= 2'b0;
			anode_vec_temp <= 4'b1110;
			// Adjust seconds (1's spot)
			if (adj && sel) begin
				if (blink_clk) begin
					cathode_vec_temp <= right_light;
				end
				else begin
					cathode_vec_temp <= 7'b1111111;
				end
			end
			// If not Adjust Clock Mode, or adjusting minutes, seconds don't change
			else begin
				cathode_vec_temp <= right_light;
			end
		end
	end

	assign cathode_vec = cathode_vec_temp;
	assign anode_vec = anode_vec_temp;
	
endmodule
