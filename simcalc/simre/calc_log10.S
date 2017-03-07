/*C
			calc_log10( fkeller )

	"calculator logarithm, base 10".
	list calc_log10(fkeller); list fkeller;
	erg = calc_log10( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zugehoeriger
	Kennung.
	Berechnet wird die Anzahl der Dezimalstellen der Zahl.
	des Objektes aus fkeller. Dabei sind nur ganze Zahlen als 
	Eingabe zulaessig.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_log10 fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.04.1994      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

obj calc_log10( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	int A;
	init( A );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );

	if ( lsecond( fkeller ) )
	{       mistake( 309 );
		return( -BASIS );
	}

	/*** Logarithmus ganzer Zahlen ***/

	A = ilog10( lfirst( fkeller ) );

	A = list2( A, 0 );
	return( A );
}
