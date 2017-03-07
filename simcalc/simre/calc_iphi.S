/*C
			calc_iphi( fkeller )

	"Calculator Eulersche phi- Funktion".
	list calc_iphi(fkeller); list fkeller;
	L = calc_iphi( fkeller );

	fkeller ist eine Liste, bestehend aus einem Objekt und zuge-
	hoeriger Kennung. Berechnet wird der Wert der Eulerschen phi-
	Funktion des Objekts. Dieser wird mit zugehoeriger Kennung an
	das aufrufende Programm zurueckgeliefert.
	Laeuft calc_iphi fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      15.10.1987      C.Hollinger/U.Schneiders
H*/
 
#include <_calc.h>

list calc_iphi( fkeller )
list fkeller;

{       /*** Deklaration und Vorbesetzung ***/

	list L;
	int L1;
	init( L1, L );
	L=_0;
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller==-BASIS ) return ( -BASIS );

	L1=lfirst( fkeller );
	if ( lsecond( fkeller )>=1 || lsecond( fkeller )<0 || isign( L1 )<1 )
	{       mistake( 16 );
		return( -BASIS );
	}

	/*** Auswertung ***/

	L=iphi( L1 );
	L=list2( L, 0 );
	return(L);
}
