/*M
.SH NAME
pgfstransf - polynomial over Galois-field with single characteristic transformation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfstransf(r1, p, AL, P1, V1, r2, P2, V2, Vn, pV3)
single r1, p, r2; 
list AL, V1, V2, Vn, pV3; 
pol P1, P2; 
               
.SH DESCRIPTION
.TP 4
.B r1
is an integer number, 0 < r1 < BASIS.
.TP 4
.B p
is a prime number, p < BASIS. 
.TP 4
.B r2
is an integer number, 0 <= r2 < BASIS.
.TP 4          
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).                              
.TP 4
.B P1, P2
are polynomials over GF(p^n) in r1, r2 variables respectively.
.TP 4
.B V1, V2
are lists of variables names used by P1, P2 respectively.
.TP 4
.B Vn
is a variable name in V1.
.PP  
pgfstransf returns the polynomial P3, which arises from the substitution of Vn in P1 by P2.
.PP
The list of variables names used by P3 ( the union of V1 and V2 ), will be alphabetized and stored in *pV3.

.SH SEE ALSO   
gfsalgen
                                                 
M*/
          
/*H
	Version 1       25.08.1993      S.Schmitt
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE pgfstransf    : 931130.941201
H*/


#include <_pol3.h>

pol pgfstransf(r1,p,AL,P1,V1,r2,P2,V2,Vn,pV3)
single r1;
single p;
list AL;
pol P1;
list V1;
single r2;
pol P2;
list V2;
list Vn;
list *pV3;
{
	single i, j, r3;
	list PP, V3;
	pol P2P, P3, k;
	bind(AL,P1,P2,V1,V2,Vn);
	init(P2P,P3,PP,V3,k);

/* P1 Konstante */

	if (ispconst(r1,P1,&P3)) {
		V3 = usunion(V1,V2);
		V3 = vlsort(V3,&PP);
		P3 = pvinsert(0,P1,llength(V3)-r1);
		}

/* P2 Konstante */

	else if (ispconst(r2,P2,&P3)) {
		PP = V1;
		for (i = 1; vncomp(Vn,lfirst(PP)); PP = lred(PP), i++);
		PP = list1(i);
		for (j = r1-1; j; j--) {
			if (j != i) PP = lcomp(j,PP);
			else PP = lcomp(r1,PP);
			}
		P1 = pvpermut(r1,P1,PP);
		V1 = lpermut(V1,PP);
		P3 = pgfseval(r1,p,AL,P1,P3);
		V3 = usdiff(V2,V1);
		V3 = lconc(V1,V3);
		V3 = vlsort(V3,&PP);
		r3 = llength(V3);
		P3 = pvinsert(0,P3,r3-r1+1);
		P3 = pvpermut(r3,P3,PP);
		}

/* allgemeiner Fall */

	else {
		V1 = list2(V1,V2);
		P1 = list2(P1,P2);
		V3 = pvmerge(V1,P1,&P2);
		P1 = lfirst(P2);
		P2 = lsecond(P2);
		r3 = llength(V3);
		PP = V3;
		for (i = 1; vncomp(Vn,lfirst(PP)); PP = lred(PP), i++);
		PP = list1(i);
		for (j = r3-1; j; j--) {
			if (j != i) PP = lcomp(j,PP);
			else PP = lcomp(r3,PP);
			}
		P1 = pvpermut(r3,P1,PP);
		P2 = pvpermut(r3,P2,PP);
		P1 = lcinv(P1);
		P3 = 0;
		i = 0;
		P2P = list2(0,1);
		P2P = pvinsert(0,P2P,r3);
		while (P1 != _0) {
			k = lfirst(P1);
			P1 = lred(P1);
			j = lfirst(P1);
			P1 = lred(P1);
			for (; i < j; i++) P2P = pgfsprod(r3,p,AL,P2P,P2);
			k = list2(0,k);
			k = pgfsprod(r3,p,AL,k,P2P);
			P3 = pgfssum(r3,p,AL,P3,k);
			}
		P3 = pvpermut(r3,P3,PP);
		}

/* Ausgabe */

	*pV3 = V3;
	return(P3);
}

