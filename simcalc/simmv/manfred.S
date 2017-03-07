/*C
			 manfred( F, M, Fn )

	"matrix of number field elements reduction"
	Quellbibliothek: srclib.matr2
	Include-Datei:   _matr2.h
	matrix manfred( F, M, Fn )  pol F, Fn;  matrix M;
	N = manfred( F, M, Fn );
	Dabei muss gelten:
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - M ist eine Matrix von Elementen aus K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        N ist die Matrix, in der alle Elemente von M reduziert wurden
        und als Elemente von Kn aufgefasst werden.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE manfred       : 921130
H*/
/*cS
	manfred ruft auf: lcomp, linv, nfelred
        Macros: lfirst, lred
Sc*/

#include <_matr2.h>

matrix manfred( F, M, Fn )
pol F, Fn;
matrix M;
{
	list N, Z, ZN;
	nfel el;
	init( N, Z, ZN, el );
	bind( F, M, Fn );
	
	N = _0;
	while( M != _0 )
	{	ZN = _0;
		Z = lfirst( M );
		M = lred( M );
		while( Z != _0 )
		{	el = lfirst( Z );
			Z = lred( Z );
			el = nfelred( F, el, Fn );
			ZN = lcomp( el, ZN );
		}
		ZN = linv( ZN );
		N = lcomp( ZN, N );
	}
	N = linv( N );
	return( N );
}
