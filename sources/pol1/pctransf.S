/*M
.SH NAME
pctransf - polynomial over the complex numbers, transformation  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pctransf(r1, P1, V1, r2, P2, V2, Vn, pV3)
single r1, r2;
pol P1, P2;
list V1, V2, Vn, *pV3;

.SH DESCRIPTION
pctransf() returns  the polynomial
which arises by replacing the variable Vn by
the polynomial P2 in the polynomial P1.
.PP
.TP 4
.B P1
is a polynomial in r1 variables over the complex numbers.
.TP 4
.B V1
is the variable list of P1.
.TP 4
.B P2
is a polynomial in r2 variables over the complex numbers.
.TP 4
.B V2
is the variable list of P2.
.TP 4
.B Vn
is a list which represents a single variable name of V1.
.TP 4
.B *pV3
is the variable list where the union of the two lists
V1 and V2 will be stored in alphabetical order.

.SH SEE ALSO
pfltransf
M*/

/*H
	Version 1 	25.01.1995	S.Schmitt
   DATE pctransf      : 951201.960501
H*/

#include <_pol1.h>

pol pctransf(r1,P1,V1,r2,P2,V2,Vn,pV3)
single r1;
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
	bind(P1,P2,V1,V2,Vn);
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
		P3 = pceval(r1,P1,P3);
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
		P2P = itoc( 1 );
		P2P = pvinsert(0,P2P,r3);
		while (P1 != _0) {
			k = lfirst(P1);
			P1 = lred(P1);
			j = lfirst(P1);
			P1 = lred(P1);
			for (; i < j; i++) P2P = pcprod(r3,P2P,P2);
			k = list2(0,k);
			k = pcprod(r3,k,P2P);
			P3 = pcsum(r3,P3,k);
		}
		P3 = pvpermut(r3,P3,PP);
	}

	*pV3 = V3;
	return(P3);
}
