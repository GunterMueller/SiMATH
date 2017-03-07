/*M
.SH NAME
flprod - floating point product

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flprod(f,g)
floating f,g;

.SH DESCRIPTION
flprod() returns f * g.
M*/
/*H
	Version 1	18.03.91	Marc Conrad     
	Version 2	11.03.92	iprod statt iprodk wegen E-Arithm.  MC
   DATE flprod        : 910715.920331
H*/

#include<_arith1.h>

floating flprod(f, g)
	floating f, g;
{
	if (!f || !g)
		return (0);
	else {
		int ergm;
		single exp, ergl;
		single l1, l2;

		bind(f, g);
		init(ergm);

		/* Falls einer der Faktoren = 0 ist */

		exp = flexpo(f) + flexpo(g);

		f = lred(f);
		g = lred(g);

		/***    Sonderfaelle    ***/
		if (lred(f) == _0) {
			if (lred(g) == _0) {
				single c, d;

				sprod(lfirst(f), lfirst(g), &d, &c);
				if (d)
					ergm = list2(c, d), ergl = 2;
				else
					ergm = c, ergl = 1;
			} else {
				ergm = isprod(g, lfirst(f));
				ergl = llength(ergm);
			}
		} else if (lred(g) == _0) {
			ergm = isprod(f, lfirst(g));
			ergl = llength(ergm);
		} else {
			ergm = iprod(f, g);
			ergl = llength(ergm);
		}

		return (flcut(ergm, exp, ergl));
	}
}
