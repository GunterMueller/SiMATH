/*M
.SH NAME
pgfsmonic - polynomial over Galois-field with single characteristic monic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsmonic(r, p, AL, P)  
single r, p;  
list AL; 
pol P;
     
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a polynomial over GF(p^n) in r variables.
.PP
pgfsmonic returns the monic polynomial associated to P.               

.SH SEE ALSO
gfsalgen

M*/
           
/*H
	Version 1         23.03.88           J.Schmitt
   DATE pgfsmonic     : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsmonic(r,p,AL,P)
single r,p;
list AL;
pol P;
{
	gfel a;
	bind(P,AL);
	init(a);
/* Berechnung des zu P assozierten, normierten Polynoms */

	if (P) {
		a = plbc(r,P);
		a = gfsinv(p,AL,a);
		P = pgfsgfsprod(r,p,AL,P,a);
		}

/* Ausgabe */

	return(P);
}
