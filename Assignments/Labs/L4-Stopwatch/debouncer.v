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
// TODO: Check if debouncer_metastability module works (lower frequency sampling, and use of shift register version)
// TODO: pause button not working correctly. To pause, hold down hard. To unpause, short tap, but press hard
// TODO: Do we debounce the switches too? or just the buttons?
module debouncer(
  //Inputs
  clk, button, 
  //Outputs
  bounce_state
  );

  input clk;
  input button;
  
  output bounce_state;
  
  reg debounce_temp;
  reg [15:0] counter;

  reg sync_to_clk0;
  reg sync_to_clk1;

  always @ (posedge clk) begin
    sync_to_clk0 <= button;
  end
  always @ (posedge clk) begin
    sync_to_clk1 <= sync_to_clk0;
  end


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
