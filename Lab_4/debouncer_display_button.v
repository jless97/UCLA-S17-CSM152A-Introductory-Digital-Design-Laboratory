`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:59 05/31/2017 
// Design Name: 
// Module Name:    debouncer_display_button 
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
// Display button (laggy in the testing lab) (increase debounce state)
module debouncer_display_button(
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
			if (counter == 16'hffff) begin
				debounce_temp <= ~bounce_state;
			end
      end
	end
	
	assign bounce_state = debounce_temp;

endmodule 

