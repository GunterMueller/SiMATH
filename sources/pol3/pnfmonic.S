/*M
.SH NAME
pnfmonic - polynomial over number field monic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfmonic(r,F,P)  
single r; 
pol F, P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.
.PP
.nf                                     
pnfmonic returns the monic polynomial, say P1, associated to P
(for P equal to zero, P1 is equal to zero, too).
 
M*/
        
/*H
	Version 1       16.11.1989      A.Stein
   DATE pnfmonic      : 900315
H*/


#include <_pol3.h>

pol pnfmonic( r, F, P )
single r;
pol F,P;
{
	if (P) {
		nfel a;
		bind(F,P);

		a = plbc(r,P);
		a = nfinv(F,a);
		P = pnfnfprod( r,F,P,a );
	}
	return( P );
}
