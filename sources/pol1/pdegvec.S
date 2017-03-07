/*M
.SH NAME
pdegvec - polynomial degree vector, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

list pdegvec(r, P) 
single r; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables X1, ..., Xr.
.PP
pdegvec returns a list L = (Gr, ...,G1), where
 for 1 <= n <= r :
.IP 
Gn is the degree of P with regard to the variable Xn.
.PP
For P = 0, L = ( 0, ..., 0 ).

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       17.11.1987      vecmax -> lsmaxs BW MAR
   DATE pdegvec       : 890501
H*/


#include <_pol1.h>

list pdegvec(r,P)
single r;
pol P;
{
	single g;
	list L, L1;
	pol P1;
	bind(P);
	init2(L,L1);

/* P ungleich 0 */

	if (P) {
		g = lfirst(P);
		if (r == 1) L = list1(g);
		else {
			r--;
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			L = pdegvec(r,P1);
			while (P != _0) {
				P = lred(P);
				P1 = lfirst(P);
				P = lred(P);
				L1 = pdegvec(r,P1);
				L = lsmaxs(L,L1);
				}
			L = lcomp(g,L);
			}
		}

/* P gleich 0 */

	else {
		L = _0;
		for ( ; r; r--) L = lcomp(0,L);
		}

/* Ausgabe */

	return(L);
}
