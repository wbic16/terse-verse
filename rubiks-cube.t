The orientation of each corner cube
is either X, Y, or Z. The orientation
of each edge cube is either N or S.

This is the solved state:
X1X2X3X4
X1X6X7X8
N1N2N3N4
N5N6N7N8
N9NANBNC

Let's use a more visual orientation

  X1N1X2
  N4  N2
  X4N3X3
      N5  N6

      N8  N7
         X5N9X6
         NC  NA
         X8NBX7
Solved State
X1N1X2
N4  N2
X4N3X3
S7  S8
      
S7  S6
X5N9X6
NC  NA
X8NBX7Rotation Types

X, Y, and Z coordinates

Take a coordinate system with X pointing left and right.
Y points forward and back.
Z points up and down.

The top and bottom faces are in the X-Y plane.
The front and back faces are in the X-Z plane.
The left and right faces are in the Y-Z plane.

This gives us 12 possible quarter-turn rotations.
1. -90 @Z top
2. +90 @Z top
3. -90 @Z bottom
4. +90 @Z bottom
5. -90 @X left
6. +90 @X left
7. -90 @X right  
8. +90 @X right  
9. -90 @Y front
A. +90 @Y front  
B. -90 @Y back
C. +90 @Y back
   
-90 @Z top

Y2S2Y3
S1  S3
Y1S4Y4
N5  N6
  
N8  N7
X5N9X6
NC  NA
X8NBX7+90 @Z top

Y4S4Y1
S3  S1
Y3S2Y2
N5  N6

N8  N7
X5N9X6
NC  NA
X8NBX7
-90 @Z bottom

X1N1X2
N4  N2
X4N3X3
S7  S8
      
S7  S6
Y6SAY7
S9  SB
Y5SCY8+90 @Z bottom

X1N1X2
N4  N2
X4N3X3
S7  S8
      
S7  S6
Y8SCY5
SB  S9
Y7SAY6-90 @X left

Z5N1X2
S8  N2
Z1N3X3
S4  N6
      
SC  N7
Z8N9X6
S5  NA
Z4NBX7
+90 @X left

Z4N1X2
S5  N2
Z8N3X3
SC  N6
      
S4  N7
Z1N9X6
S8  NA
Z5NBX7
-90 @X right

X1N1Z6
N4  S6
X4N3Z2
N5  SA
     
N8  S2
X5N9Z7
NC  S7
X8NBZ3

+90 @X right

X1N1Z3
N4  S7
X4N3Z7
N5  S2
      
N8  SA
X5N9Z2
NC  S6
X8NBZ6

-90 @Y front+90 @Y front-90 @Y back+90 @Y front