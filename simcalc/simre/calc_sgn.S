/*C
			calc_sgn( fkeller )

	"calculator sign".
	list calc_sgn(fkeller); list fkeller;
	erg = calc_sgn( fkeller );
	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung.
	erg ist (-1,0), falls das Objekt in fkeller kleiner 0 ist.
		 (0,0), falls das Objekt in fkeller gleich 0 ist.
		 (1,0), falls das Objekt in fkeller groesser 0 ist.
	Laeuft calc_sgn fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  1.1    21.01.1992      U.Schneiders
H*/
 
#include <_calc.h>

obj calc_sgn( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k;
	list erg;
	init( erg );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	k = lsecond( fkeller );
	if( ( k > 1 && k < 15 ) || k < 0  || k > 15 )
	{       mistake( 24 );
		return( -BASIS );
	}

	/*** Vorzeichenbestimmung ***/

	erg = lfirst( fkeller );
	switch( k )
	{       case 0: erg = isign( erg );
			break;
		case 1: erg = rsign( erg );
			break;
		case 15:erg = flsign( erg );
			break;
	}
	erg = list2( erg, 0 );
	return( erg );
}
