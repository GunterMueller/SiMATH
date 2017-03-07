/*M
.SH NAME
pvred - reduction of polynomial variables

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pvred(r, P, V) 
single r; 
pol P; 
list V, *pV;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.TP 4
.B V
is a list of variables names, used by P.
.PP
pvred writes a new variables list V1 (say) to pV.
V1 is equal to V without the variables which have coefficient 0 in P.
.PP
pvred returns the polynomial P as a polynomial with variables list V1.

M*/

/*H
	Version  1      29.02.1988      B. Weis
   DATE pvred         : 890501
H*/


#include<_pol1.h>

pol pvred(r,P,V,pV)
single r;
pol P;
list V;
list *pV;
{
	list E, Ea, Em, En, pVS;
	pol P1;
	bind(P,V);
	init(Em,En,pVS);

/* Sonderfaelle */

	if (P == 0  ||  V == _0) P1 = P, pVS = _0;

/* allgemeiner Fall */

	else {

/* Initialisierung und Berechnung der ueberfluessigen Variablen */

		Em = pdegvec(r,P);
		E = Em;
		while (E != _0  &&  lfirst(E)) E = lred(E);

/* Streichen der ueberfluessigen Variablen in P */

		if (E != _0) {
			P = ptodip(r,P);
			P1 = P;
			while (P1 != _0) {
				P1 = lred(P1);
				Ea = lfirst(P1);
				E = Em;
				En = _0;
				while (E != _0) {
					if (lfirst(E)) En = lcomp(lfirst(Ea),En);
					Ea = lred(Ea);
					E = lred(E);
					}
				En = linv(En);
				lsfirst(P1,En);
				P1 = lred(P1);
				}

/* Streichen der ueberfluessigen Variablen in V und Ende */

			Em = linv(Em);
			pVS = _0;
			while (V != _0) {
				if (lfirst(Em)) pVS = lcomp(lfirst(V),pVS);
				Em = lred(Em);
				V = lred(V);
				}
			pVS = linv(pVS);
			r = llength(pVS);
			if (r) P1 = diptop(r,P);
			else P1 = lfirst(P);
			}
		else P1 = P, pVS = V;
		}

/* Ausgabe */

	*pV = pVS;
	return(P1);
}
