/*C
			 vecnfred( F, V, Fn )

	"vector of number field elements reduction"
	Quellbibliothek: srclib.matr2
	Include-Datei:   _matr2.h
	vec vecnfred( F, V, Fn )  pol F, Fn;  vec V;
	W = vecnfred( F, V, Fn );
	Dabei muss gelten:
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - V ist ein Vektor von Elementen aus K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        W ist der Vektor, in dem alle Elemente von V reduziert wurden
        und als Elemente von Kn aufgefasst werden.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE vecnfred      : 921130
H*/
/*cS
	vecnfred ruft auf: lcomp, linv, nfelred
        Macros: lfirst, lred
Sc*/

#include <_matr2.h>

vec vecnfred( F, V, Fn )
pol F, Fn;
vec V;
{
	list N;
	nfel el;
	init( N, el );
	bind( F, V, Fn );
	
	N = _0;
	while( V != _0 )
	{	el = lfirst( V );
		V = lred( V );
		el = nfelred( F, el, Fn );
		N = lcomp( el, N );
	}
	N = linv( N );
	return( N );
}
