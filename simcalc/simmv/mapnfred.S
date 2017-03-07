/*C
			 mapnfred( r, F, M, Fn )

	"matrix of polynomials over number field reduction"
	Quellbibliothek: srclib.matr3
	Include-Datei:   _matr3.h
	matrix mapnfred( r, F, M, Fn )  single r; pol F, Fn; matrix M;
	N = mapnfred( r, F, M, Fn );
	Dabei muss gelten:
	      - 0 <= r < BASIS.
	      - F ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper K er-
		zeugt.	
	      - M ist eine Matrix von Polynomen in r Variablen ueber K.
	      - Fn ist ein irreduzibles Polynom ueber Z in einer Variab-
	        len in dense-Darstellung, das einen Zahlkoerper Kn er-
		zeugt.	
        N ist die Matrix, in der alle Elemente von M reduziert wurden
        und als Polynome ueber Kn aufgefasst werden.
C*/
/*H
	Version 1       23.09.92        U.Schneiders
   DATE mapnfred      : 921130
H*/
/*cS
	mapnfred ruft auf: lcomp, linv, pnfred
        Macros: lfirst, lred
Sc*/

#include <_matr3.h>

matrix mapnfred( r, F, M, Fn )
single r;
pol F, Fn;
matrix M;
{
	list N, Z, ZN;
	pol el;
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
			el = pnfred( r, F, el, Fn );
			ZN = lcomp( el, ZN );
		}
		ZN = linv( ZN );
		N = lcomp( ZN, N );
	}
	N = linv( N );
	return( N );
}
