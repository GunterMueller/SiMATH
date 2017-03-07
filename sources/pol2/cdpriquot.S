/*M
.SH NAME
cdpriquot - common denominator polynomial over the rationals integer quotient

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdpriquot(P, I) 
pol P; 
int I; 
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate CD-polynomial over the rational numbers (s.cdprfcl).
.TP 4
.B I
is an integer number, I != 0.
.PP
cdpriquot returns the polynomial P1 (say) as CD-polynomial, where 
.IP
P1 = P / I.

.SH SEE ALSO
cdprfcl

M*/
         
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdpriquot     : 891101
H*/

#include<_pol2.h>

pol cdpriquot(P,I)
pol P;
int I;
{
	int C;
	pol P1,P2;
	init(P1,P2,C);
	bind(P,I);

	if ( P == 0 ) return(0);
	C = iprod(lfirst(P),I);
	P = lred(P);
	P1 = lcomp2(1,C,P);
	if ( isign(I) == (-1) ) { P1 = pineg(1,P1); }
	P1 = picontpp(1,P1,&P2);
	return(lred(P2));
}
