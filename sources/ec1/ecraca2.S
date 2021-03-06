/*M
.SH NAME
ecraca2 - elliptic curve over rational numbers, actual curve, a2

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecraca1(E1)
list E1;

.SH DESCRIPTION
ecraca2 returns the coefficient a2 of the actual model representing the elliptic
curve E/Q.
.TP 4
.B E1
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ecraca2       : 930531.941201
H*/
/*
	For the definition of ecraca2 please refer to the header file _ec1.h.
*/
