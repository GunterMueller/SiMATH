/*M
.SH NAME
putecrlistp - put elliptic curve over rational numbers, list of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

single putecrlistp( PL, mode )  
list PL; 
single mode;

.SH DESCRIPTION
.TP 4
.B PL
 = ( P1 P2 ... Pn )            , for mode = 0
 = ( ( P1 h1 ) ... ( Pn hn ) ) , for mode != 0.
.TP 4
.B Pi
= ( xi yi zi )       0 <= i <= n;                                               
  int xi, yi, zi;                                                              
  defines the point Pi on an elliptic curve E/Q.
.TP 4
.B hi
 floating hi;        0 <= i <= n;                                               
 is the Neron-Tate height of the point Pi.
.PP
putecrlistp writes the points Pi to stdout ( as descripted in 'putecrp' ), every point in a new line.
.PP
In the case mode != 0, putecrlistp writes additionally the current number and the Neron-Tate height of Pi in every line.
.PP
putecrlistp returns 0 by success, ERROR else.

.SH SEE ALSO
putecrp

M*/

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecrlistp   : 921130.941201
H*/
/*
	For the definition of putecrlistp please refer to the header file _ec1.h.
*/
