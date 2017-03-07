/*M
.SH NAME
rtomi - rational number to modular integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rtomi(R,M)
rat R,intM;

.SH DESCRIPTION
rtomi() returns the rational number R
reduced modulo M. Let R = Z/N, then to
result of rtomi() is Z *  N^(-1) modulo M
if N in (Z/MZ)* and 0 otherwise.
M*/
/*H  
	Version 1	15.02.1992	Marc Conrad        
	Version 2 	05.10.1992	Doku verbessert.  MC
   DATE rtomi         : 920331.921130
H*/


#include<_arith1.h>

int rtomi(R, M)
	int R, M;
{
	if (!R)
		return (0);
	else {
		int Z, N;

		bind(R, M);
		init(Z, N);

		Z = mihom(M, lfirst(R));
		N = mihom(M, lsecond(R));
		N = miinv(M, N);
/* gcd( N, M ) != 1 => miinv(...) = 0 */
		Z = miprod(M, Z, N);
		return (Z);
	}
}
