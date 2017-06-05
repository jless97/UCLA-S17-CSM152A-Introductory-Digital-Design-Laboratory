module extract_barrier_blk(
	//inputs
   input wire [10:0] xCoord,
   input wire [10:0] yCoord,
   //output
   output wire [1:0] currBarrier,
   output reg [1:0] xVal,
   output reg [1:0] yVal,
   output wire inBarrier
	);
	`include "barrier_params.vh"
	// Barrier Parameters
   wire [10:0] shiftedXCoord;
   isInBarrier findBarrier(
    //Inputs
    .xCoord(xCoord), .yCoord(yCoord),
    //Outputs
    .currBarrier(currBarrier), .inBarrier(inBarrier), .shiftedXCoord(shiftedXCoord)
    );

   wire [10:0] shiftedYCoord;
   assign shiftedYCoord = yCoord - BARR_YSTART;
	always @ (*) begin
		if(inBarrier) begin
	      //logic to find out where within the barrier we are
	      if(shiftedXCoord >= 0 && shiftedXCoord <= 1*BARR_BLK_SZ) begin
	         xVal = 2'b00;
	      end
	      else if(shiftedXCoord > 1*BARR_BLK_SZ && shiftedXCoord <= 2*BARR_BLK_SZ) begin
	         xVal = 2'b01;
	      end
	      else if(shiftedXCoord > 2*BARR_BLK_SZ && shiftedXCoord <= 3*BARR_BLK_SZ) begin
	         xVal = 2'b10;
	      end
	      else if(shiftedXCoord > 3*BARR_BLK_SZ) begin
	         xVal = 2'b11;
	      end
	      if(shiftedYCoord >= 0 && shiftedYCoord <= 1*BARR_BLK_SZ) begin
	         yVal = 2'b00;
	      end
	      if(shiftedYCoord > 1*BARR_BLK_SZ  && shiftedYCoord <= 2*BARR_BLK_SZ) begin
	         yVal = 2'b01;
	      end
	      if(shiftedYCoord > 2*BARR_BLK_SZ && shiftedYCoord <= 3*BARR_BLK_SZ) begin
	         yVal = 2'b10;
	      end
	      else if(shiftedYCoord > 3*BARR_BLK_SZ) begin
	         yVal = 2'b11;
	      end
	   end
	   else begin
	   	xVal = 2'b00;
	   	yVal = 2'b00;
	   end
	end
endmodule 
