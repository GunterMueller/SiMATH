/*M
.SH NAME
udptbc - univariate dense polynomial trailing base coefficient

.SH SYNOPSIS
.nf
#include<_pol1.h>

obj udptbc(P)  
pol P;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial.
.PP
udptbc returns the trailing base coefficient of P.
 For P = 0, udptbc returns 0.

M*/

/*H
	Version 1       13.09.1990      A. Stein
   DATE udptbc        : 901120
H*/


# include <_pol1.h>

obj udptbc( P )
pol P;
{
	obj a = 0;
	pol P1;

	if (P) {
		for(P=lred(P);P!=_0;P=lred(P)) P1 = P;
		a = lfirst(P1);
	}
	return ( a );
}
