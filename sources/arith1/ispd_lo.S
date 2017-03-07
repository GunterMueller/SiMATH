/*M
.SH NAME
ispd_lo - integer small prime divisors ( lists only )

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ispd_lo(N,pM)
int N,*pM;

.SH DESCRIPTION
ispd_lo is identical to ispd, but
the computation is completely performed within the SIMATH memory
management, i.e. using only lists and no arrays.
M*/
/*H
	Version 1       16.06.1992	Marc Conrad  (altes ispd)
   DATE ispd_lo       : 921130
H*/


# include <_arith1.h>

list ispd_lo(N,pM)
int N,*pM;
{
	list F;
	int Q,M;
	single p,r,*L1;

	bind(N);
	init(F,Q,M);

	F = _0;
	M = N;
	L1 = LIST_SP;
	do {
		p = *L1;
		if ( M < BASIS ) {
			Q = M / p;
			r = M % p;
		}
		else isqrem(M,p,&Q,&r);
		if ( r == 0 ) {
			F = lcomp(p,F);
			M = Q;
		}
		else L1++;
	}
	while ( Q > p && *L1 != 0 );
	if ( Q <= p && M != 1 ) {
		F = lcomp(M,F);
		M = 1;
	}
	*pM = M;
	return(linv(F));
}
