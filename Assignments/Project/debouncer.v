`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang 
// 
// Create Date:    21:08:17 05/06/2017 
// Design Name: 
// Module Name:    C:/Users/JasonLess/Documents/
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
module debouncer(
	//Inputs
   input wire clk, 
	input wire button, 
   //Outputs
   output wire bounce_state
   );
	
	// Temporary registers
		// Metastability purposes: sync to clock
	reg sync_to_clk0;
	reg sync_to_clk1;
		// Debouncer purposes: use of counter, instead of shift register
   reg debounce_temp;
   reg [15:0] counter;

	// Metastability
	always @ (posedge clk) begin
		sync_to_clk0 <= button;
		sync_to_clk1 <= sync_to_clk0;
	end
	
	// Debouncing
   always @ (posedge clk) begin
		if (debounce_temp == sync_to_clk1) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1'b1;
			if (counter == 20) begin
				debounce_temp <= ~bounce_state;
			end
      end
	end
	
	assign bounce_state = debounce_temp;

endmodule 
