/*C
			vecden( M, k )

	"vector denominator".
	Quellbibliothek: srclib.simmv
	Include- Datei: _calc.h
	list vecden( M, k );  list M; single k;
	X = vecden( M, k );

	M enthaelt einen Vektor, eventuell mit zugehoeriger Varia-
	blenliste, und k ist die Kennung von M.
	Berechnet wird der Hauptnenner von M und mit seiner ent-
	sprechenden Kennung zurueckgegeben.
C*/
/*H
	Version  1      05.02.1992      U.Schneiders
H*/
/*cS
	vecden ruft auf: ilcm, llength, pigcdcf, piprod, prnumden,
			 pvinsert
		 Macros: lfirst, list2, lred, lsecond
Sc*/
#include <_calc.h>

list vecden( M, k )
list M;
single k;
{
	single r;
	list V;
	obj el, h, hn, n;
	init( V, el, h, hn, n );
	bind( M );

	if( k > 11 )
	{       V = lfirst( M );
		r = llength( V );
		M = lsecond( M );
	}
	hn = 1;
	if( k == 14 )    hn = pvinsert( 0, hn, r );
	while( M != _0 )
	{       el = lfirst( M );
		M = lred( M );
		if( el )
		{       switch( k )
			{       case 11:n = lsecond( el );
					hn = ilcm( hn, n );
					break;
				case 13:V = prnumden( r, el, &n );
					hn = ilcm( hn, n );
					break;
				case 14:n = lsecond( el );
					h = pigcdcf( r, hn, n, &hn, &el );
					hn = piprod( r, hn, n );
					break;
			}
		}
	}
	if( k == 14 )
	{       hn = list2( V, hn );
		hn = list2( hn, 2 );
	}
	else    hn = list2( hn, 0 );

	return( hn );
}
