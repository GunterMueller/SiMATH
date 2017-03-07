/*C
			calc_nftopol( fkeller )

	"calculator number field element to polynomial"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_nftopol( fkeller );  list fkeller;
	X = calc_nftopol( fkeller );

	fkeller ist eine Liste, bestehend aus einem Zahlkoerperelement,
	einem Polynom ueber einem Zahlkoerper, einer Matrix oder 
	einem Vektor darueber, bzw. dem Zahlkoerper
	selbst und zugehoeriger Kennung. X ist die der in fkeller ste-
	henden Struktur entsprechende Struktur ueber Polynome ueber Q.
	Laeuft calc_nftopol fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      28.09.1992      U.Schneiders
	Version  1.1    02.11.1992      U.Schneiders
	Version 2       18.03.1993      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_nftopol( fkeller )
list fkeller;
{
	obj el;
	list NW, NZ, W, Z, VL;
	single k, r;
	init( el, NW, NZ, W, Z, VL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"nftopol" );
		return( ERROR );
	}
	
	k = lsecond( fkeller );
	
	/*** ueber Z und Q ****/

	if( (k>=0 && k < 4 ) || (k>4 && k<9) || (k>9 && k<14) )
	{	if( !nfsch )
		{	mistake(163);
			return( ERROR );
		}
		return( fkeller );
	}

	if( k < 23 || k > 29 )
	{	mistake1( 34,"nftopol" );
		return( ERROR );
	}
	
	/*** Umwandlung in Polynom ***/

	W = lfirst( fkeller );
	switch( k )
	{	case 23:W = dptop( 1, W );
			W = list2( VNF, W );
			W = list2( W, 2 );
			break;
		case 24:W = nfeltoudpr( W );
			W = dptop( 1, W );
			W = list2( VNF, W );
			W = list2( W, 3 );
			break;
		case 25:VL=lfirst(W);
			r=llength(VL);
			W=lsecond(W);
			W=pnftopr(r,W);
			Z=lfirst(VNF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,3);
			break;
		case 26:NW = _0;
			while( W != _0 )
			{	Z = lfirst( W );
				W = lred( W );
				NZ = _0;
				while( Z != _0 )
				{	el = lfirst( Z ); 
					Z = lred( Z );
					el = nfeltoudpr( el );
					el = dptop( 1, el );
					NZ = lcomp( el, NZ );
				}
				NZ = linv( NZ );
				NW = lcomp( NZ, NW );
			}
			W = linv( NW );
			W = list2( VNF, W );
			W = list2( W, 8 );
			break;
		case 27:VL=lfirst(W);
			r=llength(VL);
			W=lsecond(W);
			W=mapnftomapr(r,W);
			Z=lfirst(VNF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,8);
			break;
		case 28:NW = _0;
			while( W != _0 )
			{	el = lfirst( W ); 
				W = lred( W );
				el = nfeltoudpr( el );
				el = dptop( 1, el );
				NW = lcomp( el, NW );
			}
			W = linv( NW );
			W = list2( VNF, W );
			W = list2( W, 13 );
			break;
		case 29:VL=lfirst(W);
			r=llength(VL);
			W=lsecond(W);
			W=vecpnftovpr(r,W);
			Z=lfirst(VNF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,13);
			break;
	}
	
	return( W );
}	
