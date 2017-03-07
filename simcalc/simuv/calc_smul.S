/*C
			calc_smul( a1, a2, t1, t2 )

	"calculator scalar product".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_sprod( a1, a2, t1, t2 );  obj a1, a2; single t1, t2;
	X = calc_sprod( a1, a2, t1, t2 );

	Berechnet wird das Skalarprodukt von a1 und a2, deren Kennung
	t1 und t2 ist. Das Ergebnis wird mit zugehoeriger Kennung in
	X zurueckgegeben.
C*/
/*H
	Version  1      10.01.1989      C.Hollinger/U.Schneiders
	Version  1.1    30.05.1989      C.Hollinger ( sprod -> smul )
	Version  2      02.06.1989      C.Hollinger
	Version  3      12.07.1989      C.Hollinger/U.Schneiders
	Version  4      20.07.1992      U.Schneiders ( nf und mod )
	Version  5      05.07.1993	S.Schmitt ( gf )
H*/

#include<_calc.h>

list calc_smul( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{
	list VL;
	obj b1, b2, M;
	single r, t3;
	init( VL, b1, b2, M );
	bind( a1, a2 );

	if( ( t1 > 9 && t1 < 15 ) || ( t2 > 9  && t2 < 15 )
         || t1 == 21 || t1 == 22 || t2 == 21 || t2 == 22
         || t1 == 28 || t1 == 29 || t2 == 28 || t2 == 29
	 || t1 == 35 || t1 == 36 || t2 == 35 || t2 == 36 )
		t3 = svtyper( a1, a2, t1, t2, &b1, &b2, 1 );
	else    t3 = smtyper( a1, a2, t1, t2, &b1, &b2, 1 );
	if( t3 == ERROR ) return( t3 );

	if( ( t3 > 6 && t3 < 10 ) || ( t3 > 11 && t3 < 15 )
	   || t3 == 20 || t3 == 22 || t3 == 27 || t3 == 29
	   || t3 == 34 || t3 == 36 )
	{	VL = lfirst( b1 );
		r = llength( VL );
		b1 = lsecond( b1 );
		b2 = lsecond( b2 );
	}

	if( t3 > 18 && t3 < 23 )
		M = lfirst( varlist[modsch].varwert );
	else if( t3 > 25 && t3 < 30 )
		M = lfirst( varlist[nfsch].varwert );
	else if( t3 > 30 && t3 < 37 )
		M = lfirst( varlist[gfsch].varwert );

	/*** Berechnung des Skalarmultiplikation. ***/

	switch( t3 )
	{       case 5: b2 = maismul( b2, b1 );
			break;
		case 6: b2 = marsmul( b2, b1 );
			break;
		case 7: b2 = mapismul( r, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 8: b2 = maprsmul( r, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 9: b2 = marfrsmul( r, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 10:b2 = vecismul( b1,b2 );
			break;
		case 11:b2 = vecrsmul( b1,b2 );
			break;
		case 12:b2 = vecpismul( r, b1, b2 );
			b2 = list2( VL,b2 );
			break;
		case 13:b2 = vecprsmul( r, b1, b2 );
			b2 = list2( VL,b2 );
			break;
		case 14:b2 = vecrfrsmul( r, b1, b2 );
			b2 = list2( VL,b2 );
			break;
		case 19:if(M==2)
			{	if(!b1) 
				{	r=llength(b2)-1;
					b2=mam2conszero(r,lfirst(b2));
				}
			}
			else if( ssch ) b2 = mamssmul( M, b2, b1 );
			else       b2 = mamismul( M, b2, b1 );
			break;
		case 20:if( ssch ) b2 = mapmssmul( r, M, b2, b1 );
			else       b2 = mapmismul( r, M, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 21:if( ssch ) b2 = vecmssmul( M, b1, b2 );
			else       b2 = vecmismul( M, b1, b2 );
			break;
		case 22:if( ssch ) b2 = vecpmssmul( r, M, b1, b2 );
			else       b2 = vecpmismul( r, M, b1, b2 );
			b2 = list2( VL, b2 );
			break;
		case 26:b2 = manfsmul( M, b2, b1 );
			break;
		case 27:b2 = mapnfsmul( r, M, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 28:b2 = vecnfsmul( M, b2, b1 );
			break;
		case 29:b2 = vecpnfsmul( r, M, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 33:if(gfchar==2) b2=magf2smul(M,b2,b1);
			else b2 = magfssmul( gfchar, M, b2, b1 );
			break;
		case 34:if(gfchar==2) b2=mapgf2smul(r,M,b2,b1);
			else b2 = mapgfssmul( r, gfchar, M, b2, b1 );
			b2 = list2( VL, b2 );
			break;
		case 35:if(gfchar==2) b2=vecgf2smul(M,b2,b1);
			else b2 = vecgfssmul( gfchar, M, b2, b1 );
			break;
		case 36:if(gfchar==2) b2=vecpgf2smul(r,M,b2,b1);
			else b2 = vecpgfssmul( r, gfchar, M, b2, b1 );
			b2 = list2( VL, b2 );
			break;
	}
	b2 = list2( b2, t3 );
	return( b2 );
}
