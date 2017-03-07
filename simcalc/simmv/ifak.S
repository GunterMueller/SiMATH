/*C
			ifak( keller, vprio )

	"calculator integer factorial".
	list ifak(keller,vprio); list keller; single vprio;
	keller = ifak( keller, vprio );

	Berechnet wird die Fakultaet des ersten Objekts der Liste keller.
	Das Ergebnis wird mit zugehoeriger Kennung an Stelle des Objektes
	in den Keller geschrieben.
	Zulaessige Eingaben sind nur einfachgenaue Zahlen, die groesser
	oder gleich Null sind. Dabei gilt, dass ein unaeres Minus eine
	hoehere Prioritaet als der Operator '!' besitzt.
	Laeuft ifak fehlerhaft ab, so ist keller = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
H*/
/*cS
	ifak ruft auf:  fputr, ifactl, lcomp

	       Macros:  isatom, lfirst, list2, lred, lsecond, putr
Sc*/
 
#include <_calc.h>

list ifak( keller, vprio )
list keller;
single vprio;

{       /*** Deklarationen und Vorbesetzungen ***/

	int Erg;
	single a, t;
	init( Erg );
	bind( keller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( lfirst( keller ) == -BASIS ) return( -BASIS );
	a = lfirst( lfirst( keller ) );
	t = lsecond( lfirst( keller ) );
	if ( t ) {
		mistake( 252 );
		return( -BASIS );
	}
	else {
		keller = lred( keller );
		if ( !( isatom( a ) ) ) {
			mistake( 252 );
			return( -BASIS );
		}
		if ( a < 0 ) {
			mistake( 252 );
			return( -BASIS );
		}
		if ( vprio == 2 ) {
			mistake( 252 );
			return( -BASIS );
		}

	/*** Berechnung von a! und Neuaufbau des Kellers ***/

		if ( a == 0 ) Erg = 1;
		else Erg = ifactl( a );
	}
	Erg = list2( Erg, 0 );
	keller = lcomp( Erg, keller );
	return( keller );
}
