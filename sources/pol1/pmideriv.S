/*M
.SH NAME
pmideriv - polynomial over modular integers derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmideriv(r, M, P)  
single r; 
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
.PP

pmideriv returns the derivation of P with respect to the main variable.

M*/

/*H
	Version 1	23.07.91	J.Schmitt
   DATE pmideriv      : 910915
H*/

#include <_pol1.h>

pol pmideriv(r,M,P)
single r;
int M;
pol P;
{
	single e,e1;
	pol P1, k;
	bind(M,P);
	init(P1,k);

	if ( !P ) return(0);
	r--;
	P1 = _0;
	do {
		e  = lfirst(P);
		P  = lred(P);
		k  = lfirst(P);
		P  = lred(P);
		e1 = mihom(M,e);
		e--;
		if (r) k = pmimiprod(r,M,k,e1);
		else   k = miprod(M,k,e1);
		if (k) P1 = lcomp2(k,e,P1);
	} while (P != _0);
	if (P1 == _0) P1 = 0;
	else P1 = linv(P1);

	return(P1);
}
