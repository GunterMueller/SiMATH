/*M
.SH NAME
pvext - polynomial variable list extension

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pvext(r, P, V, VN)  
single r; 
pol P; 
list V, VN;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.TP 4
.B V
is a list of variables namens, beloning to P.
.TP 4
.B VN
is a list of variables names, containing the elements of V.
.PP
pvext returns the polynomial P as a polynomial with variables list VN.

M*/

/*H
	Version 1       01.03.1988      B. Weis
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE pvext         : 890501.941201
H*/

#include <_pol1.h>

pol pvext(r,P,V,VN)
single r;
pol P;
list V, VN;
{
	single i, rn;
	list PP, VS, Vn;
	bind(P,V,VN);
	init(PP);

/* Sonderfaelle */

	if (!P) P = 0;
	else if (!r) P = pvinsert(0,P,llength(VN));

/* allgemeiner Fall */

	else {
		V = lcconc(V,usdiff(VN,V));
		PP = _0;
		rn = llength(VN);
		while (VN != _0) {
			Vn = lfirst(VN);
			i = 1;
			VS = V;
			while (!oequal(lfirst(VS),Vn)) VS = lred(VS), i++;
			PP = lcomp(i,PP);
			VN = lred(VN);
			}
		PP = linv(PP);
		for (r = rn-r; r; r--) P = list2(0,P);
		P = pvpermut(rn,P,PP);
		}

/* Ausgabe */

	return(P);
}
