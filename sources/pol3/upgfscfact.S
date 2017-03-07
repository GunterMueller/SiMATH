/*M
.SH NAME
upgfscfact - univariate polynomial over Galois-field with single characteristic
complete factorization


.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfscfact(p, AL, P)  
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
is an univariate polynomial of positive degree over GF(p^n).
.PP
upgfscfact returns a list (P_1, ..., P_r). The P_i are irreduzible and, except for P_1, monic polynomials, such that
.IP
P = P_1 * ... * P_r.   
              
.SH SEE ALSO
gfsalgen

M*/
                                  
/*H
	Version 1       13.04.1988             J.Schmitt
   DATE upgfscfact    : 890501.9107__
H*/


# include <_pol3.h>

list upgfscfact(p,AL,P)
single p;
list AL;
pol P;
{
	gfel lk;
	list L,L1,L2,L3,L4,M;
	pol P1,P2;
	single e,i,l;

	bind(P,AL);
	init(L,L1,L2,L3,L4,M,P1,P2,lk);

	/*    Spezialfall : Grad(P) = 1    */
	if ( lfirst(P) == 1 ) return(list1(P));

	/*    allgemeiner Fall : Grad(P) >= 2    */
	M = _0;
	lk = lsecond(P);
	P1 = pgfsgfsquot(1,p,AL,P,lk);
	L = upgfssfact(p,AL,P1);
	while ( L != _0 ) {
		L1 = lfirst(L); L = lred(L);
		e  = lfirst(L1);
		P = lsecond(L1);
		L2 = _0;
		if (lfirst(P)>1) L3 = upgfsddfact(p,AL,P);
		else L3=list2(P,1);
		while (L3!=_0) {
				P1 = lfirst(L3); L3=lred(L3);
				l  = lfirst(L3); L3=lred(L3);
				L4 = upgfsbfact(p,AL,P1,l);
				while (L4!=_0) {
						 L2=lcomp(lfirst(L4),L2);
						 L4=lred(L4);
				}
		}

		while ( L2 != _0 ) {
			P = lfirst(L2); L2 = lred(L2);
			for ( i=1 ; i<=e ; i++ ) M = lcomp(P,M);
		}
	}
	P1=pgfsgfsprod(1,p,AL,lfirst(M),lk);
	lsfirst(M,P1);
	return(M);

}
