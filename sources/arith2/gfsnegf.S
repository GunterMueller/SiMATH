/*M
.SH NAME
gfsnegf - Galois-field with single characteristic negation as function

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsnegf(p, AL, a)  
single p; 
list AL; 
gfel a;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a
is an element in GF(p^n), represented as univariate polynomial over Z/pZ of degree < n.
.PP 
gfsnegf returns the same result as the macro gfsneg, namely the additive inverse element of a in GF(p^n).  

.SH SEE ALSO
 gfsalgen
 gfsneg

M*/                                 

/*H
	Version 1       12.09.1990	Th. Weis
   DATE gfsnegf       : 910915
H*/

#include <_arith2.h>

gfel gfsnegf( p, AL, a )
single p;
list   AL;
gfel   a;

{
	return( pmsneg( 1, p, a ) );
}
