/*M
.SH NAME
pmiderivsv - polynomial over modular integers derivation, specified variable, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmiderivsv(r, M, P, n)  
single r,n; 
int M; 
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
.B n
is an integer number, 0 < n <= r.
.PP
pmiderivsv returns the derivation of P with respect to the n-th variable of P.
 
M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmiderivsv    : 910915
H*/

#include <_pol1.h>

pol pmiderivsv(r,m,P,n)
single r;
int m;
pol P;
single n;
{
	single e;
	pol P1, k;
	bind(m,P);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (n == r) P1 = pmideriv(r,m,P);

/* allgemeiner Fall: n ungleich r und P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pmiderivsv(r,m,k,n);
			if (k) P1 = lcomp2(k,e,P1);
		} while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
	}

/* Ausgabe */

	return(P1);
}
