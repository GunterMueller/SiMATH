/*C
			calc_ln( fkeller )

	"calculator natuerlicher Logarithmus".
	list calc_ln(fkeller); list fkeller;
	erg = calc_ln( fkeller );
	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung, das eine Zahl Z sein muss.
	Berechnt wird ln( Z ).
	Laeuft calc_ln fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      27.01.1992      U.Schneiders
H*/
 
#include <_calc.h>

obj calc_ln( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k;
	list erg;
	init( erg );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	k = lsecond( fkeller );
	if( ( k > 1 && k < 15 ) || k < 0 || k > 15 )
	{       mistake( 151 );
		return( ERROR );
	}

	erg = lfirst( fkeller );
	switch( k )
	{       case 0: if( isign( erg ) != 1 )
			{       mistake( 151 );
				return( ERROR );
			}
			erg = itofl( erg );
			break;
		case 1: if( rsign( erg ) != 1 )
			{       mistake( 151 );
				return( ERROR );
			}
			erg = rtofl( erg );
			break;
		case 15:if( flsign( erg ) != 1 )
			{       mistake( 151 );
				return( ERROR );
			}
			break;
	}

	/*** Logarithmus ***/

	erg = fllog( erg );
	erg = list2( erg, 15 );
	return( erg );
}
