/*C
			calc_jinv( fkeller )

	"calculator j- invariant".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_jinv( fkeller );  list fkeller;
	L = calc_jinv( fkeller );

	fkeller enthaelt eine elliptische Kurve. L ist die zugehoe-
	rige j- Invariante.
	Laeuft calc_jinv fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  2      04.08.1992      U.Schneiders ( mod und nf )
	Version  3	01.04.1993	S.Schmitt/U.Schneiders
	Version  3.1	12.07.1993	U.Schneiders
	Version  3.2	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_jinv( fkeller )
list fkeller;

{
	single k;
	rat ko[5];
	obj M, L;
	init( M, L ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10) && k != (-14) )
	{       mistake( 115 );
		return( ERROR );
	}

	if( k == (-5) || k == (-6) )  M = lfirst( varlist[modsch].varwert );
	else if( k == (-9) || k == (-10) ) M = lfirst( varlist[nfsch].varwert );
	else if( k == (-14 ) ) M = lfirst( varlist[gfsch].varwert );

	fkeller = lfirst( fkeller );
	if( k == (-5) || ( k == (-9) && ecqnfsch==_0) )
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		if( k == (-5) ) L = ecmpsnfjinv( M, ko[0], ko[1] );
		else            L = ecnfsnfjinv( M, ko[0], ko[1] );
	}
	else if(k==(-6) || ( k==(-10) && ecqnfsch==_0))
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
		if( k == (-6) ) L = ecmpjinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
		else L = ecnfjinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	}
	else if(k==(-14))
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
		L = ecgf2jinv( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
	}
	else if((k==(-10) || k==(-9) ) && ecqnfsch!=_0)
		L=ecqnfjinv(fkeller);
	else L=ecrjinv(fkeller);

	if( k == (-1) || k == (-2) ) L  = list2( L, 1 );
	else if( k == (-5) || k == (-6) ) L = list2( L, 17 );
	else if( k == (-14) ) L = list2( L, 31 );
	else 
	{	if(llength(ecqnfsch)==3) L=qnftonf(L,24);
		L = list2( L, 24 );
	}
	return( L );
}
