/*M
.SH NAME
pgfsevalsv - polynomial over Galois-field with single characteristic evaluation, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsevalsv(r, p, AL, P, d, a)  
single r, p, d; 
list AL; 
pol P; 
   
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
.B d
is an integer number, 1 <= d <= r.
.TP 4
.B a
is an element in GF(p^n).
.PP
pgfsevalsv returns the evaluation of P at a with regard to the main variable.

.SH SEE ALSO
.nf
pgfseval
gfsalgen

M*/
                     
/*H
	Version 1         25.03.88           J.Schmitt
   DATE pgfsevalsv    : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsevalsv(r,p,AL,P,d,a)
single r,p;
list AL;
pol P;
single d;
gfel a;
{
	single e;
	pol P1, k;
	bind(P,AL,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* d gleich r */

	else if (d == r) P1 = pgfseval(r,p,AL,P,a);

/* allgemeiner Fall: P ungleich 0, d ungleich r */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pgfsevalsv(r,p,AL,k,d,a);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
