/*C
			calc_skalar( fkeller )

	"calculator scalar product".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_skalar( fkeller );  list fkeller;
	X = calc_skalar( fkeller );

	fkeller enthaelt 2 Vektoren a1 und a2.
	Berechnet wird das Skalarprodukt der Vektoren a1 und a2, dh
			< a1, a2 >,
	wobei a1 und a2 Vektoren gleicher Laenge sein muessen.Das
	Ergebnis wird in X mit zugehoeriger Kennung zurueckgegeben.
C*/
/*H
	Version  1      02.06.1989      C.Hollinger
	Version  2      12.07.1989      C.Hollinger/U.Schneiders
	Version  2.1    20.01.1992      U.Schneiders
	Version  3      10.09.1992      U.Schneiders ( mod und nf )
	Version  4	08.07.1993	S.Schmitt ( gf )
H*/

#include<_calc.h>

list calc_skalar( fkeller )
list fkeller;

{
	list VL;
	obj a1, a2, b1, b2, M;
	single r, t1, t2, t3;
	init( VL, a1, a2, b1, b2, M );
	bind( fkeller );

	/*** Ueberpruefung der Argumente. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"scalar" );
		return( -BASIS );
	}
	a1 = lfirst( fkeller );
	t1 = lsecond( a1 );
	a1 = lfirst( a1 );
	a2 = lsecond( fkeller );
	t2 = lsecond( a2 );
	a2 = lfirst( a2 );

	if ( a1 == -BASIS || a2 == -BASIS )     return( -BASIS );
	if( t1 < 10 || t2 < 10 
         || ( t1 > 14 && t1 != 21 && t1 != 22 && t1 != 28 && t1 != 29 && t1 != 35 && t1 != 36 )
         || ( t2 > 14 && t2 != 21 && t2 != 22 && t2 != 28 && t2 != 29 && t2 != 35 && t2 != 36 ) )
	{       mistake1( 34,"scalar" );
		return( -BASIS );
	}

	t3 = vtyper( a1, a2, t1, t2, &b1, &b2, 1 );
	if( t3 == ERROR ) return( t3 );

	/*** Ueberpruefung der Laenge der Vektoren. ***/

	if( ( t1 > 11 && t1 < 15 ) || t1 == 22 || t1 == 29 || t1 == 36 )   a1 = lsecond( b1 );
	if( ( t2 > 11 && t2 < 15 ) || t2 == 22 || t2 == 29 || t2 == 36 )   a2 = lsecond( b2 );
	t1 = llength( a1 );
	t2 = llength( a2 );
	if( t1 != t2 )
	{       mistake( 94 );
		return( -BASIS );
	}

	if( t3 == 21 || t3 == 22 ) M = lfirst( varlist[modsch].varwert );
	else if( t3 == 28 || t3 == 29 ) M = lfirst( varlist[nfsch].varwert );
	else if( t3 == 35 || t3 == 36 ) M = lfirst( varlist[gfsch].varwert );

	/*** Berechnung des Skalarprodukts. ***/

	switch( t3 )
	{       case 10:b1 = vecisprod( b1,b2 );
			break;
		case 11:b1 = vecrsprod( b1,b2 );
			break;
		case 12:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			b1 = vecpisprod( r, b1,b2 );
			b1 = list2( VL,b1 );
			break;
		case 13:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			b1 = vecprsprod(  r, b2, b1 );
			b1 = list2( VL,b1 );
			break;
		case 14:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			b1 = vecrfrsprod(  r, b2, b1 );
			b1 = list2( VL,b1 );
			break;
		case 21:if( ssch ) b1 = vecmssprod( M, b1, b2 );
			else       b1 = vecmisprod( M, b1, b2 );
			break;
		case 22:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			if( ssch ) b1 = vecpmssprod( r, M, b1, b2 );
			else       b1 = vecpmisprod( r, M, b1, b2 );
			b1 = list2( VL,b1 );
			break;
		case 28:b1 = vecnfsprod( M, b1, b2 );
			break;
		case 29:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			b1 = vpnfsprod( r, M, b1, b2 );
			b1 = list2( VL, b1 );
			break;
		case 35:if(gfchar==2) b1=vecgf2sprod(M,b1,b2);
			else b1 = vecgfssprod(gfchar,M,b1,b2);
			break;
		case 36:VL = lfirst(b1);
			r = llength(VL);
			b1 = lsecond(b1);
			b2 = lsecond(b2);	
			if(gfchar==2) b1=vecpgf2sprod(r,M,b1,b2);
			else b1 = vpgfssprod(r,gfchar,M,b1,b2);
			b1 = list2(VL,b1);
			break;
	}
	if( t3 < 15 ) t3 = t3 - 10;
	else          t3 = t3 - 4;
	b1 = list2( b1,t3 );
	return( b1 );
}
