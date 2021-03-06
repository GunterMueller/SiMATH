/*M
.SH NAME
ecraca1 - elliptic curve over rational numbers, actual curve, a1

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecraca1(E1)
list E1;

.SH DESCRIPTION
ecraca1 returns the coefficient a1 of the actual model representing the elliptic curve E/Q.
.TP 4                                                                           
.B E1                                                                           
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.  
   
.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ecraca1       : 930531.941201
H*/
/*
	For the definition of ecraca1 please refer to the header file _ec1.h.
*/
