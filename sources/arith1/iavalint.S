/*M
.SH NAME
iavalint - integer additive value with respect to integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

single iavalint(M,I)
int M,I;

.SH DESCRIPTION
For M >1 and I!=0
iavalint() returns the additive m-adic value of,
i.e. the maximum number w with  M^w | I.
M*/
/*H
	Version 1	05.08.91	J.Schmitt
   DATE iavalint      : 910915.9301__
H*/

# include <_arith1.h>

single iavalint(P,M)
int P,M;
{
	single r, w;
	bind(P,M);

	w = -1;
	r = 0;
	if ( issingle(P) ) {
		while( !r ) {
			isqrem(M,P,&M,&r);
			w = w + 1;
		}
	}
	else {  
		int R=0;
		bind(R);
		while( !R ) {
			iqrem(M,P,&M,&R);
			w = w + 1;
		}
	}
	return( w );
}
