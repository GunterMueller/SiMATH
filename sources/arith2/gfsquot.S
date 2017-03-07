/*M
.SH NAME
gfsquot - Galois-field with single characteristic quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsquot(p, AL, a, b)  
single p;  
list AL;  
gfel a, b;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a, b
are elements in GF(p^n), represented as univariate polynomials over Z/pZ of degree < n, b != 0.
.PP 
gfsquot returns an element of GF(p^n), say c, where
.IP
c = a / b.

.SH SEE ALSO
gfsalgen

M*/
                 
/*H
	Version 1       17.08.1987              Pascale Serf
	Version 2       07.12.1987              UP statt Macro
						Liste AL statt Pol. G    PS
   DATE gfsquot       : 890501
H*/


# include <_arith2.h>

gfel gfsquot(p,AL,a,b)
single p;
list AL;
gfel a,b;
{
	pol G;

	bind3(AL,a,b);
	init(G);

	G = lfirst(AL);
	b = gfsinv(p,AL,b);
	return(gfsprod(p,AL,a,b));
}
