/*M
.SH NAME
fputpgf2 - file put polynomial over Galois-field with characteristic 2

.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputpgf2(r, G, P, V, Vgf2, pf)  
single r; 
obj G; 
pol P;
list V, Vgf2; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a polynomial in r variables over GF(2^n) with coefficients in spezial bit-representation.
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).
.TP 4
.B Vgf2
is a list which contains one element, representing the name of a primitive element in GF(2)/(Z/2Z).
.TP 4
.B pf
points to an input file.      
.PP
fputpgf2 writes P to the file *pf, the end of P will be marked with '#'.
fputpgf2 returns 0 by success and ERROR else.                              

.SH SEE ALSO
udpm2tosb

M*/
        
/*H
	Version 1	29.04.93	J.Schmitt
   DATE fputpgf2      : 930531
H*/


#include <_pol3.h>

single fputpgf2(r,G,P,V,Vgf2,pf)
single r;
obj G;
pol P;
list V, Vgf2;
FILE *pf;
{
	single a=0;
	pol P1;
	obj k;
	bind(G,P,V,Vgf2);
	init(P1,k);
	
	if (!P) {
        	if (fputs("0 #",pf) == EOF) {
			errmsgio("fputpgf2","P201");
			a = ERROR;
		}
		return(a);
        }
	if (!r) {
		if ( fputgf2el(G,P,Vgf2,pf) == ERROR ) a = ERROR;
		return(a);
	}

	P  = ptodip(r,P);
	P1 = _0;
	while (P != _0) {
		k = lfirst(P);
		k = gf2eltoudpm2(G,k);
		k = dptop(1,k);
		P1= lcomp2(lsecond(P),k,P1);
		P = lred2(P);
	}
	P  = linv(P1);
	P  = diptop(r,P);
		
	V = lcconc(Vgf2,V);
	if (fputpms(r+1,2,P,V,pf) == ERROR) a = ERROR, errmsgio("fputpgf2","P201");

	return(a);
}
