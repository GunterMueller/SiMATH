/*M
.SH NAME
uprfmsp1fcdp - univariate polynomial over rational functions over modular single prime, transcendence degree 1, from common denominator polynomial over rational functions over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol uprfmsp1fcdp(p, P) 
single p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4 
.B P
is an univariate CD-polynomial over the rational func-tion field over Z/(pZ) (s. cdprfmsp1fcl).
.PP
uprfmsp1fcdp returns P in sparse representation.

.SH SEE ALSO
cdprfmsp1fcl

M*/
                   
/*H
	Version 1       15.10.89        J.Schmitt
   DATE uprfmsp1fcdp  : 901120
H*/

#include<_pol4.h>

pol uprfmsp1fcdp(p,P)
single p;
pol P;              
{
	pol P1,P2,P3,Al;
	single e;
	init(P1,P2,P3,Al);
	bind(P);

	if ( P == 0 ) return(0);
	Al = lfirst(P);
	P  = lred(P);
	P3 = _0;
	while ( P != _0 ) {
		e  = lfirst(P);
		P  = lred(P);
		P1 = lfirst(P);
		P  = lred(P);
		P2 = upmsgcd(p,P1,Al);
		P1 = pmsquot(1,p,P1,P2);
		P2 = pmsquot(1,p,Al,P2);
		P2 = list2(P1,P2);
		P3 = lcomp2(P2,e,P3);
	}
	P3 = linv(P3);
	return(P3);
}
