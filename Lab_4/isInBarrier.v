module isInBarrier(
    //inputs
   input wire [9:0] xCoord,
   input wire [9:0] yCoord,
   //Outputs
   output reg [1:0] currBarrier,
   output reg inBarrier,
   output reg [9:0] shiftedXCoord
);
`include "barrier_params.vh"
always @ (*) begin
    //logic to find which barrier we are currently in
    if(yCoord >= BARR_YSTART && yCoord <= BARR_YSTART + BARR_HEIGHT) begin
        if(xCoord >= BARR0_XSTART && xCoord <= BARR0_XSTART+BARR_WIDTH) begin
            currBarrier = 2'b00;
            shiftedXCoord = xCoord - BARR0_XSTART;
            inBarrier = 1;
        end
        else if(xCoord > BARR1_XSTART && xCoord <= BARR1_XSTART+BARR_WIDTH) begin
            currBarrier = 2'b01;
            shiftedXCoord = xCoord - BARR1_XSTART;
            inBarrier = 1;
        end
        else if(xCoord > BARR2_XSTART && xCoord <= BARR2_XSTART+BARR_WIDTH) begin
            currBarrier = 2'b10;
            shiftedXCoord = xCoord - BARR2_XSTART;
            inBarrier = 1;
        end
        else if(xCoord > BARR3_XSTART && xCoord <= BARR3_XSTART+BARR_WIDTH) begin
            currBarrier = 2'b11;
            shiftedXCoord = xCoord - BARR3_XSTART;
            inBarrier = 1;
        end
    end
    else begin
        currBarrier = 2'b00;
        shiftedXCoord = BARR0_XSTART + 8*BARR_WIDTH;
        inBarrier = 0;
    end
end
endmodule
