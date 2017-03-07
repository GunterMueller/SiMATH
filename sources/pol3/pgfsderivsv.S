/*M
.SH NAME
pgfsderivsv - polynomial over Galois-field with single characteristic derivation, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsderivsv(r, p, AL, P, i)  
single r, p; 
list AL; 
pol P; 
single i;
  
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
.B i
is an integer number, 1 <= i <= r.
.PP
pgfsderivsv returns the derivation of P with regard to the i-th variable.

.SH SEE ALSO
.nf
pgfsderiv
gfsalgen

M*/
                                                   
/*H
	Version 1         29.03.88           J.Schmitt
   DATE pgfsderivsv   : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsderivsv(r,p,AL,P,i)
single r,p;
list AL;
pol P;
single i;
{
	single e;
	pol P1, k;
	bind(P,AL);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (i == r) P1 = pgfsderiv(r,p,AL,P);

/* allgemeiner Fall: i ungleich r und P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pgfsderivsv(r,p,AL,k,i);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
