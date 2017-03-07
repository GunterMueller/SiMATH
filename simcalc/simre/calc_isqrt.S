/*C
			calc_isqrt( fkeller )

	"calculator square root".
	list calc_isqrt( fkeller ); list fkeller;
	erg = calc_isqrt( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt, welches eine
	ganze Zahl darstellt und zugehoeriger Kennung. Der ganzzahlige
	Anteil der Quadratwurzel aus der Zahl in fkeller wird zurueckgegeben.
	Laeuft calc_isqrt fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      30.03.1999      S. Schmitt
H*/
 
#include <_calc.h>

list calc_isqrt(fkeller)
obj fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj a1,M; 
	single t1;
	init( a1,M );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );

	a1 = lfirst( fkeller ); t1 = lsecond( fkeller );
	if( t1!=0 )
	{       mistake( 298 );
		return( -BASIS );
	}
	if( isign( a1 ) < 0 )
	{       mistake( 298 );
		return( -BASIS );
	}

	M=isqrt(a1);
	M=list2(M,0);
	return(M);
}
