/*C
			calc_ceil( fkeller )

	"Calculator rational number ceil".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_ceil( fkeller );  list fkeller;
	X = calc_ceil( fkeller );

	fkeller enthaelt eine Zahl R. calc_ceil berechnet die
	kleinste ganze Zahl, die groesser oder gleich R ist.
	Laeuft calc_ceil fehlerhaft ab, so ist  X  = -BASIS.

C*/
/*H
	Version  1      26.03.1999      S. Schmitt
H*/

#include<_calc.h>
list calc_ceil( fkeller )
list fkeller;

{       single ken;
	list erg;
	init( erg );
	bind( fkeller );

	/*** Ueberpruefung des Parameters. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"ceil" );
		return( -BASIS );
	}
	ken = lsecond( fkeller );
	if( ( ken > 1  && ken < 15 ) || ken < 0 || ken > 15 )
	{       mistake( 218 );
		return( -BASIS );
	}

	if( !ken )
		return( fkeller );

	erg = lfirst( fkeller );

	/*** Berechnung gemaess rceil. ***/

	if( ken == 1 )  erg = rceil( erg );
	else            erg = flceil( erg );
	erg = list2( erg,0 );
	return( erg );
}
