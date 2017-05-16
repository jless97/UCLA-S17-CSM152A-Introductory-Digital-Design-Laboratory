`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:21 05/03/2017 
// Design Name: 
// Module Name:    counter 
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
module counter(
	//Inputs
	onehz_clk, twohz_clk, pause, rst, sel, adj,
	//Outputs
	minutes, seconds
    );

	// Inputs and Outputs
	input onehz_clk;
	input twohz_clk;
	input pause;
	input rst;
	input sel;
	input adj;
	output [5:0] minutes;
	output [5:0] seconds;

	// Temp variables
	reg [5:0] minutes_temp = 5'b00000;
	reg [5:0] seconds_temp = 5'b00000;
	reg is_pause = 0;
	
   sel_adj adjust(.adj(adj), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .which_clk(clk));
	
	always @ (posedge pause) begin
        is_pause <= ~is_pause;
    end
	always @ (posedge clk or posedge rst) begin
		// Reset 
		if (rst) begin
			minutes_temp <= 5'b0;
			seconds_temp <= 5'b0;
		end
		// Not reset (Clock mode)
		else begin
		if (~is_pause) begin
			minutes_temp <= minutes;
			seconds_temp <= seconds;
			// Adjust Clock Mode
			if (adj) begin
				// Adjust seconds, freeze minutes
				if (sel) begin
					// If max seconds, then reset seconds
					if (seconds_temp == 59) begin
						seconds_temp <= 5'b0;
					end
					// No overflow in seconds, so increment seconds
					else begin
						seconds_temp <= seconds_temp + 5'b1;
					end
				end
				// Adjust minutes, freeze seconds
				else begin
					// If max minutes, then reset minutes
					if (minutes_temp == 59) begin
						minutes_temp <= 5'b0;
					end
					// No overflow in minutes, so increment minutes
					else begin
						minutes_temp <= minutes_temp + 5'b1;
					end
				end
			end
			// Normal Clock Mode
			else begin
                // If max stopwatch time, then reset both minutes and seconds
                if (minutes_temp == 59 && seconds_temp == 59) begin
                    minutes_temp <= 5'b0;
                    seconds_temp <= 5'b0;
                end
                // If max seconds, then reset seconds, increment minutes
                else if (minutes_temp != 59 && seconds_temp == 59) begin
                    minutes_temp <= minutes_temp + 5'b1;
                    seconds_temp <= 5'b0;
                end
                // No overflow in minutes or seconds, so increment seconds
                else begin
                    seconds_temp <= seconds_temp + 5'b1;
                end
			end
		end
		end
	end

	assign minutes = minutes_temp;
	assign seconds = seconds_temp;

endmodule
