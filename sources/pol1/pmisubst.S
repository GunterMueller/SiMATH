/*M
.SH NAME
pmisubst - polynomial over modular integers substitution, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmisubst(r, M, P1, P2)  
single r; 
int M; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P1
is a polynomial in r variables over Z/(M*Z).
.TP 4
.B P2
is a polynomial in r-1 variables over Z/(M*Z).
.PP
pmisubst returns the polynomial P3 in r-1 variables over Z/(M*Z), where
.TP 16                                                                          
P3 = P1(P2),                                                                    
(the substitution of the main variable of P1 by P2).

.SH SEE ALSO
pmisubstsv

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmisubst      : 910915
H*/

#include <_pol1.h>

pol pmisubst(r,m,P1,P2)
single r;
int m;
pol P1;
pol P2;
{
	single e, e1;
	pol P3, k;
	bind(m,P1,P2);
	init(P3,k);

/* P1 gleich 0 */

	if (P1 == 0) P3 = 0;
                                            
/* r gleich 1 */

	else if (r == 1) P3 = pmieval(r,m,P1,P2);

/* allgemeiner Fall: P1 ungleich 0, r ungleich 1 */

	else {
		r--;
		e = lfirst(P1);
		P1 = lred(P1);
		P3 = lfirst(P1);
		P1 = lred(P1);
		while (P1 != _0) {
			e1 = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 =lred(P1);
			for (e -= e1; e; e--) P3 = pmiprod(r,m,P3,P2);
			P3 = pmisum(r,m,P3,k);
			e = e1;
		}
		for (; e; e--) P3 = pmiprod(r,m,P3,P2);
	}

/* Ausgabe */

	return(P3);
}
