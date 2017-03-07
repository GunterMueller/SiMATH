/*M
.SH NAME
udpmimonic - univariate dense polynomial over modular integers monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmimonic(m, P)  
int m; 
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
Let A be the leading coefficient of P, udpmimonic returns the monic polynomial  P1, where
.PP
P1 = A^(-1) * P.

M*/

/*H
	Version 1 	14.08.91	J.Schmitt
   DATE udpmimonic    : 910915
H*/

#include <_pol1.h>

pol udpmimonic(m,P)
int m;
pol P;
{
	int a;
	bind(m,P);
	init(a);

/* Berechnung des zu P assozierten, normierten Polynoms */

	if (P) {
		a = miinv(m,lsecond(P));
		P = udpmimiprod(m,P,a);
	}

/* Ausgabe */

	return(P);
}
