/*C
			calc_log2( fkeller )

	"calculator logarithm, base 2".
	list calc_log2(fkeller); list fkeller;
	erg = calc_log2( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zugehoeriger
	Kennung.
	Berechnet wird der ganzzahlige Anteil des Logarithmus zur Basis 2
	des Objektes aus fkeller. Dabei sind nur positive rationale
	Zahlen als Eingabe zulaessig.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_log2 fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      06.05.1987      H.Stroeher/M.Mang
H*/
 
#include <_calc.h>

obj calc_log2( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	int A;
	list erg;
	init( A ,erg );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );

	if ( lsecond( fkeller ) > 1 || lsecond( fkeller ) < 0 )
	{       mistake( 21 );
		return( -BASIS );
	}

	if ( !lsecond( fkeller ) ) {

	/*** Logarithmus ganzer positiver Zahlen ***/

		if ( isign( lfirst( fkeller ) ) < 1 )
		{       mistake( 21 );
			return( -BASIS );
		}
		A = ilog2( lfirst( fkeller ) );
		A = idif( A, 1 );
	}
	else {

	/*** Logarithmus positiver rationaler Zahlen ***/

		if ( isign( lfirst( lfirst( fkeller ) ) ) < 1 )
		{       mistake( 21 );
			return( -BASIS );
		}
		A = rlog2(  lfirst( fkeller ) );
		if( isign( A ) != (-1) )   A = idif( A, 1 );
	}
	erg = list2( A, 0 );
	return( erg );
}
