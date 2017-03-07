/*M
.SH NAME
dpdegvec - dense polynomial degree vector, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dpdegvec(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B P
is a dense polynomial in the r variables X1, ..., Xr.
.PP
dpdegvec returns a list L = ( Gr, ..., G1 ), where
Gn is the degree of P with regard to the variable Xn.
.PP
If P = 0, dpdegvec returns 0.

M*/

/*H
	Version 1       03.06.1987      B. Weis
	Version 2       17.11.1987      vecmax -> lsmaxs  BW MAR
	Version 3       07.08.1991      Prozedur hiess bislang versehentlich
					dpdegree.  JS
   DATE dpdegvec      : 890501.910915
H*/


#include <_pol1.h>

list dpdegvec(r,P)
single r;
pol P;
{
	single g;
	pol P1;
	list L, L1;
	bind(P);
	init(L,L1);

/* P ungleich 0 */

	if (P) {
		g = lfirst(P);
		if (r == 1) L = list1(g);
		else {
			r--;
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			L = dpdegvec(r,P1);
			while (P != _0) {
				P1 = lfirst(P);
				P = lred(P);
				if (P1) {
					L1 = dpdegvec(r,P1);
					L = lsmaxs(L,L1);
					}
				}
			L = lcomp(g,L);
			}
		}

/* P gleich 0 */

	else {
		L =_0;
		for (; r; r--) L = lcomp(0,L);
		}

/* Ausgabe */

	return(L);
}
