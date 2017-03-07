/*M
.SH NAME
pgfsderiv - polynomial over Galois-field with single characteristic derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsderiv(r, p, AL, P)  
single r, p; 
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
.PP
pgfsderiv returns the derivation of P with regard to the main variable.
 
.SH SEE ALSO
.nf
pgfsderivsv
gfsalgen

M*/
                         
/*H
	Version 1         24.03.88           J.Schmitt
   DATE pgfsderiv     : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsderiv(r,p,AL,P)
single r,p;
list AL;
pol P;
{
	single e;
	pol P1, k, e1;
	bind(P,AL);
	init(P1,k,e1);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (e%p) {
				   e1=list2(0,e%p);
				   if (r) k = pgfsgfsprod(r,p,AL,k,e1);
				   else k = gfsprod(p,AL,k,e1);
				   P1 = lcomp2(k,e-1,P1);
				 }
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
