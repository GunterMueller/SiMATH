/*C
			calc_det( fkeller )

	"calculator determinant".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	obj calc_det( fkeller );  list fkeller;
	X = calc_det( fkeller );

	fkeller besteht aus einem Objekt mit zugehoeriger Kennung. Be-
	rechnet wird, falls das Objekt eine quadratische Matrix ist,
	ihre Determinante. Das Ergebnis wird mit zugehoeriger Kennung
	an 'erg' zurueckgegeben.
	Laeuft calc_det fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      02.11.1988      U.Schneiders
	Version  2      12.07.1989      C.Hollinger/U.Schneiders
	Version  3      28.07.1992      U.Schneiders ( mod und nf )
	Version  4	15.07.1993	S.Schmitt ( gf )
	Version  4.1	04.03.1996	S.Schmitt ( GF(2) )
H*/

#include <_calc.h>

obj calc_det( fkeller )
list fkeller;

{
	obj erg, M;
	list VL;
	single m, n, r, t;
	bind( fkeller );
	init( erg, VL );

	if( fkeller == -BASIS )      return( -BASIS );
	erg = lfirst( fkeller );
	t = lsecond( fkeller );

	if( t < 5 || ( t > 9 && t != 19 && t != 20 && t != 26 && t != 27 && t != 33 && t != 34 ) )
	{       mistake( 74 );
		return( -BASIS );
	}

	/*** Determinantenbildung ***/
	/*** Man braucht M schon hier wegen der speziellen Bit-Darstellung
		von Matrizen ueber Z/2Z.				***/

	if( t == 19 || t == 20 ) M = lfirst( varlist[modsch].varwert );
	if(t==19 && M==2)	erg=mam2tomams(erg);

	if( ( t > 6 && t < 10 ) || t == 20 || t == 27 || t == 34 )
	{       VL = lfirst( erg );
		erg = lsecond( erg );
		r = llength( VL );
	}
	m = manrrow( erg );
	n = manrcol( erg );
	if( n != m )
	{       mistake( 74 );
		return( -BASIS );
	}

	if( t == 26 || t == 27 ) M = lfirst( varlist[nfsch].varwert );
	else if( t == 33 || t == 34 ) M = lfirst( varlist[gfsch].varwert );

	switch( t )
	{       case 5: erg = maidet( erg );
			erg = list2( erg, 0 );
			break;
		case 6: erg = mardet( erg );
			erg = list2( erg, 1 );
			break;
		case 7: erg = mapidet( r, erg );
			erg = list2( VL, erg );
			erg = list2( erg, 2 );
			break;
		case 8: erg = maprdet( r, erg );
			erg = list2( VL, erg );
			erg = list2( erg, 3 );
			break;
		case 9: erg = marfrdet( r, erg );
			erg = list2( VL, erg );
			erg = list2( erg, 4 );
			break;
		case 19:if( ssch ) erg = mamsdet( M, erg );
			else	   erg = mamidet( M, erg );
			erg = list2( erg, 17 );
			break;
		case 20:if( ssch ) erg = mapmsdet( r, M, erg );
			else       erg = mapmidet( r, M, erg );
			erg = list2( VL, erg );
			erg = list2( erg, 18 );
			break;
		case 26:erg = manfdet( M, erg );
			erg = list2( erg, 24 );
			break;
		case 27:erg = mapnfdet( r, M, erg );
			erg = list2( VL, erg );
			erg = list2( erg, 25 );
			break;
		case 33:if(gfchar!=2) erg = magfsdet( gfchar, M, erg );
			else erg=magf2det(M,erg);
			erg = list2( erg, 31 );
			break;
		case 34:if(gfchar!=2) erg = mapgfsdet( r, gfchar, M, erg );
			else erg=mapgf2det(r,M,erg);
			erg = list2( VL, erg );
			erg = list2( erg, 32 );
			break;
	}
	return( erg );
}
