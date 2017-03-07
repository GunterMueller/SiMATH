/*C
			valcontrol( w1, w2 )

	"value control".
	single valcontrol( w1, w2 );
	list w1, w2;

	valcontrol ueberprueft zuerst, ob die Kennungen von w1 und w2
	identisch sind; falls ja, untersucht valcontrol, ob die Werte
	von w1 und w2 uebereinstimmen. Bei der ersten Erkennung einer
	Nichtgleichheit gibt valcontrol Fehlermeldung aus und liefert
	O zurueck; bei vollkommener Gleichheit 1.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.01.88        C.Hollinger/U.Schneiders
	Version  2      18.09.92        U.Schneiders ( mod und nf )
	Version  3      27.07.93        U.Schneiders ( gf )
	Version  4      15.02.95        S.Schmitt ( R und C )
H*/
 
#include<_calc.h>
single valcontrol( w1,w2 )
list w1,w2;
{
	single a1,a2, h, r1, r2, r3;
	obj V1,V2, N1, N2, Z1, Z2;
	list VL1, VL2, VL3, P1, P2, nP1, nP2;
	init( V1,V2, N1, N2, Z1, Z2, VL1, VL2, VL3, P1, P2, nP1, nP2 );
	bind( w1, w2 );

	a1 = lsecond( w1 );
	a2 = lsecond( w2 );
	if( a1 != a2 )
	{       mistake( 33 );
		return( 0 );
	}
	V1 = lfirst( w1 );
	V2 = lfirst( w2 );
	switch( a1 )
	{       case 0:
		case 1: h = isequintrat( V1, V2 );
			break;
		case 15:
		case 17:
		case 24:
		case 31:
		case 37:h = oequal( V1, V2 );
			if( !h )  mistake( 33 );
			break;
		case 2:
		case 3:
		case 18:
		case 25:
		case 32:
		case 38:
		case 39:VL1 = lfirst( V1 );
			P1 = lsecond( V1 );
			VL2 = lfirst( V2 );
			P2 = lsecond( V2 );
			r1 = llength( VL1 );
			r2 = llength( VL2 );
			if( r1 != r2 )
			{       mistake( 33 );
				return( 0 );
			}
			VL3 = pvmix( VL1, VL2, P1, P2, &nP1, &nP2 );
			r3 = llength( VL3 );
			if( r3 != r1 || r3 != r2 )
			{       mistake( 33 );
				return( 0 );
			}
			if( a1 < 4 ) h = isequpol( r1, nP1, nP2 );
			else
			{     h = oequal( nP1, nP2 );
			      if( !h )   mistake( 33 );
			}
			break;
		case 4: VL1 = lfirst( V1 );
			V1 = lsecond( V1 );
			Z1 = lfirst( V1 );
			N1 = lsecond( V1 );
			VL2 = lfirst( V2 );
			V2 = lsecond( V2 );
			Z2 = lfirst( V2 );
			N2 = lsecond( V2 );
			Z1 = list2( VL1, Z1 );
			N1 = list2( VL1, N1 );
			Z2 = list2( VL2, Z2 );
			N2 = list2( VL2, N2 );
			Z1 = list2( Z1,2 );
			Z2 = list2( Z2,2 );
			h = valcontrol( Z1,Z2 );
			if( !h ) return( 0 );
			N1 = list2( N1,2 );
			N2 = list2( N2,2 );
			h = valcontrol( N1,N2 );
			break;
	}
	return( h );
}
