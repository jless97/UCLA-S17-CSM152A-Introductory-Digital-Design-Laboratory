`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
// SPACE (40 by 50)
		// Letter S (revised)
		if (hc > 200+hbp && hc < 240+hbp && vc > 100+vbp && vc < 150+vbp) begin
			if (
				(hc > 200+hbp && hc < 210+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 230+hbp && hc < 240+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 210+hbp && hc < 230+hbp && vc > 110+vbp && vc < 120+vbp) ||
				(hc >= 230+hbp && hc < 240+hbp && vc >= 115+vbp && vc < 125+vbp) ||
				(hc > 200+hbp && hc < 210+hbp && vc > 125+vbp && vc < 135+vbp) ||
				(hc >= 210+hbp && hc < 230+hbp && vc > 130+vbp && vc < 140+vbp) ||
				(hc > 200+hbp && hc < 210+hbp && vc > 145+vbp && vc < 150+vbp) ||
				(hc > 230+hbp && hc < 240+hbp && vc > 145+vbp && vc < 150+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter P (revised)
		else if (hc > 250+hbp && hc < 290+hbp && vc > 100+vbp && vc < 150+vbp) begin
			if (
				(hc > 285+hbp && hc < 290+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 260+hbp && hc < 280+hbp && vc > 105+vbp && vc < 120+vbp) ||
				(hc > 285+hbp && hc < 290+hbp && vc > 120+vbp && vc < 125+vbp) ||
				(hc > 260+hbp && hc < 290+hbp && vc >= 125+vbp && vc < 150+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter A (revised)
		else if (hc > 300+hbp && hc < 340+hbp && vc > 100+vbp && vc < 150+vbp) begin
			if (
				(hc > 300+hbp && hc < 305+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 335+hbp && hc < 340+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 310+hbp && hc < 330+hbp && vc > 105+vbp && vc < 120+vbp) ||
				(hc > 310+hbp && hc < 330+hbp && vc > 125+vbp && vc < 150+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter C (revised)
      else if (hc > 350+hbp && hc < 390+hbp && vc > 100+vbp && vc < 150+vbp) begin
			if (
				(hc > 350+hbp && hc < 360+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 380+hbp && hc < 390+hbp && vc > 100+vbp && vc < 105+vbp) ||
				(hc > 360+hbp && hc < 380+hbp && vc > 110+vbp && vc < 140+vbp) ||
				(hc >= 380+hbp && hc < 390+hbp && vc > 115+vbp && vc < 135+vbp) ||
				(hc > 350+hbp && hc < 360+hbp && vc > 145+vbp && vc < 150+vbp) ||
				(hc > 380+hbp && hc < 390+hbp && vc > 145+vbp && vc < 150+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter E (revised)
		else if (hc > 400+hbp && hc < 440+hbp && vc > 100+vbp && vc < 150+vbp) begin
			if (
				(hc > 410+hbp && hc < 440+hbp && vc > 110+vbp && vc < 120+vbp) ||
				(hc > 430+hbp && hc < 440+hbp && vc >= 120+vbp && vc < 130+vbp) ||
				(hc > 410+hbp && hc < 440+hbp && vc >= 130+vbp && vc < 140+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
// INVADERS	(30 by 40)	
		
		// Letter I
		else if (hc > 185+hbp && hc < 215+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 185+hbp && hc < 195+hbp && vc > 195+vbp && vc < 225+vbp) ||
				(hc > 205+hbp && hc < 215+hbp && vc > 195+vbp && vc < 225+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter N
		else if (hc > 220+hbp && hc < 250+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 230+hbp && hc < 240+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 233+hbp && hc < 240+hbp && vc >= 195+vbp && vc < 200+vbp) ||
				(hc > 236+hbp && hc < 240+hbp && vc >= 200+vbp && vc < 205+vbp) ||
				(hc > 230+hbp && hc < 233+hbp && vc > 215+vbp && vc < 220+vbp) ||
				(hc > 230+hbp && hc < 236+hbp && vc >= 220+vbp && vc < 225+vbp) ||
				(hc > 230+hbp && hc < 240+hbp && vc >= 225+vbp && vc < 230+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end 
		// Letter V
		else if (hc > 255+hbp && hc < 285+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 265+hbp && hc < 275+hbp && vc > 190+vbp && vc < 210+vbp) ||
				(hc > 255+hbp && hc < 260+hbp && vc > 215+vbp && vc < 225+vbp) ||
				(hc > 280+hbp && hc < 285+hbp && vc > 215+vbp && vc < 225+vbp) ||
				(hc > 255+hbp && hc < 265+hbp && vc >= 225+vbp && vc < 230+vbp) ||
				(hc > 275+hbp && hc < 285+hbp && vc >= 225+vbp && vc < 230+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter A
		else if (hc > 290+hbp && hc < 320+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 290+hbp && hc < 295+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 315+hbp && hc < 320+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 300+hbp && hc < 310+hbp && vc > 195+vbp && vc < 205+vbp) ||
				(hc > 300+hbp && hc < 310+hbp && vc > 210+vbp && vc < 230+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end 
		// Letter D
		else if (hc > 325+hbp && hc < 355+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 345+hbp && hc < 355+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 350+hbp && hc < 355+hbp && vc >= 195+vbp && vc < 200+vbp) ||
				(hc > 345+hbp && hc < 355+hbp && vc >= 225+vbp && vc < 230+vbp) ||
				(hc > 350+hbp && hc < 355+hbp && vc > 220+vbp && vc < 225+vbp) ||
				(hc > 335+hbp && hc < 340+hbp && vc > 195+vbp && vc < 225+vbp) ||
				(hc >= 340+hbp && hc < 345+hbp && vc > 200+vbp && vc < 220+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter E
		else if (hc > 360+hbp && hc < 390+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 370+hbp && hc < 390+hbp && vc > 195+vbp && vc < 205+vbp) ||
				(hc > 380+hbp && hc < 390+hbp && vc >= 205+vbp && vc < 215+vbp) ||
				(hc > 370+hbp && hc < 390+hbp && vc >= 215+vbp && vc < 225+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter R
		else if (hc > 395+hbp && hc < 425+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 420+hbp && hc < 425+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 405+hbp && hc < 415+hbp && vc > 195+vbp && vc < 205+vbp) ||
				(hc > 420+hbp && hc < 425+hbp && vc > 205+vbp && vc < 215+vbp) ||
				(hc > 405+hbp && hc < 410+hbp && vc > 210+vbp && vc < 215+vbp) ||
				(hc > 405+hbp && hc < 415+hbp && vc >= 215+vbp && vc < 230+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end 
		// Letter S
		else if (hc > 430+hbp && hc < 460+hbp && vc > 190+vbp && vc < 230+vbp) begin
			if (
				(hc > 430+hbp && hc < 435+hbp && vc > 190+vbp && vc < 195+vbp) ||
				(hc > 455+hbp && hc < 460+hbp && vc > 190+vbp && vc < 195+vbp) ||
				//////////////////////////////////////////////////////////////////////////
				(hc > 435+hbp && hc <= 455+hbp && vc > 200+vbp && vc < 207+vbp) ||
				(hc >= 435+hbp && hc < 455+hbp && vc > 213+vbp && vc < 220+vbp) ||
				
				(hc > 455+hbp && hc < 460+hbp && vc > 202+vbp && vc < 210+vbp) ||
				(hc > 430+hbp && hc < 435+hbp && vc >= 210+vbp && vc < 218+vbp) || 
				//////////////////////////////////////////////////////////////////////////
				(hc > 430+hbp && hc < 435+hbp && vc > 225+vbp && vc < 230+vbp) ||
				(hc > 455+hbp && hc < 460+hbp && vc > 225+vbp && vc < 230+vbp) 
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Space Invader (Enemy) (60 by 80)
		else if (hc > 290+hbp && hc < 350+hbp && vc > 270+vbp && vc < 350+vbp) begin
			if (
				(hc > 290+hbp && hc < 310+hbp && vc > 270+vbp && vc < 280+vbp) ||
				(hc > 330+hbp && hc < 350+hbp && vc > 270+vbp && vc < 280+vbp) ||
				(hc > 290+hbp && hc < 300+hbp && vc >= 280+vbp && vc < 290+vbp) ||
				(hc > 340+hbp && hc < 350+hbp && vc >= 280+vbp && vc < 290+vbp) ||
				(hc > 305+hbp && hc < 315+hbp && vc > 290+vbp && vc < 300+vbp) ||
				(hc > 325+hbp && hc < 335+hbp && vc > 290+vbp && vc < 300+vbp) ||
				(hc > 290+hbp && hc < 305+hbp && vc > 310+vbp && vc < 320+vbp) ||
				(hc > 315+hbp && hc < 325+hbp && vc > 310+vbp && vc < 310+vbp) ||
				(hc > 335+hbp && hc < 350+hbp && vc > 310+vbp && vc < 320+vbp) ||
				(hc > 290+hbp && hc < 300+hbp && vc >= 320+vbp && vc < 330+vbp) ||
				(hc > 310+hbp && hc < 315+hbp && vc >= 320+vbp && vc < 330+vbp) ||
				(hc > 325+hbp && hc < 330+hbp && vc >= 320+vbp && vc < 330+vbp) ||
				(hc > 340+hbp && hc < 350+hbp && vc >= 320+vbp && vc < 330+vbp) ||
				(hc > 300+hbp && hc < 340+hbp && vc > 340+vbp && vc < 350+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TAP TO PLAY (15 by 20)
		else if (hc > 234+hbp && hc < 423+hbp && vc > 450+vbp && vc < 470+vbp) begin
			// Letter T
			if ( 
				(hc > 234+hbp && hc < 249+hbp && vc > 450+vbp && vc < 470+vbp) ||
				(hc > 244+hbp && hc < 249+hbp && vc > 455+vbp && vc < 470+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter A
		else if (hc > 251+hbp && hc < 266+hbp && vc > 450+vbp && vc < 470+vbp) begin
			if (
				(hc > 251+hbp && hc < 254+hbp && vc > 450+vbp && vc < 453+vbp) ||
				(hc > 263+hbp && hc < 266+hbp && vc > 450+vbp && vc < 453+vbp) ||
				(hc > 256+hbp && hc < 261+hbp && vc > 453+vbp && vc < 457+vbp) ||
				(hc > 256+hbp && hc < 261+hbp && vc > 456+vbp && vc < 470+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter P
		else if (hc > 268+hbp && hc < 283+hbp && vc > 450+vbp && vc < 470+vbp) begin
			if (
				(hc > 280+hbp && hc < 283+hbp && vc > 450+vbp && vc < 453+vbp) ||
				(hc > 280+hbp && hc < 283+hbp && vc > 457+vbp && vc < 460+vbp) ||
				(hc > 455+hbp && hc < 465+hbp && vc > 453+vbp && vc < 457+vbp) ||
				(hc > 273+hbp && hc < 283+hbp && vc > 460+hbp && vc < 470+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter T
		else if (hc > 303+hbp && hc < 318+hbp && vc > 450+vbp && vc < 470+vbp) begin
			if (
				(hc > 303+hbp && hc < 308+hbp && vc > 455+vbp && vc < 470+vbp) ||
				(hc > 313+hbp && hc < 318+hbp && vc > 455+vbp && vc < 470+vbp)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter O
/*		else if (hc > 322+hbp && hc < 337+hbp && vc > 450+vbp && vc < 470+vbp) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter P
		else if (hc > 357+hbp && hc < 372+hbp && vc > 450+vbp && vc < 470+vbp) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter L
		else if (hc > 374+hbp && hc < 389+hbp && vc > 450+vbp && vc < 47+vbp) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter A
		else if (hc > 391+hbp && hc < 406+hbp && vc > 450+vbp && vc < 47+vbp) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter Y
		else if (hc > 408+hbp && hc < 423+hbp && vc > 450+vbp && vc < 47+vbp) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end*/
		else begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end
	end
end	
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/*		// Letter S of (Space Invaders)
      if (hc > 200+hbp && hc < 240+hbp && vc > 100+vbp && vc < 160+vbp) begin	
			// Top left corner
			if (hc > 200+hbp && hc < 210+hbp && vc > 100+vbp && vc < 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Top right corner
			else if (hc > 230+hbp && hc < 240+hbp && vc > 100+vbp && vc < 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom left corner
			else if (hc > 200+hbp && hc < 210+hbp && vc > 150+vbp && vc < 160+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom right corner
			else if (hc > 230+hbp && hc < 240+hbp && vc > 150+vbp && vc < 160+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle top hole
			else if (hc > 214+hbp && hc < 226+hbp && vc >= 110+vbp && vc < 120+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle middle hole
			else if (hc >= 223+hbp && hc < 240+hbp && vc >= 120+vbp && vc < 130+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle bottom hole
			else if (hc >= 234+hbp && hc < 240+hbp && vc >= 130+vbp && vc < 138+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom bottom hole
			else if (hc > 214+hbp && hc < 226+hbp && vc >= 140+vbp && vc < 150+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom middle hole
			else if (hc > 200+hbp && hc <= 217+hbp && vc >=130+vbp && vc < 140+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom top hole
			else if (hc > 200+hbp && hc <= 202+hbp && vc >= 122+vbp && vc < 130+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Letter S
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
      end
		
      // Letter P of (Space Invaders)
      else if (hc > 250+hbp && hc < 290+hbp && vc > 100+vbp && vc < 160+vbp) begin
			// Top right corner
			if (hc > 280+hbp && hc < 290+hbp && vc > 100+vbp && vc < 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle hole
			else if (hc > 260+hbp && hc < 280+hbp && vc > 110+vbp && vc < 130+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle right hole
			else if (hc > 280+hbp && hc < 290+hbp && vc > 130+vbp && vc <= 140+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom right hole
			else if (hc > 260+hbp && hc < 290+hbp && vc > 140+vbp && vc < 160+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Letter P
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
      end

      // Letter A of (Space Invaders)
		else if (hc > 300+hbp && hc < 340+hbp && vc > 100+vbp && vc < 160+vbp) begin
			// Top left corner
			if (hc > 300+hbp && hc < 310+hbp && vc > 100+vbp && vc < 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Top right corner
			else if (hc > 330+hbp && hc < 340+hbp && vc > 100+vbp && vc < 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle hole
			else if (hc > 310+hbp && hc < 330+hbp && vc > 110+vbp && vc < 130+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom hole
			else if (hc > 310+hbp && hc < 330+hbp && vc > 140+vbp && vc < 160+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Letter A
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end

      // Letter C of (Space Invaders)
      else if (hc > 350+hbp && hc < 390+hbp && vc > 100+vbp && vc < 160+vbp) begin
			// Top left corner
			if (hc > 350+hbp && hc < 362+hbp && vc > 100+vbp && vc <= 110+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Top middle corner
			else if (hc > 350+hbp && hc < 356+hbp && vc > 110+vbp && vc < 120+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom middle corner
			else if (hc > 350+hbp && hc < 356+hbp && vc > 140+vbp&& vc < 150+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom left corner
			else if (hc > 350+hbp && hc < 362+hbp && vc >= 150+vbp && vc < 160+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle left hole
			else if (hc > 362+hbp && hc < 376+hbp && vc >= 120+vbp && vc <= 140+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle right hole
			else if (hc >= 376+hbp && hc < 390+hbp && vc >= 110+vbp && vc <= 150+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Letter C
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		end
      
		// Letter E of (Space Invaders)
      else if (hc > 400+hbp && hc < 440+hbp && vc > 100+vbp && vc < 160+vbp) begin
			// Top hole
			if (hc > 410+hbp &&  hc < 440+hbp && vc >= 110+vbp && vc < 120+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Middle hole
			else if (hc > 420+hbp && hc < 440+hbp && vc >= 120+vbp && vc <= 140+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Bottom hole
			else if (hc > 410+hbp && hc < 440+hbp && vc >= 140+vbp && vc < 150+vbp) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			// Letter E
			else begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
      end
		
		else begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end
endmodule*/
