/*C
			calc_chpol( fkeller )

	"calculator characteristic polynomial".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	obj calc_chpol( fkeller );  list fkeller;
	X = calc_chpol( fkeller );

	fkeller besteht aus einer Matrix mit zugehoeriger Kennung und
	der Polynomvariablen des charakteristischen Polynoms. Berech-
	net wird, falls das Objekt eine quadratische Matrix ist, ihr
	charakteristisches Polynom. Das Ergebnis wird mit zugehoeriger
	Kennung an 'erg' zurueckgegeben.
	Laeuft calc_det fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      08.11.1988         C.Hollinger/U.Schneiders
	Version  2      12.07.1989         C.Hollinger/U.Schneiders
	Version  3      11.09.1992         U.Schneiders ( mod und nf )
	Version  4	15.07.1993	   S.Schmitt ( gf )
	Version  4.1	04.03.1996	   S.Schmitt ( GF(2) )
H*/

#include <_calc.h>

obj calc_chpol( fkeller )
list fkeller;

{
	obj erg, M, var;
	list V, VL, VP;
	single ken, m, n, r, t;
	bind( fkeller );
	init( erg, M, var, V, VL, VP );

	if( fkeller == -BASIS ) return( -BASIS );
	if( llength( fkeller ) != 2 )
	{       mistake( 82 );
		return( -BASIS );
	}
	var = lfirst( fkeller );
	M = lsecond( fkeller );

	/*** Ueberpruefen der Parameter. ***/
	/*** var muss wie folgt aussehen: ( ( name )( 1 1 ), 2 ) ***/

	ken = lsecond( var );
	var = lfirst( var );
	if( ken != 2 )
	{       mistake( 79 );
		return( -BASIS );
	}
	VP = lfirst( var );
	var = lsecond( var );
	if( llength(VP) != 1 || llength(var) != 2 || lfirst(var) != 1 || lsecond(var) != 1 )
	{       mistake( 79 );
		return( -BASIS );
	}
	t = lsecond( M );
	M = lfirst( M );
	if( t < 5 || ( t > 9 && t != 19 && t != 20 && t != 26 && t != 27 && t != 33 && t != 34 ) )
	{       mistake( 80 );
		return( -BASIS );
	}

	/*** Determinantenbildung von M - X*E  ***/
	/*** Man braucht var schon hier wegen der speziellen Bit-Darstellung
		von Matrizen ueber Z/2Z.				***/

	if( t == 19 || t == 20 ) var = lfirst( varlist[modsch].varwert );
	if(t==19 && var==2) M=mam2tomams(M);

	if( ( t > 6 && t < 10 ) || t == 20 || t == 27 || t == 34 )
	{       VL = lfirst( M );
		M = lsecond( M );
		r = llength( VL );
	}
	m = manrrow( M );
	n = manrcol( M );
	if( n != m )
	{       mistake( 80 );
		return( -BASIS );
	}
	if( ( t > 6 && t < 10 ) || t == 20 || t == 27 || t == 34 )
	{       VP = lfirst( VP );
		m = lsrch( VP, VL );
		if( m )
		{       mistake( 81 );
			return( -BASIS );
		}
		V = lcopy( VL );
		V = linv( V );
		V = lcomp( VP,V );
		V = linv( V );
	}
	if( t == 26 || t == 27 ) var = lfirst( varlist[nfsch].varwert );
	else if( t == 33 || t == 34 ) var = lfirst( varlist[gfsch].varwert );

	switch( t )
	{       case 5: erg = maichpol( M );
			erg = list2( VP,erg );
			erg = list2( erg, 2 );
			break;
		case 6: erg = marchpol( M );
			erg = list2( VP,erg );
			erg = list2( erg, 3 );
			break;
		case 7: erg = mapichpol( r, M );
			erg = list2( V, erg );
			erg = list2( erg, 2 );
			break;
		case 8: erg = maprchpol( r, M );
			erg = list2( V, erg );
			erg = list2( erg, 3 );
			break;
		case 9: erg = marfrchpol( r, M );
			erg = list2( V, erg );
			erg = list2( erg, 4 );
			break;
		case 19:if( ssch ) erg = mamschpol( var, M );
			else       erg = mamichpol( var, M );
			erg = list2( VP,erg );
			erg = list2( erg, 18 );
			break;
		case 20:if( ssch ) erg = mapmschpol( r, var, M );
			else       erg = mapmichpol( r, var, M );
			erg = list2( V, erg );
			erg = list2( erg, 18 );
			break;
		case 26:erg = manfchpol( var, M );
			erg = list2( VP,erg );
			erg = list2( erg, 25 );
			break;
		case 27:erg = mapnfchpol( r, var, M );
			erg = list2( V, erg );
			erg = list2( erg, 25 );
			break;
		case 33:if(gfchar!=2) erg = magfschpol( gfchar, var, M );
			else erg=magf2chpol(var,M);
			erg = list2( VP, erg );
			erg = list2( erg, 32 );
			break;
		case 34:if(gfchar!=2) erg = mapgfschpol( r, gfchar, var, M );
			else erg=mapgf2chpol(r,var,M);
			erg = list2( V, erg );
			erg = list2( erg, 32 );
			break;
	}
	return( erg );
}
