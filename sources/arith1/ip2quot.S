/*M
.SH NAME
ip2quot - integer power of 2 quotient

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ip2quot(A,n)
int A;
single n;

.SH DESCRIPTION
ip2quot() returns the integer part of  A / 2^n for n >= 0.
M*/
/*H
	Version  1      11.08.1986      R.Boeffgen      
	Version  2 	19.05.1992	beschleunigt.  MC
   DATE ip2quot       : 890501.921130
H*/


# include <_arith1.h>

int ip2quot(A, n)
	int A;
	single n;
{
	if (A == 0 || n == 0)
		return (A);
	else {
		single q = n / BLOG2, r = n % BLOG2;

		if (isatom(A)) {
			if (q)
				return (0);
			else if (A > 0)
				return (A >> n);
			else
				return (-((-A) >> n));
		} else {
			while (q--) {
				A = lred(A);
				if (A == _0)
					return (0);
			}
			if (lred(A) == _0) {
				A = lfirst(A);
				if (A > 0)
					return (A >> r);
				else
					return (-((-A) >> r));
			}
			if (r) {
				A = ip2prod(A, BLOG2 - r);
				A = lred(A);
				if (lred(A) == _0) {
					A = lfirst(A);
				}
			}
			return (A);
		}
	}
}
