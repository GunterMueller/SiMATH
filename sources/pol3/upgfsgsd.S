/*M
.SH NAME
upgfsgsd - univariate polynomial over Galois-field with single characteristic greatest squarefree divisor (rekursiv)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsgsd(p, AL, P)  
single p; 
list AL; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is an univariate and monic polynomial over GF(p^n). 
.PP
upgfsgsd returns an univariate and monic polynomial, say P1, over GF(p^n), such that
.PP
P1 divides P, and there exists a natural number, say s, such that
.PP
P divides P1^s.

.SH SEE ALSO
gfsalgen

M*/
                                    
/*H
	Version 1       05.12.89        J.Schmitt
   DATE upgfsgsd      : 900301.9203__
H*/

#include<_pol3.h>

pol upgfsgsd(p,AL,P)
single p;
list AL;
pol P;
{
	pol P1;
	list L,L1;
	bind(AL,P);
	init(P1,L,L1);

	if ( pdegree(1,P) < 2 ) return(P);

	L = upgfssfact(p,AL,P);
	P1 = list2(0,1);
	P1 = list2(0,P1);
        while ( L != _0 ) {
		L1 = lfirst(L);
		L  = lred(L);
		L1 = lsecond(L1);
		P1 = pgfsprod(1,p,AL,P1,L1);
	}	 

	return(P1);
}
