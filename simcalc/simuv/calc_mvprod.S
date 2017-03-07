/*C
			calc_mvprod( a1, a2, t1, t2 )

	"calculator matrix vector multiplication".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_mvprod( a1, a2, t1, t2 );  obj a1, a2; single t1, t2;
	X = calc_mvprod( a1, a2, t1, t2 );

	Berechnet wird das Matrixvektorprodukt von a1 und a2. Der Er-
	gebnisvektor wird mit zugehoeriger Kennung zurueckgegeben.
C*/
/*H
	Version  1      26.04.1989      C.Hollinger/U.Schneiders
	Version  1.1    30.05.1989      C.Hollinger    ( V * M )
	Version  2      12.07.1989      C.Hollinger/U.Schneiders
	Version  3      20.07.1992      U.Schneiders ( mod und nf )
	Version  4	05.07.1993	S.Schmitt ( gf )
H*/

#include<_calc.h>

list calc_mvprod( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{
	list VL;
	obj b1, b2, M;
	single n1, n2, r, sch = 0, t3;
	init( VL, b1, b2, M );
	bind( a1, a2 );

	/*** Matrix * Vektor. ***/
	if( t2 < 10 || t2 == 19 || t2 == 20 || t2 == 26 || t2 == 27
	    || t2 == 33 || t2 == 34 ) 
	{       b1 = a1;
		a1 = a2;
		a2 = b1;
		sch = t1;
		t1 = t2;
		t2 = sch;
		sch = 1;
	}

	/*** Dimensionen ueberpruefen. ***/
	/*** Man braucht schon hier M, da Matrizen ueber Z/2Z in
		spezieller Bit-Darstellung gegeben sind.	***/

	if( t1 == 19 ) M = lfirst( varlist[modsch].varwert );

	if( ( t2 > 11 && t2 < 15 ) || t2 == 22 || t2 == 29 || t2 == 36 )
	{       b2 = lsecond( a2 );
		n2 = llength( b2 );
	}
	else    n2 = llength( a2 );
	if( ( t1 > 6 && t1 < 10 ) || t1 == 20 || t1 == 27 || t1 == 34 )
	{       b1 = lsecond( a1 );
		if( sch )       n1 = manrcol( b1 );
		else    n1 = manrrow( b1 );
	}
	else
	{	if(t1==19 && M==2)
		{	if(sch) n1=lfirst(a1);
			else 	n1=llength(a1)-1;
		}
		else
		{    	if(sch) n1 = manrcol( a1 );
			else    n1 = manrrow( a1 );
		}
	}

	if( n1 != n2 )
	{       mistake( 72 );
		return( -BASIS );
	}

	t3 = vmtyper( a1, a2, t1, t2, &b1, &b2, 1 );
	if( t3 == ERROR ) return( ERROR );

	/*** Berechn. der Matrixvektormultiplikation   ***/

	if( ( t3 > 6 && t3 < 10 ) || t3 == 20 || t3 == 27 || t3 == 34 )
        {       b2 = lsecond( b2 );
		VL = lfirst( b1 );
		r = llength( VL );
		b1 = lsecond( b1 );
	}
	if( !sch ) 
	{	if(t3==19 && M==2) b2=mam2transp(b2);
		else
		{	M = lcopy( b2 );
			b2 = matrans( M );
		}
	}

	if( t3 == 20 ) M = lfirst( varlist[modsch].varwert );
	else if( t3 == 26 || t3 == 27 ) M = lfirst( varlist[nfsch].varwert );
	else if( t3 == 33 || t3 == 34 ) M = lfirst( varlist[gfsch].varwert );

	switch( t3 )
	{       case 5: b1 = maivecmul( b2, b1 );
			break;
		case 6: b1 = marvecmul( b2, b1 );
			break;
		case 7: b1 = mapivecmul( r, b2, b1 );
			b1 = list2( VL, b1 );
			break;
		case 8: b1 = maprvecmul( r, b2, b1 );
			b1 = list2( VL, b1 );
			break;
		case 9: b1 = marfrvecmul( r, b2, b1 );
			b1 = list2( VL, b1 );
			break;
		case 19:if(M==2) b2=mam2tomams(b2);
			if( ssch ) b1 = mamsvecmul( M, b2, b1 );
			else       b1 = mamivecmul( M, b2, b1 );
			break;
		case 20:if( ssch ) b1 = mapmsvecmul( r, M, b2, b1 );
			else       b1 = mapmivecmul( r, M, b2, b1 );
			b1 = list2( VL, b1 );
			break;
		case 26:b1 = manfvecmul( M, b2, b1 );
			break;
		case 27:b1 = mapnfvecmul( r, M, b2, b1 );
			b1 = list2( VL, b1 );
			break;
		case 33:if(gfchar==2) b1=magf2vecmul(M,b2,b1);
			else b1 = magfsvecmul( gfchar, M, b2, b1 );
			break;
		case 34:if(gfchar==2) b1=mapgf2vmul(r,M,b2,b1);
			else b1 = mapgfsvmul( r, gfchar, M, b2, b1 );
			b1 = list2( VL, b1 );
			break;
	}
	if( t3 < 10 ) t3 = t3 + 5;
	else          t3 = t3 + 2;
	b1 = list2( b1, t3 );
	return( b1 );
}
