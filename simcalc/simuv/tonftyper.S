/*C
			tonftyper( a1, t1 )

	"to number field typer"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	obj tonftyper( a1, t1 );  obj a1; single t1;
	X = tonftyper( a1, t1 );

	a1 ist ein Objekt mit Kennung t1 = 0, 1, -1, -2, -3, -4.
	X ist a1 umgewandelt als Objekt ueber einem Zahlkoerper.
	Laeuft tonftyper fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      07.12.1993      U.Schneiders
	Version  1.1    10.07.1996      S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

obj tonftyper( a1, t1 )
obj a1;
single t1;
{	obj F, erg, ko[5];
	init(F, erg);
	init( ko[0..4] );
	bind( a1 );

	switch( t1 )
	{	case 0:	erg = itonf( a1 );
			break;
		case 1: erg = rtonf( a1 );
			break;
		case (-1): erg = lfirst( lfirst( a1 ));
			   erg = lred3( erg );
			   ko[0] = lfirst( erg );
			   ko[1] = lsecond( erg );
			   ko[0] = rtonf( ko[0] );
			   ko[1] = rtonf( ko[1] );
			   if(ecqnfsch!=_0)
			   {	F=lfirst(ecqnfsch);
				erg = ecqnfinit(F,0,0,0,ko[0],ko[1]);
			   }
			   else erg = list2( ko[0], ko[1] );
			   break;
		case (-2): erg = lfirst( lfirst( a1 ));
			   ko[0] = lfirst( erg );
			   ko[1] = lsecond( erg );
			   ko[2] = lthird( erg );
			   ko[3] = lfourth( erg );
			   ko[4] = lfifth( erg );
			   ko[0] = rtonf( ko[0] );
			   ko[1] = rtonf( ko[1] );
			   ko[2] = rtonf( ko[2] );
			   ko[3] = rtonf( ko[3] );
			   ko[4] = rtonf( ko[4] );
			   if(ecqnfsch!=_0)
			   {	F=lfirst(ecqnfsch);
				erg=ecqnfinit(F,ko[0],ko[1],ko[2],ko[3],ko[4]);
			   }
			   else erg = list5( ko[0],ko[1],ko[2],ko[3],ko[4] );
			   break;
		case (-3):
		case (-4): if( !lthird( a1 ) )
			   {	if( t1 == (-3) ) erg = 0;
				else
				{	erg = itonf( 1 );
					erg = list3( 0, erg, 0 );
				}
			   }
			   else
			   {	ko[0] = lfirst( a1 );
			   	ko[1] = lsecond( a1 );
			   	ko[2] = lthird( a1 );
			   	ko[3] = iprod( ko[2], ko[2] );
			   	ko[0] = rcons( ko[0], ko[3] );
				ko[0] = rtonf( ko[0] );
			   	ko[3] = iprod( ko[3], ko[2] );
			   	ko[1] = rcons( ko[1], ko[3] );
				ko[1] = rtonf( ko[1] );
			   	if( t1 == (-3 ) ) erg = list2( ko[0],ko[1] );
			   	else
			   	{	ko[3] = itonf( 1 );
					erg = list3( ko[0], ko[1], ko[3] );
			   	}
			   }
			   break;
	}
	
	return( erg );
}
