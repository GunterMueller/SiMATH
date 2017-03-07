/*M
.SH NAME
pgfsexp - polynomial over Galois-field with single characteristic exponentiation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsexp(r, p, AL, P, m)  
single r, p, m; 
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
.TP 4
.B m
is an integer number, 0 <= m < BASIS.
.PP
pgfsexp returns a polynomial, say P1, over GF(p^n), where
.IP
P1 = P^m.
        
.SH SEE ALSO
gfsalgen

M*/
        
/*H
	Version 1         29.03.88           J.Schmitt
   DATE pgfsexp       : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsexp(r,p,AL,P,m)
single r,p;
list AL;
pol P;
single m;
{
	pol P1;
	bind(P,AL);
	init(P1);

/* m gleich 0 */
	if (!m) P1 = pvinsert(0,list2(0,1),r);

/* P gleich 0 */
	else if (!P) P1 = 0;

/* m,P ungleich 0 */
	else {
		P1 = P;
		for (--m; m; m--) P1 = pgfsprod(r,p,AL,P1,P);
		}

/* Ausgabe */
	return(P1);
}
