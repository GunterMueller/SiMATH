/*M
.SH NAME
mihoms - modular integer homomorphism, symmetric residue system

.SH SYNOPSIS
.nf
#include<_arith1.h>

int mihoms(M,A)
int M,A;

.SH DESCRIPTION
mihoms() returns the representative of A
in the symmetric residue system Z/MZ for M>0.
M*/

/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2   	18.05.1992	R gebunden, ip2prod.  MC
   DATE mihoms        : 890501.921130
H*/


# include <_arith1.h>

int mihoms(M, A)
	int M, A;
{
	int Q, R;

	bind(M);
	init(R);

	iqrem(A, M, &Q, &R);
	if (isign(R) < 0)
		R = isum(R, M);
	if (icomp(ip2prod(R, 1), M) > 0) {
		R = idif(R, M);
	}
	return (R);
}
