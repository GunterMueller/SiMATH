/*C
			vecgfsred( p, V, Gm )

	"vector over Galois-field with single characteristic reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	vec vecgfsred(p, V, Gm); single p; vec V; pol Gm;
	W = vecgfsred( p, V, Gm );
	p ist eine Primzahl.
	V ist ein Vektor ueber GF(p^n) (n>m).
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden.
	W ist die Darstellung von V als Vektor ueber GF(p^m).
C*/
/*H
	Version  1      26.05.1993      S.Schmitt
H*/
/*cS
	vecgfsred ruft auf: lcomp, linv, pmsrem
	Macros: lfirst, lred
Sc*/
 
#include <_matr3.h>
# define gfselred(p,a,Gm) pmsrem(1,p,pitopms(1,a,p),Gm)

vec vecgfsred( p,V,Gm )
single p;
vec V;
pol Gm;
{ 	vec W;
	obj a;
	init(W, a);
	bind(V,Gm);

	W=_0;
	while(V!=_0)
	{	a=lfirst(V);
		a=gfselred(p,a,Gm);
		W=lcomp(a,W);
		V=lred(V);
	}
	W=linv(W);	
	return(W);
}
