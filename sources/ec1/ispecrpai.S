/*M
.SH NAME
ispecrpai - is point of an elliptic curve over the rationals point at infinity

.SH SYNOPSIS
.nf
#include<_ec1.h>

single ispecrpai(P1)
list P1;

.SH DESCRIPTION
ispecrpai returns 1, if P = (x, y, 0),                                        
                  0, else.                                                    
.TP 4 
.B P1                                                                           
is a list of 3 rational numbers, defining the projective                        
Point P of the elliptic curve E/Q.                           
M*/

/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ispecrpai     : 930531.9311__.941201
H*/
/*
	For the definition of ispecrpai please refer to the header file _ec1.h.
*/
