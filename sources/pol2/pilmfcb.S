/*M
.SH NAME
pilmfcb - polynomial over integers Landau- Mignotte- factor coefficient bound

.SH SYNOPSIS
.nf
#include<_pol2.h>

single pilmfcb(r, P)  
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
 Bi the binomial coefficient of di/2 and di.
.PP
Then pilmfcb returns the integer number b, whereat
.IP
 b >= maxnorm(P), and
 b =  B1 * ... * Br * pieuklnorm(r,P).

M*/

/*H
	Version 1       28.06.1989      A.Stein
   DATE pilmfcb       : 891101.9107__.9311__
H*/


#include <_pol2.h>

int pilmfcb(r,P)
single r;
pol P;
{
	single s,d;
	int B;
	list DV;
	bind(P);
	init(B,DV);

/* Berechnung von B */

	B = pieuklnorm(r,P);
	DV = pdegvec(r,P);
	for( ; DV != _0 ; DV = lred(DV) ) {
		d = lfirst(DV);
		if (d) {
			s = d - ( d / 2 ) ;
			B = iprod( B , ibinom( d , s ) ) ;
		}
	}

/* Ausgabe */

	return(B);
}
