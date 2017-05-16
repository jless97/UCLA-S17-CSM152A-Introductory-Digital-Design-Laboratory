`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:21 05/03/2017 
// Design Name: 
// Module Name:    top 
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
module top(
	//Inputs
	sel, adj, rst, pause, clk,
	//Outputs
	anode_vec, cathode_vec
    );
	input sel;
	input adj;
	input rst;
	input pause;
	input clk;
	output [3:0] anode_vec;
	output [6:0] cathode_vec;

	//Signals internal ot the module
	wire rst_db;
	wire pause_db;
	wire sel_db;
	wire adj_db;
	
	wire onehz_clk;
	wire twohz_clk;
	wire fast_clk;
	wire blink_clk;
	
	//Debounce inputs (Buttons: pause, reset, Switches: select, adjust)
	debouncer pause_db_func(.clk(clk), .button(pause), .bounce_state(pause_db));
	debouncer rst_db_func(.clk(clk), .button(rst), .bounce_state(rst_db));
	debouncer sel_db_func(.clk(clk), .button(sel), .bounce_state(sel_db));
	debouncer adj_db_func(.clk(clk), .button(adj), .bounce_state(adj_db));
	
	//Divide clock into slower clocks to be passed to other modules
	clk_div clock_divider(.sys_clk(clk), .rst(rst_db), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .fast_clk(fast_clk), .blink_clk(blink_clk));

	//Main counting logic
	wire [5:0] minutes;
	wire [5:0] seconds;
	
	wire [3:0] min_10s;
	wire [3:0] min_1s;
	wire [3:0] sec_10s;
	wire [3:0] sec_1s;
	
	wire [6:0] cathode_vec0;
	wire [6:0] cathode_vec1;
	wire [6:0] cathode_vec2;
	wire [6:0] cathode_vec3;

	counter min_sec_counter(.onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .pause(pause_db), .rst(rst_db), .sel(sel_db), .adj(adj_db), .minutes(minutes), .seconds(seconds));
	
	separate_digits digits(.minutes(minutes), .seconds(seconds), .min_10s(min_10s), .min_1s(min_1s), .sec_10s(sec_10s), .sec_1s(sec_1s));

	display seven_seg_min10s(.placeholder(min_10s), .cathode_vec(cathode_vec0));
	display seven_seg_min1s(.placeholder(min_1s), .cathode_vec(cathode_vec1));
	display seven_seg_sec10s(.placeholder(sec_10s), .cathode_vec(cathode_vec2));
	display seven_seg_sec1s(.placeholder(sec_1s), .cathode_vec(cathode_vec3));

	final_display cathode_and_anode(.fast_clk(fast_clk), .blink_clk(blink_clk), .sel(sel_db), .adj(adj_db), .left_light(cathode_vec0), .middleleft_light(cathode_vec1), .middleright_light(cathode_vec2), .right_light(cathode_vec3), .cathode_vec(cathode_vec), .anode_vec(anode_vec));

endmodule
