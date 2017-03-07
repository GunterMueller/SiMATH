/*M
.SH NAME
pmsmonic - polynomial over modular singles monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmsmonic(r, m, P) 
single r, m; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
The leading base coefficient of P ( with regard to the main variable ) must be a
unit.            
.PP
Let A be the leading base coefficient, pmsmonic returns the monic polynomial P1,
where                                                                          
.PP                                                                             
P1 = A^(-1) * P.                                                                
    
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsmonic      : 890501
H*/


#include <_pol1.h>

pol pmsmonic(r,m,P)
single r;
single m;
pol P;
{
	single a;
	bind(P);

/* Berechnung des zu P assozierten, normierten Polynoms */

	if (P) {
		a = plbc(r,P);
		a = msinv(m,a);
		P = pmsmsprod(r,m,P,a);
		}

/* Ausgabe */

	return(P);
}
