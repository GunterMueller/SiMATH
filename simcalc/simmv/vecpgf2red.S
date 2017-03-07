/*C
			vecpgf2red( r, V, Gm )

	"vector over polynomials over Galois-field with characteristic 2
	 reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	vec vecpgf2red(r, V, Gm); single r; vec V; pol Gm;
	W = vecpgf2red( r, V, Gm );
	V ist ein Vektor von Polynomen ueber GF(2^n) (n>m).
	r ist die Laenge der Variablenliste von V.
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen 
	ueber Z/2Z vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(2^m) interpretiert werden. 
	W ist die Darstellung von V als Vektor von Polynomen ueber
	GF(2^m).
C*/
/*H
	Version  1      14.03.1996      S.Schmitt
H*/
 
#include <_matr3.h>

vec vecpgf2red( r,V,Gm )
single r;
vec V;
pol Gm;
{ 	vec W;
	obj a;
	init(W, a);
	bind(V,Gm);

	W=_0;
	while(V!=_0)
	{	a=lfirst(V);
		a=pgf2red(r,a,Gm);
		W=lcomp(a,W);
		V=lred(V);
	}
	W=linv(W);	
	return(W);
}
