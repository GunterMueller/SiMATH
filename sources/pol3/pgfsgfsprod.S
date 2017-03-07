/*M
.SH NAME
pgfsgfsprod - polynomial over Galois-field with single characteristic, Galois-field with single characteristic element product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsgfsprod(r, p, AL, P, a)  
single r, p; 
list AL; 
pol P; 
gfel a;
     
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
.TP 4
.B a
is an element in GF(p^n).
.PP                                     
pgfsgfsprod returns a polynomial over GF(p^n), say P1, where
.IP
P1 = a * P.

.SH SEE ALSO
gfsalgen

M*/
       
/*H
	Version 1         23.03.88           J.Schmitt
   DATE pgfsgfsprod   : 890501.9203__
H*/


#include <_pol3.h>
 
pol pgfsgfsprod(r,p,AL,P,a)
single r,p;
list AL;
pol P;
gfel a;
{
	single e;
	pol P1, k;
	bind(P,AL,a);
	init(P1,k);

/* P oder a gleich 0 */

	if (P == 0  ||  a == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = gfsprod(p,AL,P,a);

/* allgemeiner Fall: r,P,a ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pgfsgfsprod(r,p,AL,k,a);
			else k = gfsprod(p,AL,k,a);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
