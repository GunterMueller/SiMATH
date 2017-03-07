/*C
			calc_binom( fkeller )

	"calculator binomial coefficient."
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_binom( fkeller );  list fkeller;
	X = calc_binom( fkeller );

	fkeller ist eine Liste, bestehend aus einer nichtnegativen
	ganzen Zahl n und einer ganzen Zahl k aus [ 0,n ].
	Berechnet wird der Binomialkoeffizient n ueber k.
	Laeuft calc_binom fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      29.08.1988      C.Hollinger/U.Schneiders
H*/

#include<_calc.h>

list calc_binom( fkeller )
list fkeller;

{
	obj K, N;
	single ken1, ken2;
	init( K, N );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"binom" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	K = lfirst( fkeller );
	ken1 = lsecond( K );
	N = lsecond( fkeller );
	ken2 = lsecond( N );
	if( ken2 )
	{       mistake( 63 );
		return( -BASIS );
	}
	N = lfirst( N );
	if( isign( N ) < 0 )
	{       mistake( 64 );
		return( -BASIS );
	}
	if( ken1 )
	{       mistake( 63 );
		return( -BASIS );
	}
	K = lfirst( K );
	if( isign( K ) < 0 || icomp( K, N ) > 0 )
	{       mistake( 209 );
		return( -BASIS );
	}

	/*** Berechnung des Binomialkoeffizienten ***/

	N = ibinom( N,K );
	N = list2( N, 0 );
	return( N );
}
