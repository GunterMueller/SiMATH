/*C
			calc_aftopr( fkeller )

	"calculator affine to projective".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_aftopr( fkeller );  list fkeller;
	L = calc_aftopr( fkeller );

	fkeller ist die Darstellung eines Punktes / Q in affinen
	Koordinaten. Berechnet wird der entsprechende Punkt in
	projektiver Standarddarstellung und ueber L zurueckgegeben.
	Laeuft calc_aftopr fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  1.1    30.03.1993      S.Schmitt/U.Schneiders
	Version  2      22.07.1993      U.Schneiders ( gf )
H*/

#include <_calc.h>

list calc_aftopr( fkeller )
list fkeller;

{
	single k;
	rat h, e;
	obj L;
	init( L, h, e );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k != (-3) && k != (-7) && k != (-11) && k != (-15) )
	{       mistake( 117 );
		return( ERROR );
	}

	fkeller = lfirst( fkeller );
	switch( k )
	{ 	case (-7): e = 1;
			   break;
		case (-11):e = itonf( 1 );
			   break;
		case (-15):e = list2( 0, 1);
			   e = udpm2tosb( e );
			   break;
		default : break;
	}

	/*** unendlich ferne Punkt ***/

	if( !fkeller )    L = list3( 0, e, 0 );

	else if(k==(-7) || k==(-11) || k==(-15) ) 
	{    h = lcopy( fkeller );
	     L = lsuffix( h, e );
	}
	else L=fkeller;
	L = list2( L, (k-1) );
	return( L );
}
