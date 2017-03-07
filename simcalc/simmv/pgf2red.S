/*C
			pgf2red( r, P, Gm )

	"polynomial over Galois-field with characteristic 2 reduction" 
	(rekursiv)
	Quellbibliothek: srclib.pol3
	Include-Datei:   _pol3.h
	pol pgf2red(r,P,Gm); single r; obj Gm; pol P;
	Q = pgf2red( r,P,Gm );
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen 
	ueber Z/2Z vom Grad m in der speziellen Bitdarstellung (vgl.
	udpm2tosb). Gm kann als ein erzeugendes Polynom fuer GF(2^m)
	interpretiert werden. 
	P ist ein Polynom ueber GF(2^n) in r Variablen (m<n).
	Q ist die Darstellung von P als Polynom ueber GF(2^m).
C*/
/*H
	Version  1      19.05.1993      S.Schmitt
	Version  2      14.03.1996      S.Schmitt (Gn aus Aufruf weggeholt)
H*/
 
#include <_calc.h>

pol pgf2red( r,P,Gm )
single r;
obj Gm;
pol P;
{ 	pol Q;
	obj a, e;	
	init( Q, a, e );
	bind(P,Gm);

/* P = 0 */

	if(P==0)   Q=0;


/* r gleich 0 */

	else if (r == 0)     Q=gf2elred(P,Gm);

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0) 
		{ 	e = lfirst(P);
			a = lsecond(P);
			P = lred2(P);
			a = pgf2red(r,a,Gm);
			if(a)   Q = lcomp2(a,e,Q);
		}
		if(Q==_0) Q=0;
		else Q = linv(Q);
	}
	return(Q);
}

