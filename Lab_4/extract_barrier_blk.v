module extract_barrier_blk(
	//inputs
   input wire [9:0] xCoord,
   input wire [9:0] yCoord,
   //output
   output reg [1:0] currBarrier,
   output reg [1:0] xVal,
   output reg [1:0] yVal,
   output reg inBarrier
	);
	`include "barrier_params.vh"
	// Barrier Parameters

   reg [9:0] shiftedXCoord;

/*
   isInBarrier findBarrier(
	//Inputs
	.xCoord(xCoord), .yCoord(yCoord),
	//Outputs
	.currBarrier(currBarrier), .inBarrier(inBarrier), .shiftedXCoord(shiftedXCoord)
	);
*/
	wire [9:0] shiftedYCoord;
	assign shiftedYCoord = yCoord - BARR_YSTART;
	always @ (*) begin
		if(yCoord >= BARR_YSTART && yCoord <= BARR_YSTART + BARR_HEIGHT) begin
			if(xCoord >= BARR0_XSTART && xCoord <= BARR0_XSTART+BARR_WIDTH) begin
				currBarrier <= 2'b00;
				shiftedXCoord <= xCoord - BARR0_XSTART;
				inBarrier <= 1'b1;
			end
			else if(xCoord > BARR1_XSTART && xCoord <= BARR1_XSTART+BARR_WIDTH) begin
				currBarrier <= 2'b01;
				shiftedXCoord <= xCoord - BARR1_XSTART;
				inBarrier <= 1'b1;
			end
			else if(xCoord > BARR2_XSTART && xCoord <= BARR2_XSTART+BARR_WIDTH) begin
				currBarrier <= 2'b10;
				shiftedXCoord <= xCoord - BARR2_XSTART;
				inBarrier <= 1'b1;
			end
			else if(xCoord > BARR3_XSTART && xCoord <= BARR3_XSTART+BARR_WIDTH) begin
				currBarrier <= 2'b11;
				shiftedXCoord <= xCoord - BARR3_XSTART;
				inBarrier <= 1'b1;
			end
			else begin
				currBarrier <= 2'b00;
				shiftedXCoord <= BARR0_XSTART + 8*BARR_WIDTH;
				inBarrier <= 1'b0;
			end
		end
		else begin
			currBarrier <= 2'b00;
			shiftedXCoord <= BARR0_XSTART + 8*BARR_WIDTH;
			inBarrier <= 1'b0;
		end
	//logic to find out where within the barrier we are
		if(shiftedXCoord >= 0 && shiftedXCoord <= 1*BARR_BLK_SZ) begin
			xVal <= 2'b00;
		end
		else if(shiftedXCoord > 1*BARR_BLK_SZ && shiftedXCoord <= 2*BARR_BLK_SZ) begin
			xVal <= 2'b01;
		end
		else if(shiftedXCoord > 2*BARR_BLK_SZ && shiftedXCoord <= 3*BARR_BLK_SZ) begin
			xVal <= 2'b10;
		end
		else if (shiftedXCoord > 3*BARR_BLK_SZ && shiftedXCoord <= 4*BARR_BLK_SZ) begin
			xVal <= 2'b11;
		end
		else begin
			xVal <= 2'b11;
		end
		//logic to output yCoord
		if(shiftedYCoord >= 0 && shiftedYCoord <= 1*BARR_BLK_SZ) begin
			yVal <= 2'b00;
		end
		else if(shiftedYCoord > 1*BARR_BLK_SZ  && shiftedYCoord <= 2*BARR_BLK_SZ) begin
			yVal <= 2'b01;
		end
		else if(shiftedYCoord > 2*BARR_BLK_SZ && shiftedYCoord <= 3*BARR_BLK_SZ) begin
			yVal <= 2'b10;
		end
		else if(shiftedYCoord > 3*BARR_BLK_SZ) begin
			yVal <= 2'b11;
		end
	end
endmodule 