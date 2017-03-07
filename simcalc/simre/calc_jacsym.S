/*C
			calc_jacsym( fkeller )

	"Calculator Jacobi-Symbol".
	obj calc_jacsym(fkeller); list fkeller;
	X = calc_jacsym( fkeller );

	Berechnet wird das Jacobi-Symbol der in fkeller
	stehenden Parameter.
	Laeuft calc_jacsym fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      22.09.1987      H.Stroeher/M.Mang
H*/
 
#include <_calc.h>

obj calc_jacsym( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	int a, m ;
	list L, L1;
	single s;
	init( L, L1, a, m );
	bind( fkeller );

	/*** Parameterzahl gleich 2? ***/

	if ( llength( fkeller ) != 2 )
	{       mistake( 17 );
		return( -BASIS );
	}
	L = lfirst( fkeller ); L1 = lsecond( fkeller );
	if ( L == -BASIS || L1 == -BASIS ) return( -BASIS );

	/*** Parameter ganzzahlig? ***/

	if ( lsecond( L ) || lsecond( L1 ) )
	{       mistake( 18 );
		return( -BASIS );
	}
	m = lfirst( L ); a = lfirst( L1 );

	/*** Zweiter Parameter positiv und ungerade? ***/

	if ( isign( m ) != 1 || !iodd( m ) ) {
		mistake( 215 );
		return( -BASIS );
	}

	/*** Parameter teilerfremd? ***/

	if ( igcd( a, m ) != 1 ) {
		mistake( 216 );
		return( -BASIS );
	}

	/*** Berechnung des Jacobisymbols ***/

	s = ijacsym( a, m );
	return( list2( s, 0 ) );
}
