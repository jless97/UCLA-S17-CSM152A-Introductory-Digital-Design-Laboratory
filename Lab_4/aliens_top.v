`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:29 05/31/2017 
// Design Name: 
// Module Name:    aliens_top 
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
module aliens_top(
	// Inputs
	input wire clk,
	input wire rst,
	input wire mode,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	input wire [4:0] aliens,
	// Outputs
	output wire [40:0] rgb_aliens,
	output wire [4:0] is_alien
    );

	// Wires
		// Directions
	wire move_left;
	wire move_right;
	wire move_down;
		// Status
	wire is_edge_top;
	wire is_bottom_top;
	wire is_hit_top;
	 
	 	// Check mode (can do this in aliens module)

	// Check alien direction (i.e. start move right, if isEdge, then move down, switch direction)
	assign is_edge_top = (is_edge[0] & is_edge[1] & is_edge[2] & is_edge[3]);
		
	reg move_left_temp, move_right_temp, move_down_temp;
	always @ (posedge clk) begin
		if (is_edge_top) begin
			move_left_temp = ~move_left;
			move_right_temp = ~move_right;
			move_down_temp = ~move_down;
		end
	end
	
	assign move_left = move_left_temp;
	assign move_right = move_right_temp;
	assign move_down = move_down_temp;
	
	// Check game status (i.e. if isBottom, remove a life from the player)
	reg temp;
	assign is_bottom_top = (is_bottom[0] & is_bottom[1] & is_bottom[2] & is_bottom[3]);
//	always @ (posedge clk) begin
//		if (is_bottom_top) begin
//			temp = 3;
//		end
//	end
//	
//	assign mode = temp;
	
	// Check alien status (i.e. if isHit, then turn off the ability to hit edge and to hit bottom, set pixels to 0)
	assign is_hit_top = (is_hit[0] & is_hit[1] & is_hit[2] & is_hit[3]);
	 
	// Instantiate the alien objects
	// Instantiate the alien objects
	wire [4:0] is_edge;
	wire [4:0] is_bottom;
	wire [4:0] is_hit;
	aliens update_alien_0(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[7:0]),
		.is_alien(is_alien[0]),
		.is_edge(is_edge[0]),
		.is_bottom(is_bottom[0]),
		.is_hit(is_hit[0])
		);
	


endmodule 
