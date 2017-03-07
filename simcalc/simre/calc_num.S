/*C
			calc_num( fkeller )

	"calculator numerator".
	list calc_num(fkeller); list fkeller;
	erg = calc_num( fkeller );
	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung, das eine Zahl aus Z oder Q, ein Polynom 
	ueber Z oder Q, eine rationale Funktion oder eine Matrix 
	bzw. ein Vektor ueber diesen Strukturen sein muss.
	Berechnt wird Zaehler dieses Objektes.
	Laeuft calc_num fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.01.1992      U.Schneiders
	Version  2      09.03.1993      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list calc_num( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k, r;
	list erg, h, V;
	init( erg, h, V );
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
		case 12: erg = list2( fkeller, k );
			 break;
		case 1: erg = lfirst( fkeller );
			erg = list2( erg, 0 );
			break;
		case 3: V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			erg = prnumden( r, fkeller, &h );
			erg = list2( V, erg );
			erg = list2( erg, 2 );
			break;
		case 4: V = lfirst( fkeller );
			fkeller = lsecond( fkeller );
			erg = lfirst( fkeller );
			erg = list2( V, erg );
			erg = list2( erg, 2 );
			break;
		case 6: erg = matrden( fkeller, k );
			erg = lfirst( erg );
			erg = itor( erg );
			erg = marsmul( fkeller, erg );
			erg = list2( erg, 6 );
			break;
		case 8: erg = matrden( fkeller, k );
			V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			erg = lfirst( erg );
			erg = pvinsert( 0, erg, r );
			erg = pitopr( r, erg );
			erg = maprsmul( r, fkeller, erg );
			erg = list2( V, erg );
			erg = list2( erg, 8 );
			break;
		case 9: erg = matrden( fkeller, k );
			V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			erg = lfirst( erg );
			erg = lsecond( erg );
			erg = pitorfr( r, erg );
			erg = marfrsmul( r, fkeller, erg );
			erg = list2( V, erg );
			erg = list2( erg, 9 );
			break;
		case 11:erg = vecden( fkeller, k );
			erg = lfirst( erg );
			erg = itor( erg );
			erg = vecrsmul( erg, fkeller );
			erg = list2( erg, 11 );
			break;
		case 13:erg = vecden( fkeller, k );
			V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			erg = lfirst( erg );
			erg = pvinsert( 0, erg, r );
			erg = pitopr( r, erg );
			erg = vecprsmul( r, erg, fkeller );
			erg = list2( V, erg );
			erg = list2( erg, 13 );
			break;
		case 14:erg = vecden( fkeller, k );
			V = lfirst( fkeller );
			r = llength( V );
			fkeller = lsecond( fkeller );
			erg = lfirst( erg );
			erg = lsecond( erg );
			erg = pitorfr( r, erg );
			erg = vecrfrsmul( r, erg, fkeller );
			erg = list2( V, erg );
			erg = list2( erg, 14 );
			break;
	}

	return( erg );
}
