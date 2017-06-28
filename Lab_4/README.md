# Lab 4: Space Invaders

## Description 
For the CSM152A final project, our group decided to recreate the classic arcade game: Space Invaders. This version is a simplified version of the game due to on-board memory constraint issues, and only having two weeks to work on the project. I noticed that as more objects were added to the game (i.e. more objects on the VGA display), the game began to act in an undefined manner (i.e. some alien objects stopped moving, or moved out of sync of the other alien objects, or the lasers began to glitch). I figured that this was due to FPGA board memory constraints (which is what the TA told me as well). I intend to complete the game using off-board memory and utilizing the MCB and MIG.

## Gameplay Video Links
* Note: There are three different videos showing different elements of the game. It was intended to recreate the original Space Invaders game, but due to memory constraints, the final implementation for demo day was much more simplified. The purpose of these different videos is to highlight different elements that would have been combined to form a more complete game (memory-permitting, which it was not).

[54_aliens.bit](http://
This video shows the start screen, and the game screen, which consists of the player spaceship being able to move left and right, 54 alien objects moving together in sync, and the flying saucer at the top of the screen.

[22_aliens_spaceship_lasers.bit](http://
This video shows the start screen, and the game screen, which consists of the player spaceship which can move left, move right, and fire lasers, 22 alien objects which move together in sync, and can be destroyed by the player spaceship laser,  the flying saucer at the top of the screen which can also be destroyed by lasers, and the four barriers which are displayed (but not yet active).

[gameover_screen.bit](https://www.youtube.com/watch?v=lbOyKXYbLiI)
This video shows a sample of the final demo of the game, which consists of the player spaceship, three alien objects, four active barriers, score tracking at the top of the screen, and levels (i.e. faster alien speed after all are destroyed. The details are described below under the Programming Bit Files header.

## Included Files

### Verilog Modules 

#### aliens.v
This module consists of the implementation for the alien spaceship. The aliens fire lasers and move together in sync across the screen. When they are hit by a player spaceship laser, they are removed from the screen (the current level). When all aliens are destroyed, all alien objects are reset, and move faster (i.e. the next level). Eventually, I intend to add all 55 alien objects (like in the original game), and have the actual alien sprites (instead of just blocks).

#### clk_div.v
This module consists of the pixel clock, which controls the speed of the in-game objects movement.

#### debouncer.v/debouncer_display_button.v
These modules serve to debounce the buttons on the FPGA to deal with the bouncing of the buttons, and correct the associated metastability issues.

#### extract_barrier_blk.v
This module consists of a portion of the barrier implementation. It is used to extract the coordinates of pieces of the barrier to make appropriate updates when hit by a laser.

#### flying_saucer.v
This module consists of the implementation of the flying saucer. The flying saucer only moves from right to left at the top of the screen, and reappears after a certain time limit. When hit by a player spaceship laser, it is destroyed, and removed from the screen. The flying saucer is worth more points than the alien objects.

#### gameover_screen.v
This module consists of the pixel configuration for the gameover screen.

#### isInBarrier.v
This module consists of a portion of the barrier implementation. It is used to process when a laser coordinate overlaps with a barrier coordinate (i.e. the barrier got hit by a laser). 

#### scoreboard_top.v
This module consists of the pixel configuration for the scoreboard at the top of the display. It consists of the words: SCORE and HI-SCORE. I have yet to implement the actual score (i.e. actual numbers).

#### scoreboard_bottom.v
This module consists of the pixel configuration for the objects at the bottom of the screen (i.e. player extra lives, and the word: CREDIT).

#### set_barrier.v
This module consists of a portion of the barrier implementation. It serves as the top module to the other barrier modules, and resets, and updates the display of the barriers when hit by lasers. When hit by a laser, a piece of the barrier shows that it has taken damage by changing color.

#### space_invaders_top.v
This is the top module for the entire project. It instantiates all of the modules to be used in the game.

#### spaceship.v
This module consists of the implementation for the player spaceship. The player spaceship moves left and right, and shoots lasers using buttons on the FPGA. When hit by an alien laser, the player spaceship is destroyed. This module processes the coordinates of all other objects in the game (i.e. top of the screen, alien objects, flying saucer, and barriers) to update when to reset the state of the laser (if it hits an object), and to send out the laser coordinates, so that the other objects can process the spacehsip laser in the same manner.

#### start_screen.v
This module consists of the pixel configuration for the start screen, which spells out SPACE INVADERS, and a sprite drawing of an alien (despite not looking like the alien from the original game).

#### vga_controller.v
This module consists of the implementation to control the horizontal and vertical counters that go into processing the VGA display for dimensions: 640x480. This module outputs the horizontal and vertical counters to the vga_display.v module (already adjusting the coordinates with the horizontal and vertical front and back porches). 

#### vga_display.v
This module is the bulk of the project. And consists of setting when the pixels for the corresponding objects are supposed to be displayed on the screen (e.g. updating display of player spaceship as it moves across the screen). It instantiates all of the in-game objects, and controls the RGB and VGA display. 

### Programming Files (.bit)

#### 54_aliens.bit
When programming the board, this file contains the start screen for
the game, and the level game screen. The level screen consists of the spaceship (player)
at the bottom of the screen, which is able to move left and right, but not shoot lasers.
In addition, it consists of 54 aliens that move in sync across the screen, the flying
saucer at the top of the screen, and the barriers. However, the player and the aliens
can’t shoot lasers (as with this number of objects moving on the screen, any more game
features led to glitchy behavior).

#### 22_aliens_spaceship_lasers.bit
This version consists of the start screen, in addition to the level screen. This version
supports the spaceship being able to move left and right, in addition to being able to
shoot lasers. There are 22 aliens and the flying saucer, which can be shot (and killed)
by the spaceship’s laser. The barriers are visible, but not active in this game mode, and
the aliens don’t shoot lasers.

#### gameover_screen.bit
This was our final game implementation which consisted of the main game features. To free
up memory (or board functionality) for other in-game features, the start screen, the 
score board writing (i.e. SCORE and HI-SCORE), and the flying saucer were removed from
this version. Instead, we were able to fully implement the spaceship features (i.e. 
moving left and right, and shooting lasers), the barrier features (i.e. health that goes
down when shot by spaceship or alien lasers as in the actual game), the alien features 
(i.e. moving left to right, and down when approaching an edge of the display, shooting
lasers, and taking damage from spaceship lasers), and a score display was added as well.

This version supports 3 aliens, and 8 levels (i.e. when killing all aliens, they respawn
and move at a higher frequency). After the 8 levels, their behavior begins to glitch out.
The player has a single life in this gameplay, and when hit by an alien laser, the 
player dies, and a transition from the level screen to the game over screen takes place.
Note that the game over screen simply is a black screen (as we didn’t want to add anymore
pixels to the game to allow for the in-game features to function properly). Lastly, the 
game also supports a score, which consists of a blue bar at the top of the screen that
increases by a steady amount after each alien is killed. Note we originally designed the
program to have an actual score displayed (like in the actual game), with the words: 
SCORE and HI-SCORE at the top of the screen, and the score were to be displayed as 
numbers. However, this was costly, affected gameplay, and thus, we just chose to have
a blue bar display the score.

### User Constraint File

#### Nexys3_General.ucf
Buttons:
* Left Button: Player spaceship move left
* Center Button: Player spaceship move right
* Right Button: Player spaceship shoot laser
* Top Button: Reset game

## Built With
* Equipment: Xilinx Nexys3 Spartan-6 FPGA
* Language: Verilog
