/*M
.SH NAME
pigfcb - polynomial over integers Gelfond-factor coefficient bound

.SH SYNOPSIS
.nf
#include<_pol2.h>

single pigfcb(r, P) 
single r; 
pol P;
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in the r variables X1,...,Xr over the integer numbers.
.PP
For 1 <= i <= r, let
.IP
 di be the degree of P with regard to Xi,
 ni = max(0,2*di-1),
 s  = ( n1 + ... + nr ) / 2,      
.PP
then, pigfcb returns the integer number B, whereat
.IP
B = 2^s * sumnorm(P).

M*/

/*H
	Version 1       05.05.1989      A.Stein
   DATE pigfcb        : 891101
H*/


#include <_pol2.h>

int pigfcb(r,P)
single r;
pol P;
{
	single s,d;
	int B;
	list DV;
	bind(P);
	init(B,DV);

/* Berechnung von a */

	B = pisumnorm(r,P);
	DV = pdegvec(r,P);
	for( s = 0; DV != _0 ; DV = lred(DV) ) {
		d = lfirst(DV);
		if (d)  s += d + d - 1;
	}
	s = (s+1)/2;
	B = ip2prod(B,s);

/* Ausgabe */

	return(B);
}
