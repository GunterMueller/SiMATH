/*M
.SH NAME
nfprod - number field element product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfprod( F, a, b )     
pol F; 
nfel a, b;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a, b
are elements of K (for representation of number field elements s. nfneg). 
.PP
nfprod returns an element of K, say c, where
.IP
c = a * b.

.SH SEE ALSO
nfneg

M*/
      
/*H
	Version 1       16.08.1988      Pascale Serf
   DATE nfprod        : 890601.9011__
H*/

# include <_arith2.h>

nfel nfprod(F,a,b)
pol F;
nfel a,b;
{
	nfel c = 0;
	int HNa,HNb,HNc = 1;
	single r,n;

	bind(F,a,b,c,HNc);
	init(HNa,HNb);

	if ( a && b ) {
	    HNa = lfirst(a); a = lred(a);
	    HNb = lfirst(b); b = lred(b);
	    c = udpiprod(a,b);
	    r = lfirst(c);
	    n = lfirst(F);

	    /*** gegebenenfalls mod F reduzieren. ***/
	    if ( r >= n ) {
		c = udpipsrem(c,F);
		HNc = iexp(lsecond(F),r-n+1);
	    }
	    HNc = iprod(HNc,iprod(HNa,HNb));
	    c = lcomp(HNc,c);
	    c = nfelnormal(c);
	}

	return(c);

}
