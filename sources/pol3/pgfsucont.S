/*M
.SH NAME
pgfsucont - polynomial over Galois-field of single characteristic univariate content
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsucont(r, p, AL, P)  
single r, p; 
list AL; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 2 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
is the arithmetic list of a finite field of characteristic p, say Fq.
.TP 4
.B P 
is a polynomial in Fq[X1, ..., Xr].
.PP
pgfsucont returns the content of P over Fq[X1].
 
M*/
           
/*H
	Version 1 	02.05.95	Wolfgang Schwarz	
   DATE pgfsucont     : 951201
H*/

#include <_pol3.h>

pol pgfsucont(r,p,AL,P)
single r,p;
list AL;
pol P;
{
	pol P1, P2;
	bind(AL,P);
	init(P1,P2);

	if (P) {
		r--;
		if (r == 1) {
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			while (P != _0  &&  lfirst(P1)) {
				P = lred(P);
				P2 = lfirst(P);
				P = lred(P);
				P1 = upgfsgcd(p,AL,P2,P1);
			}
		}
		else {
			P = lred(P);
			P1 = lfirst(P);
			P = lred(P);
			P1 = pgfsucont(r,p,AL,P1);
			while (P != _0  &&  lfirst(P1)) {
				P = lred(P);
				P2 = lfirst(P);
				P = lred(P);
				P2 = pgfsucont(r,p,AL,P2);
				P1 = upgfsgcd(p,AL,P2,P1);
			}
		}
	}
	else P1 = 0;

/* Ausgabe */

	return(P1);
}
