/*M
.SH NAME
upgfssfact - univariate polynomial over Galois-field with single characteristic squarefree factorization  (rekursiv)
  
.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfssfact(p, AL, P)  
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
is a monic and univariate polynomial over GF(p^n) of positive degree.
.PP
upgfssfact returns a list, say L, containing the squarefree factorization of P, i.e.
L = ((e_1, P_1),...,(e_n, P_n)), such that, for 1 <= i <= n     
.nf
.IP
0 < e_1 < e_2 < ... < e_n;
P_i is a monic and squarefree factor of P;
the P_i's are coprime;
(P_1)^(e_1) * ... * (P_n)^(e_n) = P.   

.SH SEE ALSO
gfsalgen

M*/
                               
/*H
	Version 1      25.03.88         J.Schmitt
	Version 2      12.02.90		J.Schmitt
					( fuer n == 1 Fehler beseitigt )
   DATE upgfssfact   : 890501.900301.9203__
H*/


#include <_pol3.h>

list upgfssfact(p,AL,P)
single p;
list AL;
pol P;
{
	single e2, j, i;
	gfel k2, b;
	int Z, K, T;
	list L, LS, L1, M, MS, M1;
	pol PS, P1, P2, P3, P4, P2S;
	bind(P,AL);
	init(k2,b,Z,K,T,L,LS,L1,M,MS,M1,PS,P1,P2,P3,P4,P2S);

	LS = _0;
	PS = pgfsderiv(1,p,AL,P);

/* Berechnung der Pi, fuer die ei nicht durch p teilbar ist */

	if (PS) {                
		P2 = upgfsgcd(p,AL,P,PS);
		P3 = pgfsquot(1,p,AL,P,P2);
		j = 1;
		do {
			P4 = upgfsgcd(p,AL,P2,P3);
			P1 = pgfsquot(1,p,AL,P3,P4);
			if (lfirst(P1)) {
				P1 = list2(j,P1);
				LS = lcomp(P1,LS);
			}
			if (lfirst(P4)) {
				P3 = P4;
				P2 = pgfsquot(1,p,AL,P2,P3);
				j++;
			}
		} while (lfirst(P4));
	}
	else P2 = P;

/* Berechnung der Pi, fuer die ei durch p teilbar ist */

	if (lfirst(P2) == 0) L = linv(LS);
	else {
		P2S = _0;
		Z = pdegree(1,lfirst(AL))-1;
		Z = iexp(p,Z);
		do {
			e2 = lfirst(P2);
			P2 = lred(P2);
			k2 = lfirst(P2);
			P2 = lred(P2);

			if (!oequal(k2,list2(0,1))) {
				K = 2;
				while ( icomp(K,Z)!=1 ) K = isum(K,K);
				K = iquot(K,2);
				b = k2;
				T = idif(Z,K);
				while ( icomp(K,1) != 0 ) {
					k2= gfsprod(p,AL,k2,k2);
					K = iquot(K,2);
					if ( icomp(K,T)!=1 ) {
						k2= gfsprod(p,AL,b,k2);
						T = idif(T,K);
					}
				}
			}
			e2 /= p;
			P2S = lcomp2(k2,e2,P2S);
		} while (P2 != _0);
		P2 = linv(P2S);
		M = upgfssfact(p,AL,P2);
		MS = M;
		do {
			M1 = lfirst(MS);
			MS = lred(MS);
			e2 = p * lfirst(M1);
			lsfirst(M1,e2);
		} while (MS != _0);
		M = linv(M);
		L = _0;

		/* Mischen von LS und M */

		while (LS != _0  &&  M != _0) {
			if (lfirst(lfirst(LS)) > lfirst(lfirst(M))) {
				L1 = lfirst(LS);
				LS = lred(LS);
			}
			else {
				L1 = lfirst(M);
				M = lred(M);
			}
			L = lcomp(L1,L);
		}
		if (M == _0) LS = linv(LS);
		else LS = linv(M);
		L = lconc(LS,L);
	}

	return(L);
}
