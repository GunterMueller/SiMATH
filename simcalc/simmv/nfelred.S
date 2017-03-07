/*C
			 nfelred( F, a, Fn )

	"number field element reduction"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	nfel nfelred( F, a, Fn )  pol F, Fn;  nfel a;
	b = nfelred( F, a, Fn );
	Dabei muss gelten:
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - a ist ein Element aus K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        b ist das reduzierte und a entsprechende Zahlkoerperelement aus
	Kn.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE nfelred       : 921130
H*/
/*cS
	nfelred ruft auf: dptop, nfeltoudpr, pitopr, ptodp, udprtonfel
        Macros: prrem
Sc*/

#include <_arith2.h>

nfel nfelred( F, a, Fn )
pol F, Fn;
nfel a;
{
	bind( Fn, a );
	
	a = nfeltoudpr( a );
	a = dptop( 1, a );
	Fn = dptop( 1, Fn );
	Fn = pitopr( 1, Fn );
	a = prrem( 1, a, Fn );
	a = ptodp( 1, a );
	a = udprtonfel( a );
	return( a );
}    
