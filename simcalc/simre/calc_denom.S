/*C
			calc_denom( fkeller )

	"calculator denominator".
	list calc_denom(fkeller); list fkeller;
	erg = calc_denom( fkeller );
	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung, das eine Zahl aus Z oder Q, ein Polynom 
	ueber Z oder Q, eine rationale Funktion oder eine Matrix 
	bzw. ein Vektor ueber diesen Strukturen sein muss.
	Berechnt wird Nenner bzw. der Hauptnenner dieses Objektes.
	Laeuft calc_denom fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.01.1992      U.Schneiders
	Version  2      09.03.1993      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

obj calc_denom( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k, r;
	list erg, V;
	init( erg, V );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	k = lsecond( fkeller );
	if( k < 0 || k > 14 ) 
	{       mistake( 154 );
		return( ERROR );
	}

	/*** Nenner bzw. Hauptnenner ***/

	fkeller = lfirst( fkeller );
	switch( k )
	{       case 0:
		case 2:
		case 5:
		case 7:
		case 10:
		case 12: erg = list2( 1, 0 );
			 break;
		case 1: erg = lsecond( fkeller );
			erg = list2( erg, 0 );
			break;
		case 3: V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			V = prnumden( r, fkeller, &erg );
			erg = list2( erg, 0 );
			break;
		case 4: V = lfirst( fkeller );
			fkeller = lsecond( fkeller );
			erg = lsecond( fkeller );
			erg = list2( V, erg );
			erg = list2( erg, 2 );
			break;
		case 6:
		case 8:
		case 9: erg = matrden( fkeller, k );
			break;
		case 11:
		case 13:
		case 14: erg = vecden( fkeller, k );
			 break;
	}

	return( erg );
}
