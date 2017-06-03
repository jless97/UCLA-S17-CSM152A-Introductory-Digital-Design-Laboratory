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

	// Barrier Parameters
   reg [9:0] shiftedXCoord;
   parameter BARR_WIDTH = 76;
   parameter BARR0_XSTART = 54;
   parameter BARR1_XSTART = BARR0_XSTART+(2*BARR_WIDTH);
   parameter BARR2_XSTART = BARR0_XSTART+(4*BARR_WIDTH);
   parameter BARR3_XSTART = BARR0_XSTART+(6*BARR_WIDTH);
   parameter BARR_BLK_SZ = 19;
   parameter BARR_YSTART = 340;
   
	reg [9:0] shiftedXCoord_temp;
   isInBarrier findBarrier(
    //Inputs
    .xCoord(xCoord), .yCoord(yCoord),
    //Outputs
    .currBarrier(currBarrier), .inBarrier(inBarrier), .shiftedXCoord(shiftedXCoord)
    );

   wire [9:0] shiftedYCoord;
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
