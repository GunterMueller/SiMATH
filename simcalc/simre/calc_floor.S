/*C
			calc_floor( fkeller )

	"Calculator rational number floor".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_floor( fkeller );  list fkeller;
	X = calc_floor( fkeller );

	fkeller enthaelt eine Zahl R. calc_floor berechnet die
	groesste ganze Zahl, die kleiner oder gleich R ist.
	Laeuft calc_floor fehlerhaft ab, so ist  X  = -BASIS.

C*/
/*H
	Version  1      20.12.1988      C.Hollinger/U.Schneiders
	Version  1.1    11.04.1991      U.Schneiders
	Version  2      21.01.1992      U.Schneiders ( Reelle Zahlen )
H*/

#include<_calc.h>
list calc_floor( fkeller )
list fkeller;

{       single ken;
	list erg;
	init( erg );
	bind( fkeller );

	/*** Ueberpruefung des Parameters. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"floor" );
		return( -BASIS );
	}
	ken = lsecond( fkeller );
	if( ( ken > 1  && ken < 15 ) || ken < 0 || ken > 15 )
	{       mistake( 86 );
		return( -BASIS );
	}

	if( !ken )
		return( fkeller );

	erg = lfirst( fkeller );

	/*** Berechnung gemaess rfloor. ***/

	if( ken == 1 )  erg = rfloor( erg );
	else            erg = flfloor( erg );
	erg = list2( erg,0 );
	return( erg );
}
