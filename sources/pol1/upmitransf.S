/*M
.SH NAME
upmitransf - univariate polynomial over modular integers transformation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmitransf(m, P1, r, P2)  
int m; 
pol P1, P2; 
single r;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B m
is an integer number, m > 0.       
.TP 4
.B P1 
is a univariate polynomial over Z/mZ.
.TP 4
.B P2 
is a polynomial in r variables over Z/mZ.
.PP
upmitransf returns the polynomial P3, which arises from the substitution of the variable in P1 by P2.
 
M*/

/*H
	Version 1	26.07.91	J.Schmitt
   DATE upmitransf    : 910915
H*/


#include <_pol1.h>

pol upmitransf(M,P,r,P1)
int M;
single r;
pol P,P1;
{
	single ZW_E,e,k,i;
	pol Q1,Q2,ZW_P;
	init(Q1,Q2,ZW_P);
	bind(M,P,P1);

	ZW_P = P1;
	ZW_E = 1;
	Q1   = 0;
	if ( P == 0 ) return(P);
	P    = lcinv(P);
	while ( P != _0 )     {
		k = lfirst(P);
		P = lred(P);
		e = lfirst(P);
		P = lred(P);
		if( e == 0 ) { 
			Q1=list2(0,k);
			for(i=1;i<r;i++) Q1=list2(0,Q1);
		}
		while ( ZW_E < e ) {
			ZW_P = pmiprod(r,M,ZW_P,P1);
			ZW_E++;
		}
		if( e != 0 ) {
			Q2 = pmimiprod(r,M,ZW_P,k);
			Q1 = pmisum(r,M,Q1,Q2);
		}
	}
	return(Q1);
}
