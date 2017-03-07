/*M
.SH NAME
pmitrans - polynomial over modular integers translation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmitrans(r, M, P, A)  
single r; 
int M, A; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P
is a polynomial in r variables over Z/(M*Z).
.TP 4
.B A
is an element of Z/(M*Z).
.PP
pmitrans returns the polynomial P1 in r variables over Z/(M*Z), where
.IP                                                                             
P1(X1, ..., Xr) = P(X1, ..., X(r-1), Xr+A ).    

.SH SEE ALSO
pmitransav

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmitrans      : 910915
H*/

#include <_pol1.h>

pol pmitrans(r,m,P,a)
single r;
int m;
pol P;
int a;
{
	single e;
	pol H1, H2, P1, k;
	bind(m,P,a);
	init(H1,H2,P1,k);

/* P gleich 0 oder a gleich 0 */

	if (!P  ||  !a) P1 = P;

/* allgemeiner Fall */

	else {
		P1 = 0;
		while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			H1 = list2(0,k);
			P1 = pmisum(r,m,P1,H1);
			if (P != _0) e -= lfirst(P);
			for ( ; e; e--) {
				H1 = ppmvprod(r,P1,1);
				H2 = pmimiprod(r,m,P1,a);
				P1 = pmisum(r,m,H1,H2);
			}
		}
	}

/* Ausgabe */

	return(P1);
}
