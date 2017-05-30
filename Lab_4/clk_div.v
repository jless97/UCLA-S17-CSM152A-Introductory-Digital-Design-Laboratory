`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:46 05/30/2017 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
	// Inputs
	input wire clk,		//master clock: 50MHz
	input wire rst,		//asynchronous reset
	// Outputs
	output wire dclk,		//pixel clock: 25MHz
	output wire gameclk	//game clock: 1000Hz (Not using right now, not gameclk lol)
	);

	// 1000 Hz clock
	// 50,000 clock cycles for fasthz_clk to go high and return to low
	// Thus, it takes half (i.e. 25,000) for gameclk to go high
	reg gameclk_temp;

	// 25 MHz Clock Implementation
	// 17-bit counter variable
	reg [17:0] q;
	reg [31:0] gameclk_count;
	
	// Clock divider --
	// Each bit in q is a clock signal that is
	// only a fraction of the master clock.
	always @(posedge clk or posedge rst)
	begin
		// reset condition
		if (rst == 1)
			q <= 0;
		// increment counter by one
		else
			q <= q + 1;
	end

	// Game (1000 Hz) Clock Implementation
	always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			gameclk_count <= 32'b0;
         gameclk_temp <= 1'b0;
      end
      else if (gameclk_count == 32'd25000 - 32'b1) begin
         gameclk_count <= 32'b0;
         gameclk_temp <= ~gameclk;
      end
      else begin
         gameclk_count <= gameclk_count + 32'b1;
         gameclk_temp <= gameclk;
		end
	end
	 
	// 50Mhz ÷ 2^1 = 25MHz
	assign dclk = q[1];
	assign gameclk = gameclk_temp;

	// 

endmodule