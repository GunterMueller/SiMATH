/*C
			calc_prtoaf( fkeller )

	"calculator projective to affine".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_prtoaf( fkeller );  list fkeller;
	L = calc_prtoaf( fkeller );

	fkeller ist die Darstellung eines Punktes / Q in projektiven
	Koordinaten. Berechnet wird der entsprechende Punkt in
	affiner Darstellung und ueber L zurueckgegeben.
	Laeuft calc_prtoaf fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  1.1    03.08.1992      U.Schneiders
	Version  1.2    30.03.1993      S.Schmitt/U.Schneiders
	Version  1.3    22.07.1993      U.Schneiders ( gf )
H*/

#include <_calc.h>

list calc_prtoaf( fkeller )
list fkeller;

{
	single k;
	rat ko[2];
	obj L, M;
	init( L, M ); init( ko[0..1] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k != (-4) && k != (-8) && k != (-12) && k != (-16) )
	{       mistake( 116 );
		return( ERROR );
	}

	fkeller = lfirst( fkeller );
	switch( k )
	{	case (-8): M = lfirst( varlist[modsch].varwert );
			   L = ecmpsrpp( M, fkeller );
			   break;
		case (-12):M = lfirst( varlist[nfsch].varwert );
			   L = ecnfsrpp( M, fkeller );
			   break;
		case (-16):M = lfirst( varlist[gfsch].varwert );
			   L = ecgf2srpp( M, fkeller );
			   break;
		default : break;
	}

	if(k==(-8) || k==(-12) || k == (-16) )
	{	if( lthird( L ) )
		{
			ko[0] = lfirst( L );
			ko[1] = lsecond( L );
			L = list2( ko[0], ko[1] );
		}

	/*** unendlich ferner Punkt ***/

		else    L = 0;
	}
	else L=fkeller;

	L = list2( L, (k+1) );
	return( L );
}
