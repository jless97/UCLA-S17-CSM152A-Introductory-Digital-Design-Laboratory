module alien{
    //Inputs
    input wire clk,
    input wire rst,
    //Location of current X and Y coordinate
    input reg [10:0] xCoord, 
    input reg [10:0] yCoord,
    // Outputs
    output wire isAlien
    };

    parameter ALIEN_HEIGHT = 11'd15;
    parameter ALIEN_LENGTH = 11'd35;
    // TEMPORARY
    parameter ALIEN_TOP = 11'd80;
    parameter ALIEN_BOTTOM = 11'd96;
    parameter ALIEN_INITIAL_X = 11'd320;
    parameter ALIEN_INITIAL_Y = 11'd88;
    reg [10:0] alien_xCoord;
    reg [10:0] alien_yCoord;
    reg alien_move_left;
    reg alien_move_right;
        
    // Initialize alien ships
    initial begin
        alien_xCoord = ALIEN_INITIAL_X;
        alien_yCoord = ALIEN_INITIAL_Y;
        alien_move_left = 1;
        alien_move_right = 0;
    end
    always @(posedge clk) begin
        if (rst) begin
            alien_xCoord = ALIEN_INITIAL_X;
            alien_yCoord = ALIEN_INITIAL_Y;
        end
        // Alien Controls
        // Moving left, update alien position to the left (if possible)
        if (alien_move_left) begin
            // If at left edge of the display, bounce back
            if (alien_xCoord <= LEFT_EDGE + ALIEN_LENGTH / 2) begin
                alien_move_right = 1;
                alien_move_left = 0;
            end
            // Normal left move
            else begin
                alien_xCoord = alien_xCoord - MOVE_LEFT;
            end
        end
        // Moving right, update alien position to the right (if possible)
        if (alien_move_right) begin
            // If at right edge of the display, bounce back
            if (alien_xCoord >= RIGHT_EDGE - ALIEN_LENGTH / 2) begin
                alien_move_right = 0;
                alien_move_left = 1;
            end
            // Normal right move
            else begin
                alien_xCoord = alien_xCoord + MOVE_RIGHT;
            end
        end
    end
    assign isAlien = (yCoord >= alien_yCoord - ALIEN_HEIGHT / 2 && yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 &&
                            xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && xCoord <= alien_xCoord + ALIEN_LENGTH / 2);
endmodule