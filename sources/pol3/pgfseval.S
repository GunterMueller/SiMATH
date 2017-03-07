/*M
.SH NAME
pgfseval - polynomial over Galois-field with single characteristic evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfseval(r, p, AL, P, a)  
single r, p; 
list AL; 
pol P; 
gfel a;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
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
pgfseval returns the evaluation of P at a with regard to the main variable.

.SH SEE ALSO
.nf
pgfsevalsv
gfsalgen

M*/
       
/*H
	Version 1         25.03.88           J.Schmitt
   DATE pgfseval      : 890501.9203__
H*/


#include <_pol3.h>

pol pgfseval(r,p,AL,P,a)
single r,p;
list AL;
pol P;
gfel a;
{
	single e, e1;
	pol P1, k;
	bind(P,AL,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				if (r) P1 = pgfsgfsprod(r,p,AL,P1,a);
				else P1 = gfsprod(p,AL,P1,a);
				}
			if (r) P1 = pgfssum(r,p,AL,P1,k);
			else P1 = gfssum(p,AL,P1,k);
			e = e1;
			}
		for (; e; e--) {
				if (r) P1 = pgfsgfsprod(r,p,AL,P1,a);
				else P1 = gfsprod(p,AL,P1,a);
				}
		}

/* Ausgabe */

	return(P1);
}
