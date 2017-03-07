/*M
.SH NAME
cdprsum - common denominator polynomial over the rationals sum

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdprsum(P1, P2)  
pol P1, P2;
  
.SH DESCRIPTION
.TP 4
.B P1, P2
are univariate CD-polyomials over the rational numbers (s.cdprfcl).
.PP
cdprsum returns the CD-polynomial P3, where
.IP
P3 = P1 + P2.
   
.SH SEE ALSO
cdprfcl

M*/
           
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdprsum       : 891101.9001__.9311__
H*/

#include<_pol2.h>

pol cdprsum(P1,P2)
pol P1,P2;
{
	pol P;
	init(P);
	bind(P1,P2);

	P1 = uprfcdpr(P1);
	P2 = uprfcdpr(P2);
	P = prsum(1,P1,P2);
	P = cdprfupr(P);
	return(P);
}
