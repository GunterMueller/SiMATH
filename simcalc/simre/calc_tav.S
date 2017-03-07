/*C
			calc_tav( fkeller, sch )

	"calculator tate values".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_tav( fkeller, sch );  list fkeller; single sch;
	L = calc_tav( fkeller, sch );

	fkeller enthaelt eine elliptische Kurve. L ist der zugehoe-
	rige Tate- Wert b2, b4, b6, b8, c4, c6, je nachdem ob der
	Schalter sch 2, 4, 6, 8, 14 oder 16 ist.
	Laeuft calc_tav fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  2      04.08.1992      U.Schneiders ( mod und nf )
	Version  2.1	13.04.1993	S.Schmitt
	Version  3	22.07.1993	U.Schneiders ( gf )
	Version  3.1	10.07.1996	S.Schmitt (ecqnfsch)
H*/

#include <_calc.h>

list calc_tav( fkeller, sch )
list fkeller;
single sch;

{
	single k;
	rat ko[5];
	obj L, M;
	init( L, M ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10) && k != (-14) )
	{       mistake( 113 );
		return( ERROR );
	}

	if( k == (-5) || k == (-6) ) M = lfirst( varlist[modsch].varwert );
	else if( k == (-9) || k == (-10) ) M = lfirst( varlist[nfsch].varwert );
	else if( k == (-14) ) M = lfirst( varlist[gfsch].varwert );

	fkeller = lfirst( fkeller );
	if( k == (-5) || ( k == (-9) && ecqnfsch==_0 ) )
	{       ko[0] = 0;
		ko[1] = 0;
		ko[2] = 0;
		ko[3] = lfirst( fkeller );
		ko[4] = lsecond( fkeller );
	}
	else if(k==(-6) || ( k==(-10) && ecqnfsch==_0 ) || k==(-14))
	{       ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
	}
	if( sch < 7 || (sch <9 && ( ( k==(-1) || k==(-2) ) || ( ( k==(-9) || k==(-10) ) && ecqnfsch!=_0 ) ) ) )
	{	switch( k )
		{	case (-1):
			case (-2): L = ecracb2( fkeller );
				   L=lfirst(fkeller);
				   L=lsecond(L);
				   break;
			case (-5):
			case (-6): L = ecmptavb6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-9):
			case (-10):if(ecqnfsch!=_0)
				   { L=ecqnfacb2(fkeller);
				     L=lfirst(fkeller);
				     L=lsecond(L);
				   }
				   else  L = ecnftavb6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-14):L = ecgf2tavb6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				   break;
		}
		switch( sch )
		{       case 2: L = lfirst( L );
				break;
			case 4: L = lsecond( L );
				break;
			case 6: L = lthird( L );
				break;
			case 8: L=lfourth(L);
				break;
		}
	}
	else if( sch == 8 && k!=(-1) && k!=(-2) && ( ( k!=(-9) && k!=(-10) ) || !ecqnfsch ) )
	{	switch( k )
		{ 	case (-5):
			case (-6): L = ecmptavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-9):
			case (-10):L = ecnftavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-14):L = ecgf2tavb8( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
		}
		L = lfourth( L );
	}
	else
	{	switch( k )
		{	case (-1):
			case (-2): L = ecracc4( fkeller );
				   L=lfirst(fkeller);
				   L=lthird(L);
				   break;
			case (-5):
			case (-6): L = ecmptavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-9):
			case (-10):if(ecqnfsch!=_0)
				   {	L=ecqnfacc4(fkeller);
					L=lfirst(fkeller);
					L=lthird(L);
				  }
				  else  L = ecnftavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
			case (-14):L = ecgf2tavc6( M, ko[0], ko[1], ko[2], ko[3], ko[4] );
				  break;
		}
		if( sch == 14 ) L = lfirst( L );
		else            L = lsecond( L );
	}

	switch( k )
	{	case (-1):
		case (-2): L = list2( L, 1 );
			   break;
		case (-5):
		case (-6): L = list2( L, 17 );
			   break;
		case (-9):
		case (-10):if(llength(ecqnfsch)==3) L=qnftonf(L,24);
			   L = list2( L, 24 );
			   break;
		case (-14):L = list2( L, 31 );
			   break;
	}
	return( L );
}
