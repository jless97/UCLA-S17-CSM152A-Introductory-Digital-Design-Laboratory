Identification:
    COURSE: CS M152A: Lab 4 (Space Invaders)
    NAME: Jason Less, Lucas Jenkins, Eddie Huang

Description of included .bit files:
———————————————————————————————————
As discussed with you in class, due to the board’s capabilities, the full space invaders
game was not implemented all in one program (or programming .bit file for the board).
Instead, we have three main .bit files that are included in this zip file showcasing 
different features of our Space Invaders program:

(1) 54_aliens.bit: 
When programming the board, this file contains the start screen for
the game, and the level game screen. The level screen consists of the spaceship (player)
at the bottom of the screen, which is able to move left and right, but not shoot lasers.
In addition, it consists of 54 aliens that move in sync across the screen, the flying
saucer at the top of the screen, and the barriers. However, the player and the aliens
can’t shoot lasers (as with this number of objects moving on the screen, any more game
features led to glitchy behavior).

(2) 22_aliens_spaceship_lasers.bit:
This version consists of the start screen, in addition to the level screen. This version
supports the spaceship being able to move left and right, in addition to being able to
shoot lasers. There are 22 aliens and the flying saucer, which can be shot (and killed)
by the spaceship’s laser. The barriers are visible, but not active in this game mode, and
the aliens don’t shoot lasers.

(3) gameover_screen.bit:
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