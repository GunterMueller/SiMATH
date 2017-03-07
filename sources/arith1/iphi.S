/*M
.SH NAME
iphi - integer Eulerian phi-value

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iphi(N)
int N;

.SH DESCRIPTION
iphi() returns the value of Euler function phi(N) for N>0.
Since N will be factorised the runtime may increase
dramatically for large values of N.
M*/
/*H
	Version 1       11.3.1987               Pascale Serf  
   DATE iphi          : 890501.8906__
H*/


# include <_arith1.h>

int iphi(N)
int N;
{
	int M,A;
	list L;
	single i;

	bind(N);
	init3(M,A,L);

	/***    Spezialfall : N = 1    ***/
	if ( N == 1 ) return(1);

	/***    allgemeiner Fall    ***/
	M = 1;
	L = ifact(N);
	while ( L != _0 ) {
		A = lfirst(L);
		i = 0;
		while ( L!=_0 && A==lfirst(L) ) {
			L = lred(L);
			i++;
		}
		M = iprod(M,idif(A,1));
		M = iprod(M,iexp(A,i-1));
	}
	return(M);
}
