/*C
			calc_equ( a1, a2, t1, t2 )

	"calculator equal".
	list calc_equ(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_equ( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Es wird der Wert von a2 == a1 berechnet.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_equ fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.10.1993      S.Schmitt
H*/
 
#include <_calc.h>

list calc_equ( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	single erg, t3;
	obj b1, b2;
	init(b1, b2);
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if( t1 != t2 )
	{	if( ( ( t1==0 || t1==1 || t1==15 || t1 == 37 ) 
		   && ( t2==0 || t2==1 || t2==15 || t2 == 37 ) ) 
		 || ( t1>16 && t1<23 && t2==(t1+14) ) 
		 || ( t2>16 && t2<23 && t1==(t2+14) ) )
		{ 	t3 = typer( a1, a2, t1, t2, &b1, &b2, 0 );
			if( t3 == -BASIS )      return( list2(0,0) );
		}
		else if( ( t1==24 && t2==37 ) || ( t1==37 && t2==24 ) 
		      || ( t1==25 && t2==39 ) || ( t1==39 && t2==25 ) )
		{	b1 = lfirst( varlist[nfsch].varwert );
			b2 = list4( 2, 1, 0, 1 );
			if(!oequal(b1,b2)) return( list2(0,0) );
			t3=nftyper(a1,a2,t1,t2,&b1,&b2);
		}
		else if( (t1==(-7) && t2==(-15)) || (t1==(-15) && t2==(-7)) 
                || (t1==(-8) && t2==(-16)) || (t1==(-16) && t2==(-8)) 
                || (t1==(-6) && t2==(-14)) || (t1==(-14) && t2==(-6)) )
		{	if( t1 > (-9) )
			{	b1 = togftyper(a1,t1,0);
				if(b1==ERROR) return(list2(0,0));
				b2=a2;
			}
			else if( t2 > (-9) )
			{	b2 = togftyper(a2,t2,0);
				if(b2==ERROR) return(list2(0,0));
				b1=a1;
			}
		}
		else return( list2(0,0) );
	}
	else 
	{	b1=a1;
		b2=a2;
	}

	erg = oequal(b1,b2);

	erg = list2( erg, 0 );
	return( erg );
}
