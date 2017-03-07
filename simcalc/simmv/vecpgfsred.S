/*C
			vecpgfsred( r, p, V, Gm )

	"vector over polynomials over Galois-field with single 
	 characteristic reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	vec vecpgfsred(r, p, V, Gm); single r, p; vec V; pol Gm;
	W = vecpgfsred( r, p, V, Gm );
	p ist eine Primzahl.
	V ist ein Vektor von Polynomen ueber GF(p^n) (n>m).
	r ist die Laenge der Variablenliste von V.
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen 
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden. 
	W ist die Darstellung von V als Vektor von Polynomen ueber
	GF(p^m).
C*/
/*H
	Version  1      26.05.1993      S.Schmitt
H*/
/*cS
	vecpgfsred ruft auf: lcomp, linv, pgfsred
	Macros: lfirst, lred
Sc*/
 
#include <_matr3.h>

vec vecpgfsred( r,p,V,Gm )
single r,p;
vec V;
pol Gm;
{ 	vec W;
	obj a;
	init(W, a);
	bind(V,Gm);

	W=_0;
	while(V!=_0)
	{	a=lfirst(V);
		a=pgfsred(r,p,a,Gm);
		W=lcomp(a,W);
		V=lred(V);
	}
	W=linv(W);	
	return(W);
}
