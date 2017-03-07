/*C
			calc_transp( fkeller )

	"calculator transponent".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	obj calc_transp( fkeller );  list fkeller;
	X = calc_transp( fkeller );

	fkeller besteht aus einem Objekt mit zugehoeriger Kennung. Be-
	rechnet wird, falls das Objekt eine Matrix ist, ihre transpo-
	nierte Matrix. Das Ergebnis wird mit zugehoeriger Kennung an
	'erg' zurueckgegeben.
	Laeuft calc_transp fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      07.11.1988      C.Hollinger/U.Schneiders
	Version  1.1    12.07.1989      C.Hollinger/U.Schneiders
	Version  1.2    03.08.1992      U.Schneiders
	Version  1.3	26.07.1993	S.Schmitt ( gf )
H*/

#include <_calc.h>

obj calc_transp( fkeller )
list fkeller;

{       single t;
	obj erg, M;
	list VL;
	bind( fkeller );
	init( erg, VL, M );

	if( fkeller == -BASIS ) return( -BASIS );
	M = lfirst( fkeller );
	t = lsecond( fkeller );
	if( t < 5 || ( t > 9  && t != 19 && t != 20 && t != 26 && t != 27 && t != 33 && t != 34 ) )
	{       mistake( 78 );
		return( -BASIS );
	}

	/*** Transponieren ***/

	erg = lcopy( M );
	if( ( t > 6 && t < 10 ) || t == 20 || t == 27 || t == 34 )
	{       VL = lfirst( erg );
		erg = lsecond( erg );
	}
	if(t==19 && lfirst(varlist[modsch].varwert)==2) erg=mam2transp(erg);
	else erg = matrans( erg );
	if( ( t > 6 && t < 10 ) || t == 20 || t == 27 || t == 34 ) erg = list2( VL, erg );
	erg = list2( erg, t );
	return( erg );
}
