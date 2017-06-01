module extract_barrier_blk(
    //inputs
    input wire [10:0] xCoord,
    input wire [10:0] shiftedYCoord,
    //output
    output reg [1:0] currBarrier,
    output reg [1:0] xVal,
    output reg [1:0] yVal,
    output reg inBarrier
);
    parameter BARR_WIDTH = 76;
    parameter BARR0_XSTART = 74;
    parameter BARR1_XSTART = BARR0_XSTART+(2*BARR_WIDTH);
    parameter BARR2_XSTART = BARR0_XSTART+(4*BARR_WIDTH);
    parameter BARR3_XSTART = BARR0_XSTART+(6*BARR_WIDTH);
    parameter BARR_BLK_SZ = 19;
    reg [10:0] shiftedXCoord;
    always@(*) begin
        //logic to find which barrier we are currently in
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
        else begin
            currBarrier = 2'b00;
            shiftedXCoord = BARR0_XSTART + 8*BARR_WIDTH;
            inBarrier = 0;
        end
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
endmodule