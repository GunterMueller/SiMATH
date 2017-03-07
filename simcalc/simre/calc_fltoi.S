/*C
			calc_fltoi( fkeller )

	"calculator floating points to integers".
	int calc_fltoi(fkeller); list fkeller;
	X = calc_fltoi( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zuge-
	hoeriger Kennung.
	Das in fkeller stehende Objekt wird in eine Struktur ueber 
        den ganzen Zahlen umgewandelt, falls es moeglich ist.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	02.03.1995	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

int calc_fltoi( fkeller )
list fkeller;
{       /*** Deklarationen und Vorbesetzungen ***/

	single e, k, r;
	obj VL, Z;
	init( VL, Z );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS);
	Z = lfirst( fkeller );
	k = lsecond( fkeller );

	if( k && k!=2 && k!=15 && k!=38 )
	{       mistake( 135 );
		return( -BASIS );
	}
	if( k==0 || k==2 ) return( fkeller );

	switch(k)
	{	case 15: if(!Z) Z = list2(0,0);
			 else
			 {  e = lfirst( Z );
			    if( e >= 0 )
			    {   Z = lred( Z );
				while( e-- )  Z = lcomp( 0,Z );
				if( llength( Z ) == 1 ) Z = lfirst( Z );
				Z = list2( Z, 0 );
			    }
			    else
			    {	mistake( 136 );
				return( ERROR );
			    }
			 }
			 break;
		case 38: VL = lfirst(Z);
			 r = llength(VL);
			 Z = lsecond(Z);
 			 Z = pfltopiip( r, Z, &e );
			 if( !e )
			 {	mistake( 136 );
				return( ERROR );
			 }
			 Z = list2( VL,Z );
			 Z = list2( Z,2 );	
			 break;
		default: break;
	}

	return( Z );
}
