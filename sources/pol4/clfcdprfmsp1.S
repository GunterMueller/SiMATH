/*M
.SH NAME
clfcdprfmsp1 - coefficient list from common denominator polynomial over rational functions over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_pol4.h>

list clfcdprfmsp1(P, n) 
pol P; 
single n;
  
.SH DESCRIPTION
.TP 4
.B P
is a CD-polynomial (s. cdprfmsp1fcl).
.TP 4
.B n
is a natural number, deg(P) < n < BASIS.
.PP
clfcdprfmsp1 returns a coefficient list of P of lenght n+1.
 
.SH SEE ALSO
cdprfmsp1fcl

M*/
               
/*H
	Version 1       15.10.89        J.Schmitt
   DATE clfcdprfmsp1  : 901120
H*/

#include<_pol4.h>

list clfcdprfmsp1(P,n)
pol P;
single n;
{
	single m,i;
	pol d;
	bind(P);
	init(d);              

	if (P==0) {
		P = _0;
		for (i=0;i<n;i++) { P=lcomp(0,P); }
		P = lcomp(list2(0,1),P);
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
