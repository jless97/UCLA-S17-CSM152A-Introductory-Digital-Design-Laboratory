# Lab 3: Stopwatch

## Description 
The purpose of this lab was to create a stopwatch using the Nexys 3 Spartan-6 FPGA board. The stopwatch was displayed using the board's seven-segment display. In additon, the stopwatch consisted of two modes: normal mode and adjust mode. In normal mode, the stopwatch would increment normally once per second (1 Hz clk). In adjust mode, either the minutes or the seconds time field would be incremented twice per second (2 Hz clk), while the time field not being adjusted is frozen to its current value. The desired mode was selected using one of the board's switches (ADJ), and the time field to be adjusted was selected using another switch (SEL). Moreover, while in adjust mode, to illustrate which time field is being adjusted, the adjusting time field blinks. This was achieved by using a 4 Hz clock to blink on and off the given time field. 

In addition to the two switches, the stopwatch supports two other features: pause and reset. These features were carried out using two of the board's buttons. When the pause button is pressed, both time fields are frozen to their current values. When pressed again, the stopwatch begins incrementing again. When the reset button is pressed, both time fields are reset to 00, and the stopwatch begins all over again. 

Lastly, a fourth clock was used (400 Hz clk) to display the seven-segment display. The frequency is large, so that the fast changing of the segments of the display go unnoticed to the human eye, and it appears as if the segments are not switching between the four anodes.

## Included Files

### top.v
The top module of the stopwatch served to initialize the four clock dividers, debounce the two switches and two buttons, begin the counting of the stopwatch, and finally to display the values of the stopwatch to the seven-segment display.

### clk_div.v
This module creates the four clocks (i.e. 1 Hz, 2 Hz, 4 Hz, 400 Hz) from the master clock of the FPGA board (i.e. 100 MHz).

### counter.v
This module does the actual incrementing of the minutes and seconds time fields for the stopwatch. It begins by calling the sel_adj.v sub-module to choose which clock to increment the stopwatch at (specified by normal or adjust mode). After choosing the desired clock, this module registers the minutes and seconds time fields as counters. There are three edge cases that were considered: (1) when the one's place of the seconds time field has value 9, and is incremented, in which the one's place is reset to 0, and the ten's place of the seconds time field is incremented by 1, (2) when the seconds time field has value 59, and is incremented, in which the seconds time field should be reset to 00, and the minutes time field is incremented by 1, (3) when both the minutes and seconds time fields have value 59, in which both time fields should be reset to 00.

### sel_adj.v
This module sends the specified clock (1 Hz or 2 Hz) to the counter module as determined by if the stopwatch is in normal or adjust mode.

### debouncer.v
This module debounces the switches and the buttons. This is achieved by using a register as a counter to record for a given duration the state of the signal. If the signal is in a current state for a long enough period, it is determined to be high, at which the signal is changed to reflect the value of the signal. In addition, to deal with the metastability problem, two registers are used to synchronize the value of the signal to the clock. By doing this, the signal is synchronized to the clock for a given period of time to avoid undefined arrivals of signals due to bouncing signals.

### display.v
This module chooses the appropriate cathodes of the seven-segment display to go high depending on the value of the corresponding time fields. The values given as input to this module were the 10's and 1's place values for both minutes and seconds. This module then output the cathodes that should be lit for each of the four digits of the seven-segment display.

### final_display.v
This module cycled through the four digits of the seven-segment display at a frequency determined by the fast_clk (400 Hz). The anodes were cycled through at a high frequency to light up the corresponding digits of the seven-segment display at a frequency high enough so that the human eye can't see the changing of the four anodes. In addition, if in adjust mode, this module correctly blinks the adjusting time field at 4 Hz.

### separate_digits.v
This module merely separate the minutes or seconds time field into two pieces: 10's place and 1's place, and then feeds these values as input to the display.v module.

### stopwatch.ucf
This file contains the associated pins of the buttons and switches of the FPGA board that were used for this project.
