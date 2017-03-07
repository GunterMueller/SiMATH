/*C
			matrden( M, k )

	"matrix denominator".
	Quellbibliothek: srclib.simmv
	Include- Datei: _calc.h
	list matrden( M, k );  list M; single k;
	X = matrden( M, k );

	M enthaelt eine Matrix, eventuell mit zugehoeriger Varia-
	blenliste, und k ist die Kennung von M.
	Berechnet wird der Hauptnenner von M und mit seiner ent-
	sprechenden Kennung zurueckgegeben.
C*/
/*H
	Version  1      05.02.1992      U.Schneiders
H*/
/*cS
	matrden ruft auf: ilcm, llength, pigcdcf, piprod, prnumden,
			  pvinsert
		  Macros: lfirst, list2, lred, lsecond
Sc*/
#include <_calc.h>

list matrden( M, k )
list M;
single k;
{
	single r;
	list V, Z;
	obj el, h, hn, n;
	init( V, Z, el, h, hn, n );
	bind( M );

	if( k > 6 )
	{       V = lfirst( M );
		r = llength( V );
		M = lsecond( M );
	}
	hn = 1;
	if( k == 9 )    hn = pvinsert( 0, hn, r );
	while( M != _0 )
	{       Z = lfirst( M );
		M = lred( M );
		while( Z != _0 )
		{       el = lfirst( Z );
			Z = lred( Z );
			if( el )
			{       switch( k )
				{       case 6: n = lsecond( el );
						hn = ilcm( hn, n );
						break;
					case 8: V = prnumden( r, el, &n );
						hn = ilcm( hn, n );
						break;
					case 9: n = lsecond( el );
						h = pigcdcf( r, hn, n, &hn, &el );
						hn = piprod( r, hn, n );
						break;
				}
			}
		}
	}
	if( k == 9 )
	{       hn = list2( V, hn );
		hn = list2( hn, 2 );
	}
	else    hn = list2( hn, 0 );

	return( hn );
}
