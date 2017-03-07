/*M
.SH NAME
prtrans - polynomial over rationals translation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prtrans(r, P, A) 
single r; 
pol P; 
rat A;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.TP 4
.B A
is a rational number.
.PP
prtrans returns the polynomial P1 in r variables over the rational numbers, where
.IP                                                                             
P1(X1, ..., Xr) = P(X1, ..., X(r-1), Xr+A ).                                    
                                                                             
.SH SEE ALSO
prtransav

M*/

/*H
	Version 1       29.10.1987      B. Weis
   DATE prtrans       : 890501
H*/


#include <_pol1.h>

pol prtrans(r,P,A)
single r;
pol P;
rat A;
{
	single e;
	pol H1, H2, P1, k;
	bind2(P,A);
	init4(H1,H2,P1,k);

/* P gleich 0 oder A gleich 0 */

	if (!P  ||  !A) P1 = P;

/* allgemeiner Fall */

	else {
		P1 = 0;
		while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			H1 = list2(0,k);
			P1 = prsum(r,P1,H1);
			if (P != _0) e -= lfirst(P);
			for ( ; e; e--) {
				H1 = ppmvprod(r,P1,1);
				H2 = prrprod(r,P1,A);
				P1 = prsum(r,H1,H2);
				}
			}
		}

/* Ausgabe */

	return(P1);
}
