/*C
			calc_fp( fkeller )

	"calculator finding point".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_fp( fkeller );  list fkeller;
	P = calc_fp( fkeller );

	fkeller besteht aus einer elliptischen Kurve ueber Z/pZ, wobei
	p Primzahl ist, oder ueber GF(2^n), und zugehoeriger Kennung.
	calc_fp liefert einen Punkt P auf der durch fkeller gegebenen
	elliptischen Kurve ueber Z/pZ bzw. GF(2^n) in projektiver 
	Darstellung, d.h. P ist eine dreielementige Liste P=(x,y,1)
	vom Elementen aus Z/pZ bzw. GF(2^n). P ist nicht der Fernpunkt,
	d.h. P != (0,1,0).
	Laeuft calc_fp fehlerhaft ab, so ist  P = ERROR.
C*/
/*H
	Version  1      26.08.1993      S.Schmitt
H*/

#include <_calc.h>

list calc_fp( fkeller )
list fkeller;

{
	single ken;
	obj a1, a2, a3, a4, a6, P;
	bind( fkeller );
	init( a1, a2, a3, a4, a6, P );

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"fp" );
		return( ERROR );
	}
	ken = lsecond( fkeller );
	if( ken != (-5) && ken != (-6) && ken != (-14) )
	{	mistake( 274 );
		return( ERROR );
	}
	if( ken != (-14) ) P = lfirst( varlist[modsch].varwert );
	else P = lfirst( varlist[gfsch].varwert );
	fkeller = lfirst( fkeller );
	if( ken != (-5) )
	{	a1 = lfirst( fkeller );
		a2 = lsecond( fkeller );
		a3 = lthird( fkeller );
		a4 = lfourth( fkeller );
		a6 = lfifth( fkeller );
	}
	switch( ken )
	{	case (-5): a4 = lfirst( fkeller );
			   a6 = lsecond( fkeller );
			   P = ecmpsnffp( P, a4, a6 );
			   P = list2( P, -8 );
			   break;
		case (-6): P = ecmpfp( P, a1, a2, a3, a4, a6 );
			   P = list2( P, -8 );
			   break;
		case (-14):P = ecgf2fp( P, a1, a2, a3, a4, a6 );
			   P = list2( P, -16 );	
			   break;
	}
	return( P );
}		            
