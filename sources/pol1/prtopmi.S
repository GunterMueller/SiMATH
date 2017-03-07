/*M
.SH NAME
prtopmi - polynomial over rationals to polynomial over modular integers, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prtopmi(r, P, M)  
single r; 
pol P; 
int M;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.TP 4
.B M
is an integer number, M > 0, the numerators of the coefficients of P must be coprime to M.
.PP
prtopmi returns the polynomial P as a polynomial over Z/(MZ).

M*/

/*H       
	Version 1	15.02.1992	Marc Conrad.
	Version 2 	17.07.1992	Fehler beseitigt.  MC
					ausserdem von 'pol2 (wo es ver-
					sehentlich stand) nach 'pol1.  PS
   DATE prtopmi       : 920331.921130
H*/


#include <_pol1.h>

pol prtopmi(r,P,M)
single r;
pol P;
int M;
{
	single e;
	pol P1, k;
	bind(M,P);
	init(P1,k);

	if (P == 0) P1 = 0;
	else if (r == 0) P1 = rtomi( P, M);
	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = prtopmi(r,k,M);
			else k = rtomi(k, M);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}
	return(P1);
}                                 





