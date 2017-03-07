/*C
			magfsred( p, M, Gm )

	"matrix over Galois-field with single characteristic reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	matrix magfsred(p, M, Gm); single p; matrix M; pol Gm;
	N = magfsred( p, M, Gm );
	p ist eine Primzahl.
	M ist eine Matrix ueber GF(p^n) (n>m).
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden.
	N ist die Darstellung von M als Matrix ueber GF(p^m).
C*/
/*H
	Version  1      19.05.1993      S.Schmitt
H*/
/*cS
	magfsred ruft auf: lcomp, linv, pmsrem
	Macros: lfirst, lred
Sc*/
 
#include <_matr3.h>
# define gfselred(p,a,Gm) pmsrem(1,p,pitopms(1,a,p),Gm)
	
matrix magfsred( p, M, Gm )
single p;
matrix M;
pol Gm;
{ 	matrix L;
	list V, W;
	obj a;
	init(L, V, W, a);
	bind(M, Gm);

	L=_0;
	while(M!=_0)
	{	V=lfirst(M);
		W=_0;
		while(V!=_0)
		{ 	a=lfirst(V);
			a=gfselred(p,a,Gm);
			W=lcomp(a,W);
			V=lred(V);
		}
		W=linv(W);
		L=lcomp(W,L);
		M=lred(M);
	}
	L=linv(L);	
	return(L);
}
