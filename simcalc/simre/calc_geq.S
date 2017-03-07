/*C
			calc_geq( a1, a2, t1, t2 )

	"calculator greater or equal".
	list calc_geq(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_geq( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Falls a1 und a2 Zahlen oder Moduln sind, so wird der 
	Wert von a2 >= a1 berechnet.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_geq fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.10.1993      S.Schmitt
H*/
 
#include <_calc.h>

list calc_geq( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	single erg, t3;
	obj b1, b2;
	init( b1, b2 );
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if( t1<0 || t2<0 || ( t1>1 && t1<15 ) || ( t2>1 && t2<15 )
	    || t1>16 || t2>16 )
	{       mistake( 284 );
		return( -BASIS );
	}

	if( t1==16 ) t1=0;
	if(t2==16) t2=0;
	t3 = typer( a1, a2, t1, t2, &b1, &b2, 0 );
	if( t3 == -BASIS )      return( -BASIS );
	switch(t3)
	{	case 0:  erg=icomp(b2,b1);
			 break;
	        case 1:  erg=rcomp(b2,b1);
			 break;
		case 15: erg=flcomp(b2,b1);
			 break;
	}
	if(erg==0) erg=1;
	else if(erg==-1) erg=0;
	erg = list2( erg, 0 );
	return( erg );
}
