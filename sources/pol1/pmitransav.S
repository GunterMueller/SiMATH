/*M
.SH NAME
pmitransav - polynomial over modular integers translation, all variables, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmitransav(r, M, P, L)  
single r; 
int M; 
pol P; 
list L;

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
.B L                                                                            
.SM = ( Ar ... A2 A1 )     int A1, ..., Ar;                                     
 is a list of r elements of Z/(M*Z).
.PP
pmitransav returns the polynomial P1 in r variables over Z/(M*Z), where
.IP                                                                             
P1(X1, X2, ...,Xr) = P(X1+A1, X2+A2, ..., Xr+Ar).

.SH SEE ALSO
pmitrans

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmitransav    : 910915
H*/

#include <_pol1.h>

pol pmitransav(r,m,P,Lmi)
single r;
int m;
pol P;
list Lmi;
{
	single e;
	int a;
	pol P1, P1S, k;
	bind(m,P,Lmi);
	init(a,P1,P1S,k);

/* Translation der Hauptvariablen */

	a  = lfirst(Lmi);
	P1 = pmitrans(r,m,P,a);
	Lmi = lred(Lmi);

/* Translation der Nebenvariablen */

	r--;
	if (r  &&  P1) {
		P1S = _0;
		while (P1 != _0) {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			k = pmitransav(r,m,k,Lmi);
			P1S = lcomp2(k,e,P1S);
		}
		P1 = linv(P1S);
	}

/* Ausgabe */

	return(P1);
}
