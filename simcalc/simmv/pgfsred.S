/*C
			pgfsred( r, p, P, Gm )

	"polynomial over Galois-field with single characteristic 
	 reduction"(rekursiv)
	Quellbibliothek: srclib.pol3
	Include-Datei:   _pol3.h
	pol pgfsred(r, p, P, Gm); single r, p; pol P, Gm;
	Q = pgfsred( r, p, P, Gm );
	p ist eine Primzahl.
	P ist ein Polynom in r Variablen ueber GF(p^n) (n>m).
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen
	ueber Z/pZ vom Grad m. Gm kann als ein erzeugendes Polynom fuer 
	GF(p^m) interpretiert werden.
	Q ist die Darstellung von P als Polynom ueber GF(p^m).
C*/
/*H
	Version  1      19.05.1993      S.Schmitt
H*/
/*cS
	pgfsred ist rekursiv
	und ruft auf: linv, pmsrem
	Macros: gfselred, lcomp2, lfirst, lred2, lsecond
Sc*/
 
#include <_pol3.h>
# define gfselred(p,a,Gm) pmsrem(1,p,pitopms(1,a,p),Gm)

pol pgfsred( r, p, P, Gm )
single r,p;
pol P, Gm;
{ 	pol Q;
	obj a, e;
	init(Q, a, e);
	bind(P, Gm);

/* P gleich 0 */

	if (P == 0) Q = 0;

/* r gleich 0 */

	else if (r == 0)     Q=gfselred(p,P,Gm);

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0) 
		{ 	e = lfirst(P);
			a = lsecond(P);
			P = lred2(P);
			a = pgfsred(r,p,a,Gm);
			if(a)   Q = lcomp2(a,e,Q);
		}
		if(Q==_0)  Q=0;
		else  Q = linv(Q);
	}
	return(Q);
}

