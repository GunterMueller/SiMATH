/*M
.SH NAME
upgfsrelpfac - univariate polynomial over Galois-field with single characteristic relative prime factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsrelpfac(p, AL, P, Fak, pA2) 
single p; 
list AL; 
pol P, Fak, *pA2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4  
.B P, Fak 
are monic and univariate polynomials of positive degree over GF(p^n), Fak divides P.
.TP 4
.B pA2
points on a polynomial, say *pA2.
.PP
upgfsrelpfac computes two univariate polynomials over GF(p^n), say A1 and A2, such that
.nf
.IP
A1 * A2 = P; 
ggT ( A1 , Fak ) = 1;
A2 | (Fak)^(deg(P)).
.PP
upgfsrelpfac returns A1 and writes A2 to *pA2.

.SH SEE ALSO
gfsalgen

M*/
                   
/*H
	Version 1  	10.01.90	J.Schmitt
   DATE upgfsrelpfac  : 900301.9203__
H*/


#include <_pol3.h>

pol upgfsrelpfac(p,AL,P,Fak,pA2)
single p;
list AL;
pol P,Fak;
pol *pA2;
{
	pol A1,A2;
	bind(AL,P,Fak);
	init(A1,A2);
                
	A1 = P;
	A2 = list2(0,1);
	A2 = list2(0,A2);

	do {
		A2 = pgfsprod(1,p,AL,Fak,A2);
		A1 = pgfsquot(1,p,AL,A1,Fak);
		Fak = upgfsgcd(p,AL,A1,A2);
	} while ( lfirst(Fak) > 0 );  
	*pA2 = A2;
	return(A1);
}
