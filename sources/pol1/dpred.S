/*M
.SH NAME
dpred - dense polynomial reductum

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dpred(r, P)  
single r; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a dense polynomial in r variables.
.PP
dpred returns the polynomial reductum P1 of P, i.e.                              
.PP                                                                             
P1 = P - (monomials of highest degree in the main                               
          variable)                                                             
 or, for P = 0, dpred returns 0.                                                 
M*/

/*H
	Version 1       01.08.1988      Pascale Serf
   DATE dpred         : 890501
H*/


# include <_pol1.h>

pol dpred(r,P)
single r;
pol P;
{
	bind(P);

	if ( P ) {
	    r = lfirst(P) - 1;
	    P = lred2(P);
	    while ( P!=_0 && lfirst(P)==0 ) {
		P = lred(P);
		r--;
	    }
	    if ( P == _0 ) P = 0;
	    else P = lcomp(r,P);
	}

	return(P);
}
