/*C
			calc_expo( fkeller )

	"calculator exponential function".
	list calc_expo(fkeller); list fkeller;
	erg = calc_expo( fkeller );
	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung, das eine Zahl Z sein muss.
	Berechnt wird e^Z, wobei e die Eulersche Konstante ist.
	Laeuft calc_expo fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      27.01.1992      U.Schneiders
H*/
 
#include <_calc.h>

obj calc_expo( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single k;
	list erg;
	obj w;
	init( erg, w );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );
	k = lsecond( fkeller );
	if( ( k > 1 && k < 15 ) || k < 0 || ( k > 15 && k != 37 && k!=24 ) )
	{       mistake( 152 );
		return( ERROR );
	}
	if( k == 24 )
	{	w = lfirst( varlist[nfsch].varwert );
		erg = list4( 2, 1, 0, 1 );
		if(!oequal(w,erg))
		{	mistake(152);
			return( ERROR );
		}
		fkeller = lfirst(fkeller);
		k=nftyper(fkeller,0,24,37,&erg,&w);
	}
	else erg=lfirst(fkeller);

	/*** Exponentialfunktion ***/

	if( !k )           erg = itofl( erg );
	else if( k == 1 )  erg = rtofl( erg );

	if( k == 37 )
	{	erg = cexp( erg );
		erg = list2( erg, 37 );
	}
	else
	{	erg = flexp( erg );
		erg = list2( erg, 15 );
	}
	return( erg );
}
