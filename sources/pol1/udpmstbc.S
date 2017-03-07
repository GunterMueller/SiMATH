/*M
.SH NAME
udpmstbc - univariate dense polynomial over modular single trailing base coefficient

.SH SYNOPSIS
.nf
#include<_pol1.h>

single udpmstbc(m, P)  
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P
is an univariate dense polynomial over Z/mZ.
.PP
udpmstbc returns the trailing base coefficient of P.
For P = 0, udpmstbc returns 0.

M*/

/*H
	Version 1       02.01.1990      A.Stein
	Version 2       05.09.1990      Modul in Funktionsaufruf ergaenzt
					und Programm ueberarbeitet.  A.Stein
   DATE udpmstbc      : 900315.901120.9107__
H*/


# include <_pol1.h>

single udpmstbc( m, P )
single m;
pol P;
{
	single s = 0;
	pol P1;

	if (P) {
		for(P=lred(P);P!=_0;P=lred(P)) P1 = P;
		s = lfirst(P1);
	}
	return ( s );
}
