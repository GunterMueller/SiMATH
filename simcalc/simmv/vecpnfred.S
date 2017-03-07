/*C
			 vecpnfred( r, F, V, Fn )

	"vector of polynomials over number field reduction"
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	vec vecpnfred( r, F, V, Fn )  single r;  pol F, Fn;  vec V;
	W = vecpnfred( r, F, V, Fn );
	Dabei muss gelten:
	      - 0 <= r < BASIS.
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - V ist ein Vektor von Polynomen in r Variablen ueber K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        W ist der Vektor, in dem alle Elemente von V reduziert wurden
        und als Polynome ueber Kn aufgefasst werden.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE vecpnfred     : 921130
H*/
/*cS
	vecpnfred ruft auf: lcomp, linv, pnfred
        Macros: lfirst, lred
Sc*/

#include <_matr3.h>

vec vecpnfred( r, F, V, Fn )
single r;
pol F, Fn;
vec V;
{
	list N;
	pol el;
	init( N, el );
	bind( F, V, Fn );
	
	N = _0;
	while( V != _0 )
	{	el = lfirst( V );
		V = lred( V );
		el = pnfred( r, F, el, Fn );
		N = lcomp( el, N );
	}
	N = linv( N );
	return( N );
}
