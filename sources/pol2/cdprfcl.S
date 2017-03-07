/*M
.SH NAME
cdprfcl - common denominator polynomial over the rationals from coefficient list

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdprfcl(L) 
list L;
  
.SH DESCRIPTION
Let a(n) * x^n + ... + a(0) * X^0 be a polynomial over the rational numbers, d be the l.c.m. of the denominators of the coefficient not equal to zero, and for 0 <= i <= n let
.IP
b(i) = d * a(i).
.PP
Then (d b(n) ... b(1)) is a 'coefficient list' of the polynomial above.
.PP
Let m be the number of the b(i)'s, not equal to zero, and let  0 <= e(1) < ... < e(m) <= n that numbers, for which b(e(i)) is not equal to zero.
.PP
Then (d e(m) b(e(m)) ... e(1) b(e(1)) ) is a list, representing the polynomial above as a CD-polynomial.
.PP
The zero polynomial as CD-polynomial will also represented by the 0 atom.
A 'coefficient list' of the zero polynomial is in the shape (d 0 ... 0), where d is an integer number not equal to 0 and the lenght of the list is greater or equal 2.  
.TP 4
.B L
is a 'coefficient list' of a polynomial (say P).
.PP
cdprfcl returns the polynomial P as a CD-polynomial.
 
M*/
                             
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdprfcl       : 891101.9011__
H*/

#include<_pol2.h>

pol cdprfcl(L)
list L;
{
	pol P;
	single n;
	int d;
	init(d,P);
	bind(L);

	d = lfirst(L);
	L = lred(L);
	while ( (lfirst(L) == 0) && (lred(L) != _0) ) { L = lred(L); }
	if ( lfirst(L) == 0 ) return(0);

	n = llength(L) - 1;
	P = lcomp(n,L);
	P = dptop(1,P);
	P = lcomp2(1,d,P);
	P = picontpp(1,P,&d);
	return(lred(d));
}
