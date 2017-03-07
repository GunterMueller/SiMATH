/*M
.SH NAME
itoEb - ( SIMATH ) integer to Essen integer with upper bound

.SH SYNOPSIS
.nf
#include<_arith1.h>

single itoEb(A,e,grenze)
int A;
LONG e[];
single grenze;

.SH DESCRIPTION
itoEb() converts the SIMATH integer 
A to the Essen integer e for grenze <= LAENGE
an returns 0.
If |A| => 2^(32 * (grenze-1) then
an overflow has occurred, 
the value of e is undefined and the
return code is 1.

.SH SEE ALSO
Etoi, Etoineg, itoE, itoEsb.
M*/
/*H
	Version  1      24.04.1992	Marc Conrad
   DATE itoEb         : 921130
H*/


#include<_arith1.h>
#include<_Earith.h>

single itoEb(A, e, grenze)
	LONG *e;
	int A;
	single grenze;

{

	if (!A) {
		e[0] = 0;
		e[1] = 0;
	} else if (issingle(A)) {
		e[0] = 1;
		if (grenze < 1)
			return (1);
		else
			e[1] = (unsigned) A;
	} else {
		LONG *pe;
		unsigned a, b, c, d, k = 0, l = 30, z = 0;
		single u;

		pe = e + 1;
		u = lfirst(A);
		a = (unsigned) u;

		A = lred(A);
		while (A != _0) {
			u = lfirst(A);
			b = (unsigned) u;

			A = lred(A);
			c = (a >> k);
			d = (b << l);
			if (++z >= grenze) {
				return (1);
			}
			*(pe++) = c | d;
			k += 2;
			l -= 2;
			if (l == 0) {
				k = 0;
				l = 30;
				if (A != _0) {
					u = lfirst(A);
					a = (unsigned) (u);

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
			return (1);
		}
	}
	return (0);
}
