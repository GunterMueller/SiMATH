/*C
			magf2red( M, Gm )

	"matrix over Galois-field with characteristic 2 reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	matrix magf2red( M, Gm); matrix M; pol Gm;
	N = magf2red( M, Gm );
	M ist eine Matrix ueber GF(2^n) (n>m).
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/2Z vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(2^m) interpretiert werden.
	N ist die Darstellung von M als Matrix ueber GF(2^m).
C*/
/*H
	Version  1      29.02.1996      S.Schmitt
H*/
 
#include <_calc.h>
	
matrix magf2red( M, Gm )
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
			a=gf2elred(a,Gm);
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
