/*M
.SH NAME
mshom - modular single homomorphism

.SH SYNOPSIS
.nf
#include<_arith1.h>

single mshom(m,A)
single m;
int A;

.SH DESCRIPTION
mshom()  returns the representative of A
in the positive residue system Z/mZ for m>0.
M*/

/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      16.14.1991      komplett neu.  GL
	Version  3	20.02.1992	leicht verbessert.  GL & MC.
   DATE mshom         : 890501.911215.920331
H*/


# include <_arith1.h>

int mshom(sm, n)
single sm;
int n;
{
	single sgn;
	register b, m, mm, nn, erg;

	sgn = isign(n);

	m = (unsigned) sm;

	if (isatom(n))
		erg = (sabs(n)) % m;
	else {
		for (erg = 0, mm = 1; n != _0; n = lred(n)) {
			nn = sabs(lfirst(n));
			for (b = 1; b != _0; b <<= 1) {
				if (b & nn)
					if ((erg += mm) >= m)
						erg -= m;
				if ((mm <<= 1) >= m)
					mm -= m;
			}
		}
	}

	return ((sgn < 0 && erg) ? m - erg : erg);
}
