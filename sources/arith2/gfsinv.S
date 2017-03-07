/*M
.SH NAME
gfsinv - Galois-field with single characteristic inverse

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsinv(p, AL, a)  
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
is an element in GF(p^n), represented as univariate polynomial over Z/pZ of degree < n, a != 0.
.PP
gfsinv returns the multiplicative inverse element of a in GF(p^n).

.SH SEE ALSO
gfsalgen

M*/
                                   
/*H
	Version 1       17.08.1987              Pascale Serf
	Version 2       04.12.1987              UP statt Macro   PS
	Version 3       07.12.1987              Liste AL statt Pol. G    PS
   DATE gfsinv        : 890501
H*/


# include <_arith2.h>

gfel gfsinv(p,AL,a)
single p;
list AL;
gfel a;
{
	pol P,G;

	bind2(AL,a);
	init2(P,G);

	G = lfirst(AL);
	upmshegcd(p,G,a,&P);
	return(pmsrem(1,p,P,G));
}
