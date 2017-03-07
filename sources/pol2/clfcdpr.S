/*M
.SH NAME
clfcdpr - coefficient list from common denominator polynomial over the rationals

.SH SYNOPSIS
.nf
#include<_pol2.h>

list clfcdpr(P, n) 
pol P; 
single n;

.SH DESCRIPTION
.TP 4
.B P
is a CD-polynomial (s.cdprfcl) over the rational numbers.
.TP 4
.B n
is an integer number, deg(P) < n < BASIS.
.PP
clfcdpr returns the 'coefficient list' of P (s.cdprfcl) with lenght n+1.
 
.SH SEE ALSO
cdprfcl

M*/
    
/*H
	Version 1       15.05.89        J.Schmitt
   DATE clfcdpr       : 891101
H*/

#include<_pol2.h>

list clfcdpr(P,n)
pol P;
single n;
{
	single m,i;
	int d;
	bind(P);
	init(d);              

	if (P==0) {
		P = _0;
		for (i=0;i<n;i++) { P=lcomp(0,P); }
		P = lcomp(1,P);
		return(P);
	}
	d = lfirst(P);
	P = lred(P);
	P = ptodp(1,P);
	m = lfirst(P);
	m = m+1;
	P = lred(P);
	for (i=(n-m);i>0;i--) { P=lcomp(0,P); }
	P = lcomp(d,P);
	return(P);
}
