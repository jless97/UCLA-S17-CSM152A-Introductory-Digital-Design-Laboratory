`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:54 05/31/2017 
// Design Name: 
// Module Name:    scoreboard 
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
module scoreboard(
	// Inputs
	input wire clk,
	input wire rst,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	input wire [20:0] score,
	// Outputs
	output wire [7:0] rgb
    );

   reg [7:0] set_color;
   reg [10:0] temp;
   reg [3:0] dig_6;
   reg [3:0] dig_5;
   reg [3:0] dig_4;
   reg [3:0] dig_3;
   reg [3:0] dig_2;
   reg [3:0] dig_1;

   parameter D6_X_START = 11'd2;
   parameter D6_X_END = 11'd14;
   parameter D_Y_START = 11'd23;
   parameter D_Y_MID = 11'd30;
   parameter D_Y_END = 11'd38;
   parameter D5_X_START = 11'd16;
   parameter D5_X_END = 11'd28;
   parameter D4_X_START = 11'd30;
   parameter D4_X_END = 11'd42;
   parameter D3_X_START = 11'd44;
   parameter D3_X_END = 11'd56;
   parameter D2_X_START = 11'd58;
   parameter D2_X_END = 11'd70;
   parameter D1_X_START = 11'd72;
   parameter D1_X_END = 11'd84;
   parameter COLOR_BLACK = 8'b00000000;
   parameter COLOR_WHITE = 8'b11111111;

   
   
   assign dig_6 = score/100000;
   assign temp = score-dig_6*100000;
   assign dig_5 = temp/10000;
   assign temp = score-dig_5*10000;
   assign dig_4 = temp/1000;
   assign temp = score-dig_4*1000;
   assign dig_3 = temp/100;
   assign temp = score-dig_3*100;
   assign dig_2 = temp/10;
   assign temp = score-dig_2*10;
   assign dig_1 = temp;
   
   always @ (posedge clk) begin
      if(yCoord >= D_Y_START && yCoord <= D_Y_END) begin
	 if(xCoord >= D6_X_START && xCoord <= D6_X_END) begin
	    if(dig_6 == 0) begin
	       if(
		  (xCoord >= D6_X_START + 2 && xCoord <= D6_X_END - 2 && yCoord >= D_Y_START && yCoord < D_Y_START + 2) ||
		  (xCoord >= D6_X_START + 2 && xCoord <= D6_X_END - 2 && yCoord > D_Y_END - 2 && yCoord <= D_Y_END) ||
		  (xCoord >= D6_X_START && xCoord < D6_X_START + 2 && yCoord > D_Y_START + 2 && yCoord < D_Y_END - 2) ||
		  (xCoord > D6_X_END - 2 && xCoord <= D6_X_END && yCoord > D_Y_START + 2 && yCoord < D_Y_END - 2)
		  ) begin
		  assign set_color <= COLOR_WHITE;
		  end
	       else begin
		 assign set_color <= COLOR_BLACK;
		  end
	    end // if (dig_6 == 0)
	    if(dig_6 == 1) begin
	       if(
		  (xCoord >= D6_X_END - 2 && xCoord <= D6_X_END) ||
		  (xCoord >= D6_X_END - 4 && yCoord <= D_Y_START + 2)
		  ) begin
		  assign set_color <= COLOR_WHITE;
	       end
	       else begin
		  assign set_color <= COLOR_BLACK;
		  end
	    end // if (dig_6 == 1)
	    if(dig_6 == 2) begin
	       if(
		  (xCoord >= D6_X_START && xCoord <= D6_X_END - 2 && yCoord >= D_Y_START && yCoord < D_Y_START + 2) ||
		  (xCoord > D6_X_END - 2 && xCoord <= D6_X_END && yCoord >= D_Y_START + 2 && yCoord <= D_Y_MID + 1) ||
		  (xCoord >= D6_X_START + 2 && xCoord <= D6_X_END && yCoord >= D_Y_MID && yCoord <= D_Y_MID + 1) ||
		  (xCoord >= D6_X_START && xCoord < D6_X_START + 2 && yCoord > D_Y_MID + 1 && yCoord <= D_Y_END) ||
		  (xCoord >= D6_X_START && xCoord <= D6_X_END && yCoord > D_Y_END - 2 && yCoord <= D_Y_END)
		  ) begin
		  assign set_color <= COLOR_WHITE;
	       end
	       else begin
		  assign set_color <= COLOR_BLACK;
	       end // else: !if(...
	    end // if (dig_6 == 2)
	    if(dig_6 == 3) begin
	       if(
		  (xCoord >= D6_X_START && xCoord <= D6_X_END - 2 && yCoord >= D_Y_START && yCoord < D_Y_START + 2) ||
		  (xCoord > D6_X_END - 2 && xCoord <= D6_X_END && yCoord >= D_Y_START + 2 && yCoord <= D_Y_END - 2) ||
		  (xCoord >= D6_X_START + 2 && xCoord <= D6_X_END && yCoord >= D_Y_MID && yCoord <= D_Y_MID + 1) ||
		  (xCoord >= D6_X_START && xCoord <= D6_X_END - 2 && yCoord > D_Y_END - 2 && yCoord <= D_Y_END)
		  ) begin
		  assign set_color <= COLOR_WHITE;
	       end
	       else begin
		  assign set_color <= COLOR_BLACK;
	       end // else: !if(...
	    end // if (dig_6 == 3)
	 end
      end
   end
   
   assign rgb = set_color;
   
endmodule
