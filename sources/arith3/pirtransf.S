/*M
.SH NAME
pirtransf - polynomial over the integers rational transformation

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc pirtransf(r1, P1, V1, r2, R2, V2, pV3)
single r1, r2; 
pol P1; 
list V1, V2, Vn, *pV3; 
rfunc R2; 

.SH DESCRIPTION
.TP 4
.B r1
is an integer number, 0 < r1 < BASIS.
.TP 4
.B r2
is an integer number, 0 <= r2 < BASIS.
.TP 4      
.B P1
is a polynomial in r1 variables over the integral numbers.
.TP 4
.B R2
is a rational function in r2 variables over the rational numbers.
.TP 4
.B V1, V2
are lists of variables names used by P1, R2 resp..
.TP 4
.B Vn
is a variable name of V1.
.PP
pirtransf returns the function R, which arises from the substitution of Vn in P1 by R2.
.PP
The list of variables names used by R ( the union of V1 and V2 ), will be alphabetized and stored in *pV3.

M*/
    
/*H
	Version 1       08.03.1988      B. Weis
	version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 3 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE pirtransf     : 890501.941201
H*/


#include <_arith3.h>

rfunc pirtransf(r1,P1,V1,r2,R2,V2,Vn,pV3)
single r1;
pol P1;
list V1;
single r2;
rfunc R2;
list V2;
list Vn;
list *pV3;
{
	single i, j, r3;
	list PP, V3;
	pol EINS, R2P, R2PN, R2PZ, R3, k;
	bind(P1,R2,V1,V2,Vn);
	init(EINS,R2P,R3,PP,V3,k);

/* P1 Konstante */

	if (ispconst(r1,P1,&R3)) {
		V3 = usunion(V1,V2);
		V3 = vlsort(V3,&PP);
		r3 = llength(V3);
		R3 = pvinsert(0,P1,r3-r1);
		EINS = pvinsert(0,1,r3);
		R3 = list2(R3,EINS);
		}

/* R2 gleich 0 */

	else if (!R2) {
		PP = V1;
		for (i = 1; vncomp(Vn,lfirst(PP)); PP = lred(PP), i++);
		PP = list1(i);
		for (j = r1-1; j; j--) {
			if (j != i) PP = lcomp(j,PP);
			else PP = lcomp(r1,PP);
			}
		P1 = pvpermut(r1,P1,PP);
		V1 = lpermut(V1,PP);
		R3 = pieval(r1,P1,R2);
		V3 = usdiff(V2,V1);
		V3 = lconc(V1,V3);
		V3 = vlsort(V3,&PP);
		r3 = llength(V3);
		R3 = pvinsert(0,R3,r3-r1+1);
		R3 = pvpermut(r3,R3,PP);
		if (R3) {
			EINS = pvinsert(0,1,r3);
			R3 = list2(R3,EINS);
			}
		}

/* allgemeiner Fall */

	else {
		V1 = list3(V1,V2,V2);
		P1 = lcomp(P1,R2);
		V3 = pvmerge(V1,P1,&R3);
		P1 = lfirst(R3);
		R2 = lsecond(R3);
		R3 = lthird(R3);
		r3 = llength(V3);
		PP = V3;
		for (i = 1; vncomp(Vn,lfirst(PP)); PP = lred(PP), i++);
		PP = list1(i);
		for (j = r3-1; j; j--) {
			if (j != i) PP = lcomp(j,PP);
			else PP = lcomp(r3,PP);
			}
		P1 = pvpermut(r3,P1,PP);
		R2 = pvpermut(r3,R2,PP);
		R3 = pvpermut(r3,R3,PP);
		if (pisign(r3,R3) == -1) {
			R2 = pineg(r3,R2);
			R3 = pineg(r3,R3);
			}
		R2 = list2(R2,R3);
		EINS = pvinsert(0,1,r3);
		P1 = lcinv(P1);
		R3 = 0;
		i = 0;
		R2P = list2(EINS,EINS);
		while (P1 != _0) {
			k = lfirst(P1);
			P1 = lred(P1);
			j = lfirst(P1);
			P1 = lred(P1);
			for (; i < j; i++) R2P = rfrprod(r3,R2P,R2);
			k = list2(0,k);
			R2PZ = lfirst(R2P);
			R2PN = lsecond(R2P);
			k = piprod(r3,k,R2PZ);
			k = rfrcons(r3,k,R2PN);
			R3 = rfrsum(r3,R3,k);
			}
		if (R3) {
			R2 = lfirst(R3);
			R3 = lsecond(R3);
			R2 = pvpermut(r3,R2,PP);
			R3 = pvpermut(r3,R3,PP);
			if (pisign(r3,R3) == -1) {
				R2 = pineg(r3,R2);
				R3 = pineg(r3,R3);
				}
			R3 = list2(R2,R3);
			}
		}

/* Ausgabe */

	*pV3 = V3;
	return(R3);
}
