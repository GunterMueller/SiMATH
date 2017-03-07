/*C
			 pnfred( r, F, P, Fn )

	"polynomial over number field reduction"
	Quellbibliothek: srclib.pol3
	Include-Datei:   _pol3.h
	pol pnfred( r, F, P, Fn )  single r;  pol F, P, Fn;
	Q = pnfred( r, F, P, Fn );
	Dabei muss gelten:
	      - 0 <= r < BASIS.
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - P ist ein Polynom in r Variablen ueber K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        Q ist das reduzierte und P entsprechende Polynom ueber Kn.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE pnfred        : 921130
H*/
/*cS
	pnfred ruft auf: diptop, lcomp2, linv, nfelred, ptodip
        Macros: lfirst, lred2, lsecond
Sc*/

#include <_pol3.h>

pol pnfred( r, F, P, Fn )
single r;
pol F, P, Fn;
{
	list ks, L;
	nfel kf;
	init( kf, ks, L );
	bind( F, P, Fn );
   
	if(P==0) return(0);
	P = ptodip( r, P );
	for( L = _0; P != _0; P = lred2( P ) )
	{	kf = lfirst( P );
		ks = lsecond( P );
		kf = nfelred( F, kf, Fn );
		L  = lcomp2( ks, kf, L );
	}
	P = linv( L );
	P = diptop( r, P );
	return( P );
}
	 	
