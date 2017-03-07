/*C
			vecgf2rem( V, Gm )

	"vector over Galois-field with characteristic 2 reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	vec vecgf2rem(V, Gm); vec V; pol Gm;
	W = vecgf2rem( V, Gm );
	V ist ein Vektor ueber Z bzw. Z/2Z.
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/2Z vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(2^m) interpretiert werden.
	W ist die Darstellung von V als Vektor ueber GF(2^m).
C*/
/*H
	Version  1      29.02.1996      S.Schmitt
H*/
 
#include <_matr3.h>

vec vecgf2rem( V,Gm )
vec V;
pol Gm;
{ 	vec W;
	obj a;
	init(W, a);
	bind(V,Gm);

	W=_0;
	while(V!=_0)
	{	a=lfirst(V);
		a=pitopms(1,a,2);
		a=ptodp(1,a);
		a=udpm2togf2el(Gm,a);
		W=lcomp(a,W);
		V=lred(V);
	}
	W=linv(W);	
	return(W);
}
