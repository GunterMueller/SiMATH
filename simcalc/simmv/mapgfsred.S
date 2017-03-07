/*C
			mapgfsred( r, p, M, Gm )

	"matrix over polynomials over Galois-field with single 
	 characteristic reduction" 
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	matrix mapgfsred(r, p, M, Gm); single r, p; matrix M; pol Gm;
	N = mapgfsred( r, p, M, Gm );
	p ist Primzahl.
	M ist eine Matrix von Polynomen ueber G(p^n) (n>m).
	r ist die Laenge der Variablenliste von M.
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden. 
	N ist die Darstellung von M als Matrix von Polynomen ueber
	GF(p^m).
C*/
/*H
	Version  1      26.05.1993      S.Schmitt
H*/
/*cS
	mapgfsred ruft auf: lcomp, linv, pgfsred
	Macros: lfirst, lred
Sc*/
 
#include <_matr3.h>

matrix mapgfsred( r,p,M,Gm )
single r,p;
matrix M;
pol Gm;
{ 	matrix L;
	list V, W;
	obj a;
	init(L, V, W, a);
	bind(M,Gm);

	L=_0;
	while(M!=_0)
	{	V=lfirst(M);
		W=_0;
		while(V!=_0)
		{ 	a=lfirst(V);
			a=pgfsred(r,p,a,Gm);
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

