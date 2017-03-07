/*M
.SH NAME
gfsprod - Galois-field with single characteristic product

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsprod(p, AL, a, b)  
single p;  
list AL;  
gfel a,b;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a, b
are elements in GF(p^n), represented as univariate polynomials over Z/pZ of degree < n.
.PP
gfsprod returns an element of GF(p^n), say c, where
.IP
c = a * b.

.SH SEE ALSO
gfsalgen

M*/
         
/*H
	Version 1       17.08.1987              Pascale Serf
	Version 2       13.11.1987              UP statt Macro           PS
	Version 3       07.12.1987              Liste AL statt Pol. G    PS
   DATE gfsprod       : 890501
H*/


# include <_arith2.h>

gfel gfsprod(p,AL,a,b)
single p;
list AL;
gfel a,b;
{
	single i,k,n,c1;
	gfel c,ERG;
	pol d,P;
	list AL1;

	bind3(AL,a,b); init5(c,ERG,d,P,AL1);

	/*    Spezialfall : a*b = 0    */
	if ( !a || !b ) return(0);

	AL1 = lsecond(AL);
	n = llength(AL1) + 1;
	a = ptodp(1,a);
	b = ptodp(1,b);
	c = udpmsprod(p,a,b);
	k = lfirst(c);

	/*    Spezialfall : Grad(a*b) < n    */
	if ( k < n ) return(dptop(1,c));

	/*    allgemeiner Fall : Grad(a*b) >= n    */
	c = lred(c);
	for ( i=2*n-2 ; i>k ; i-- ) AL1 = lred(AL1);
	while ( AL1 != _0 ) {
		c1 = lfirst(c); c = lred(c);
		P = lfirst(AL1); AL1 = lred(AL1);
		if ( c1 ) {
			d = list2(0,c1);
			ERG = udpmssum(p,ERG,udpmsprod(p,d,P));
		}
	}
	i = 0;
	while ( lfirst(c) == 0 ) {
		c = lred(c);
		if ( c == _0 ) return(dptop(1,ERG));
		i++;
	}
	c = lcomp(n-1-i,c);
	ERG = udpmssum(p,ERG,c);
	return(dptop(1,ERG));
}
