/*M
.SH NAME
udpmsmonic - univariate dense polynomial over modular singles monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsmonic(m, P) 
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, m > 0.
.TP 4
.B P
is a dense polynomial in one variable over Z/mZ.
The leading coefficient of P must be an unit.
.PP
Let A be the leading coefficient of P, udpmsmonic returns the monic polynomial  
P1, where                                                                       
.PP                                                                             
P1 = A^(-1) * P.                                                                
             
M*/

/*H
	Version 1       20.08.1990      A.Stein
   DATE udpmsmonic    : 901120.9109__
H*/


#include <_pol1.h>

pol udpmsmonic(m,P)
single m;
pol P;
{
	single a;
	bind(P);

/* Berechnung des zu P assozierten, normierten Polynoms */

	if (P) {
		a = msinv(m,lsecond(P));
		P = udpmsmsprod(m,P,a);
	}

/* Ausgabe */

	return(P);
}
