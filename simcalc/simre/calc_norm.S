/*C
			calc_norm( fkeller )

	"calculator norm"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_norm( fkeller );  list fkeller;
	X = calc_norm( fkeller );

	fkeller ist eine Liste, bestehend aus einem Zahlkoerperelement
	a aus K und zugehoeriger Kennung. X ist die Norm von a bzgl. 
	K/Q .
	Laeuft calc_norm fehlerhaft ab, so ist  X = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
H*/

#include <_calc.h>

list calc_norm( fkeller )
list fkeller;
{
	pol F;
	obj k;
	init( F, k );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"norm" );
		return( ERROR );
	}
	
	k = lsecond( fkeller );
	if( k != 24 && k && k!=1 )
	{	mistake1( 34,"norm" );
		return( ERROR );
	}
	if( k!=24 && !nfsch )
	{	mistake( 163 );
		return( ERROR );
	}
	
	/*** Berechnung ***/
	
	F = lfirst( varlist[nfsch].varwert );
	if( k != 24 )
	{	F = lfirst( F );
		fkeller = lfirst( fkeller );
		if( !k )
		{	fkeller = iexp( fkeller, F );
			k = list2( fkeller, 0 );
		}
		else
		{	fkeller = rexp( fkeller, F );
			k = list2( fkeller, 1 );
		}
	}
	else
	{	k = lsecond( F );
		if( icomp( k, 1 ) )
		{	mistake( 192 );
			return( ERROR );
		}

		k = lfirst( fkeller );
		k = nfnorm( F, k );
		k = list2( k, 1 );
	}
	return( k );
}	

