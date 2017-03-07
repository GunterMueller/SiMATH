/*C
			gfselred( p, a, Gm )    (MACRO)

	"Galois-field with single characteristic element reduction"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	gfel gfselred(p, a, Gm); single p; gfel a; pol Gm;
	b = gfselred( p, a, Gm );
	p ist eine Primzahl.
	a ist ein Element aus GF(p^n) (n>m).
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden.
	b ist die Darstellung von a als Element aus GF(p^m).
C*/
/*H
	Version  1      19.05.1993      S.Schmitt
H*/
/*cS
	gfselred ruft auf: pitopms, pmsrem 
Sc*/
 
# define gfselred(p,a,Gm) pmsrem(1,p,pitopms(1,a,p),Gm)
