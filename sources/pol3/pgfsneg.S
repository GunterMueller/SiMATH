/*M
.SH NAME
pgfsneg - polynomial over Galois-field with single characteristic negation
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsneg(r, p, AL, P)  
single r, p; 
list AL; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
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
pgfsneg returns a polynomial over GF(p^n), say P1, where
.IP
P1 = -P.

.SH SEE ALSO
gfsalgen

M*/
                   
/*H
	Version 1         23.03.88           J.Schmitt
   DATE pgfsneg       : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsneg(r,p,AL,P)
single r,p;
list AL;
pol P;
{
	single e;
	pol P1,k;
	bind(P,AL);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = gfsneg(p,AL,P);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pgfsneg(r,p,AL,k);
			else k = gfsneg(p,AL,k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
