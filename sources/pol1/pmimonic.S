/*M
.SH NAME
pmimonic - polynomial over modular integers monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmimonic(r, M, P)  
single r; 
int M; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.        
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P
is a polynomial in r variables over Z/(M*Z).
The leading base coefficient of P ( with regard to the main variable ) must be a unit.
.PP
Let A be the leading base coefficient, pmimonic returns the monic polynomial P1, where
.PP
P1 = A^(-1) * P.
 
M*/

/*H
	Version 1       09.05.88        R. Boeffgen
   DATE pmimonic      : 890501
H*/


#include <_pol1.h>

pol pmimonic( r, M, P )
single r;
int M;
pol P;
{
	if (P) {
		int A;
		bind( P );
		A = plbc( r,P );
		A = miinv( M,A );
		P = pmimiprod( r,M,P,A );
	}
	return( P );
}
