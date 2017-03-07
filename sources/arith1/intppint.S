/*M
.SH NAME
intppint - integer P-part with respect to an integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

int intppint(P,A)
int P,A;

.SH DESCRIPTION
For P prime and A!=0 intppint() returns the maximum power N of P with N | A.
M*/

/*H
	Version 1       06.08.91	J.Schmitt
   DATE intppint      : 910915
H*/

#include<_arith1.h>

int intppint(M,A)
int M,A;
{
	int R,MP,Q;
	init(R,MP,Q);
	bind(M,A);

	MP = A;
	R  = 0;
	while ( !R ) {
		iqrem(MP,M,&Q,&R);
		if ( !R ) MP = Q;
	}
	R = iquot(A,MP);
	return(R);
}
