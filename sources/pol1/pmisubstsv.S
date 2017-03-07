/*M
.SH NAME
pmisubstsv - polynomial over modular integers substitution, specified variable, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmisubstsv(r, M, P1, n, P2)  
single r, n; 
int M; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <  r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P1
is a polynomial in r variables over Z/(M*Z).
.TP 4
.B n
is an integer number, 1 <= n <= r. 
.TP 4
.B P2
is a polynomial in n-1 variables over Z/(M*Z).
.PP
pmisubstsv returns the polynomial P3 in r-1 variables over Z/(M*Z), where
.TP 16                                                                          
P3 = P1(P2),                                                                    
(the substitution of the n-th variable of P1 by P2).

.SH SEE ALSO
pmisubst

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmisubstsv    : 910915
H*/

#include <_pol1.h>

pol pmisubstsv(r,m,P1,n,P2)
single r;
int m;
pol P1;
single n;
pol P2;
{
	single e;
	pol P3, k;
	bind(m,P1,P2);
	init(P3,k);

/* P1 gleich 0 */

	if (P1 == 0) P3 = 0;

/* n gleich r */

	else if (n == r) P3 = pmisubst(r,m,P1,P2);

/* allgemeiner Fall: P1 ungleich 0, n ungleich r */

	else {
		r--;
		P3 = _0;
		do {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			k = pmisubstsv(r,m,k,n,P2);
			if (k) P3 = lcomp2(k,e,P3);
		} while (P1 != _0);
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
	}

/* Ausgabe */

	return(P3);
}
