/*M
.SH NAME
itoEsb - ( SIMATH ) integer to Essen integer, sign and upper bound

.SH SYNOPSIS
.nf
#include<_arith1.h>

single itoEsb(A,e,grenze)
int A;
LONG e[];
single grenze;

.SH DESCRIPTION
itoEsb() converts the SIMATH integer 
A to the Essen integer e for grenze <= LAENGE
an returns the sign of the result.
If |A| => 2^(32 * (grenze-1) then
an overflow has occurred, 
the value of e is undefined and the
return code is 2.

.SH SEE ALSO
Etoi, Etoineg, itoE, itoEb.
M*/
/*H
	Version  1      24.12.1991	Marc Conrad
   DATE itoEsb        : 920331.9211__
H*/


#include<_arith1.h>
#include<_Earith.h>

single itoEsb(A, e, grenze)
	LONG *e;
int A;
single grenze;

{
	single s;

/*  s = signum( A )  */

	if (!A) {
		e[0] = 0;
		e[1] = 0;
		s = 0;
	} else if (issingle(A)) {
		e[0] = 1;
		if (grenze < 1)
			return (2);
		else if (A > 0)
			e[1] = (unsigned) A, s = 1;
		else
			e[1] = (unsigned) -A, s = -1;
	} else {
		LONG *pe;
		unsigned a, b, c, d, k = 0, l = 30, z = 0;
		single u;

		pe = e + 1;
		u = lfirst(A);
		if (!u)
			a = 0, s = 0;
		else if (u < 0)
			a = (unsigned) (-u), s = -1;
		else
			a = (unsigned) u, s = 1;

		A = lred(A);
		while (A != _0) {
			u = lfirst(A);
			if (s < 0)
				b = (unsigned) (-u);
			else if (s > 0)
				b = (unsigned) u;
			else {
				if (!u)
					b = 0;
				else if (u < 0)
					b = (unsigned) (-u), s = -1;
				else
					b = (unsigned) u, s = 1;
			}


			A = lred(A);
			c = (a >> k);
			d = (b << l);
			if (++z >= grenze) {
				return (2);
			}
			*(pe++) = c | d;
			k += 2;
			l -= 2;
			if (l == 0) {
				k = 0;
				l = 30;
				if (A != _0) {
					u = lfirst(A);
					if (s < 0)
						a = (unsigned) (-u);
					else if (s > 0)
						a = (unsigned) u;
					else {
						if (!u)
							a = 0;
						else if (u < 0)
							a = (unsigned) (-u), s = -1;
						else
							a = (unsigned) u, s = 1;
					}

					A = lred(A);
				} else
					goto fertig;
			} else
				a = b;
		}
		c = (a >> k);
		if (c)
			*(pe++) = c, z++;
fertig:
		e[0] = z;
		if (z >= grenze) {
			return (2);
		}
	}
	return (s);
}
