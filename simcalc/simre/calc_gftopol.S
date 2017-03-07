/*C
			calc_gftopol( fkeller )

	"calculator Galois-field element to polynomial"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_gftopol( fkeller );  list fkeller;
	X = calc_gftopol( fkeller );

	fkeller ist eine Liste, bestehend aus einem Element eines 
	endlichen Koerpers, einem Polynom ueber einem endlichen Koerper,
	einer Matrix oder einem Vektor darueber, bzw. dem endlichen 
	Koerper selbst und zugehoeriger Kennung. X ist die der in fkeller 
	stehenden Struktur entsprechende Struktur ueber Polynome ueber Q.
	Laeuft calc_gftopol fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      28.07.1993      S.Schmitt
	Version  1.1    08.03.1996      S.Schmitt ( GF(2) fuer Matrizen und 
						    Vektoren )
H*/

#include <_calc.h>

list calc_gftopol( fkeller )
list fkeller;
{
	list W, Z, VL;
	single k, r;
	init( W, Z, VL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"gftopol" );
		return( ERROR );
	}
	
	k = lsecond( fkeller );
	if( k < 30 || k > 36 )
	{	mistake1( 34,"gftopol" );
		return( ERROR );
	}
	
	/*** Umwandlung in Polynom ***/

	W = lfirst( fkeller );
	switch( k )
	{	case 30:if( gfchar == 2 )
			{	W = sbtoudpm2( W );
				W = dptop( 1, W );
			}
			else W = lfirst( W );
			W = list2( VGF, W );
			W = list2( W, 2 );
			break;
		case 31:if(gfchar == 2 )
			{	Z = lfirst( varlist[gfsch].varwert );
				W=gf2eltogfsel(Z,W);
			}
			W = list2( VGF, W );
			W = list2( W, 2 );
			break;
		case 32:VL=lfirst(W);
			W=lsecond(W);
			if( gfchar == 2 )
			{	Z = lfirst( varlist[gfsch].varwert );
				r=llength(VL);
				W = pgf2topgfs(r,Z,W);
			}
			Z=lfirst(VGF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,2);
			break;
		case 33:if(gfchar==2) 
			{	Z = lfirst( varlist[gfsch].varwert );
				W = magf2tomagfs(Z,W);
			}
			W = list2( VGF, W );
			W = list2( W, 7 );
			break;
		case 34:VL=lfirst(W);
			W=lsecond(W);
			if( gfchar == 2 )
			{	Z = lfirst( varlist[gfsch].varwert );
				r=llength(VL);
				W = mpgf2tompgfs(r,Z,W);
			}
			Z=lfirst(VGF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,7);
			break;
		case 35:if(gfchar==2) 
			{	Z = lfirst( varlist[gfsch].varwert );
				W = vecgf2tovgfs(Z,W);
			}
			W = list2( VGF, W );
			W = list2( W, 12 );
			break;
		case 36:VL=lfirst(W);
			W=lsecond(W);
			if( gfchar == 2 )
			{	Z = lfirst( varlist[gfsch].varwert );
				r=llength(VL);
				W = vpgf2tovpgfs(r,Z,W);
			}
			Z=lfirst(VGF);
			VL=lcomp(Z,VL);
			W=list2(VL,W);
			W=list2(W,12);
			break;
	}
	return( W );
}	
