/*M
.SH NAME
cdprzmodhom - ommon denominator polynomial over the rationals Z-module homomorphism

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdprzmodhom(P, M)  
pol P; 
int M;

.SH DESCRIPTION
.TP 4
.B P
is an univariate CD-polynomial (s.cdprfcl) over the rational numbers.
.TP 4
.B M
is an integer number, M > 0.
.PP
cdprzmodhom returns the univariate CD-polynomial P1 (say) over the rational numbers, where
.IP
P1(x) = P(x) mod (M * Z[x]).

.SH SEE ALSO
cdprfcl

M*/
                 
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdprzmodhom   : 891101.9001__.9211__
H*/

#include<_pol2.h>

pol cdprzmodhom(P,M)
pol P;
int M;
{
	int al, N;
	pol P1;
	init(al,N,P1);
	bind(P,M);

	if ( P == 0 ) return(P);
	al = lfirst(P);
	P = lred(P);
	N = iprod(al,M);
	P = pitopmi(1,P,N);
	if ( P == 0 ) return(P);
	P = lcomp2(1,al,P);
	N = picontpp(1,P,&P1);
	return(lred(P1));
}
