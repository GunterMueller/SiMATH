/*M
.SH NAME
cdprinv - common denominator polynomial over the rationals inverse

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdprinv(F,A) 
pol F, A;

.SH DESCRIPTION
.TP 4
.B F 
is an univariate and monic polynomial over the rational numbers.
.TP 4
.B A 
is a CD-polynomial over the rational numbers (s.cdprfcl). F and A have no polynomial divisor of positive degree in common.
.PP
cdprinv returns the CD-polynomial B (say) over the rational numbers, so that there exists a polynomial L (say) over the rational numbers, with
.IP
A * B = 1 + F * L, i.e.
.IP
B = A^-1 mod F.
.PP
The degree of B is smaller than the degree of F.
 
.SH SEE ALSO
cdprfcl

M*/
                               
/*H
	Version 1       23.05.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					pdegree statt lfirst;
   DATE cdprinv       : 891101.900101
H*/

#include<_pol2.h>

pol cdprinv(F,A)
pol F,A;
{
	pol a1, a2, b, b1, q, r;
	init(a1,a2,b,b1,q,r);
	bind(F,A);

	a1 = pitopr(1,F);
	a2 = uprfcdpr(A);
	b = 0;
	b1 = itor(1);
	b1 = list2(0,b1);

	while ( pdegree(1,a2) ) {
		q = prqrem(1,a1,a2,&r);
		a1 = a2;
		a2 = r;
		r = prprod(1,q,b1);
		r = prdif(1,b,r);
		b = b1;
		b1 = r;
	}
	if ( a2 ) {
		r = rinv(lsecond(a2));
		b = prrprod(1,b1,r);
	}         
	b = cdprfupr(b);
	return(b);
}
