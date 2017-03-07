/*C
			calc_and( a1, a2, t1, t2 )

	"calculator and".
	list calc_and(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_and( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Es wird der Wert von a2 && a1 berechnet.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_and fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.10.1993      S.Schmitt
H*/
 
#include <_calc.h>

list calc_and( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	single erg;
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if( ( t1!=0 && t1!=1 && t1!=15 &&  t1!=17 && t1!=24 && t1!=31 && t1!=37 )
	  || ( t2!=0 && t2!=1 && t2!=15 && t2!=17 && t2!=24 && t2!=31 && t2!=37 ) )
	{       mistake( 283 );
		return( -BASIS );
	}

	if( a1 && a2 ) erg=1;
	else  erg=0;
	erg = list2( erg, 0 );
	return( erg );
}
