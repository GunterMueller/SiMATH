/*M
.SH NAME
sclfuprfmsp1 - special coefficient list from univariate polynomial over rationalfunctions over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_pol4.h>

list sclfuprfmsp1(P, n) 
pol P; 
single n;

.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the rational function field over Z/(pZ) (p single prime number).
.TP 4
.B n
is a positive number, deg(P) < n < BASIS.
.PP
sclfuprfmsp1 returns the special coefficient list of P of length n.

.SH SEE ALSO
uprfmsp1fscl 

M*/
           
/*H
	Version 1       15.10.89        J.Schmitt
   DATE sclfuprfmsp1  : 901120
H*/

#include<_pol4.h>

list sclfuprfmsp1(P,n)
pol P;
single n;
{                           
	pol P1;
	single m,i;
	init(P1);
	bind(P);

	if ( P == 0 ) {
		P = _0;
		for (i=0;i<n;i++) { P = lcomp(0,P); }
		return(P);
	}
	P = ptodp(1,P);
	m = lfirst(P);
	m = m + 1;
	P = lred(P);
	for (i=(n - m); i>0; i--) { P = lcomp(0,P); }
	P1 = lcinv(P);
	return(P1);
}
