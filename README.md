# Digital Logic Design in Verilog (made with Xilinx)

###[CE2704_HW10](/CE2704_HW10/)

######About
This is an example of a project done on Xilinx using Verilog language

######Image
![modelsim_ piggytest -1](https://cloud.githubusercontent.com/assets/14798722/22886559/04a478c8-f231-11e6-8508-3eb18c311c43.png)

###[24-hour Digital Clock](/Project/)

######Apparatus
* Integrated circuits
* clock, power supply
* 7-segment display
* resistors

######Procedure
I set the 4-bit counters (74LS93P) to reset at 23:59 using AND gates (74LS08) and OR (74LS32) gates.  The first resets at 1010 = 10102.  The second resets at 610 = 01102.  The third resets at again, 1010 = 10102.  The fourth resets when the fourth counter is at 210 = 00102 and when the third counter is at 410 = 01002.  I then used OR gates to reset the counter when the next counter also resets.  Then I used the BCD to 7-segment decoder (74LS47) to translate the numerical values to be displayed on the 7-segments.  Resistors are used because the voltage is too high and would destroy the 7-segment display.  The clock is set to 60Hz and all four counters are connected by the same clock.  Each counter is powered by 5V and is connected to the ground.

######Diagram
![ls7493p project](https://cloud.githubusercontent.com/assets/14798722/22886316/d9327c72-f22f-11e6-9ddb-95f68a803b22.png)
