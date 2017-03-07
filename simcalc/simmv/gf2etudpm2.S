/*C
			gf2etudpm2( a )

	"Galois-field with characteristic 2 element to univariate 
	dense polynomial over modular 2"	
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	pol gf2eltoudpm2(a)  gf2el a;
	P = gf2eltoudpm2(a);
	Voraussetzungen:
	     -  a ist ein Element aus GF(2^n), das als Polynom in einer 
		Variablen ueber Z/2Z vom Grad < n in spezieller Bit-
		Notation dargestellt wird.	
	Ergebnis: P ist die Darstellung von a als dense-Polynom in 
		einer Variablen ueber Z/2Z[X].
C*/
/*H
	Version 1       14.03.1996	S.Schmitt 
					( Diese Funktion ist gf2eltoudpm2,
					  nur muss hier das Polynom G nicht 
					  mitgegeben werden, dass sowieso nicht
					  gebraucht wird! ) 
H*/

#include <_arith2.h>

pol gf2etudpm2(a)
gf2el a;
{
	if ( !a ) return( 0 );
   {
	single e, e1, k, i;
	pol P;
	init(P);
	bind(a);

	e = lfirst(a); a = lred(a);
	a = lcinv(a); 
	P = _0;
	e1 = e / 30;
	while ( e1-- ) {
		k = lfirst(a); a = lred(a);
		P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
                for( i=29; i--; ) {
			k >>= 1;
			P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
		}
	}
	k = lfirst(a); a = lred(a);
	for( ; k; k>>=1 ) P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
    	return( lcomp(e,P) );
    }
}
