/*C
			calc_mval( fkeller )

	"calculator multiplicative valuation"
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_mval( fkeller );  list fkeller;
	X = calc_mval( fkeller );

	fkeller ist eine Liste, bestehend aus einer rationalen Zahl z
	mit Kennung und einer Primzahl p mit Kennung.
	Berechnet wird die multiplikative p- adische Bewertung von z.
	Laeuft calc_mval fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      29.08.1988      C.Hollinger/U.Schneiders
	Version  2      19.12.1988      C.Hollinger/U.Schneiders
H*/

#include<_calc.h>

list calc_mval( fkeller )
list fkeller;

{
	obj P, Z, w;
	single ken, kenp;
	init( P, Z, w );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"mval" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	Z = lfirst( fkeller );
	ken = lsecond( Z );
	if( ken > 1 || ken < 0 )
	{       mistake( 59 );
		return( -BASIS );
	}
	Z = lfirst( Z );
	if( !Z )
	{       mistake( 59 );
		return( -BASIS );
	}
	P = lsecond( fkeller );
	kenp = lsecond( P );
	if( kenp )
	{       mistake( 60 );
		return( -BASIS );
	}
	P = lfirst( P );
	if( isign( P ) <= 0 )
	{       mistake( 60 );
		return( -BASIS );
	}
/*	s = issprime( P, &pc );
	if( !s )
	{       mistake( 60 );
		return( -BASIS );
	}
	if( s == -1 )
	{       mistake( 60 );
		return( -BASIS );
	}  */

	/*** Berechnung der Bewertung ***/

/*	switch( ken )
	{       case 0: w = intpp( P, Z );
			w = rcons( 1, w );
			break;
		case 1: pc = lsecond( Z );
			Z = lfirst( Z );
			w = intpp( P, Z );
			pc = intpp( P, pc );
			w = rcons( pc, w );
			break;
		default: break;
	}  */

	if( !ken )	Z = itor( Z );
	w = ravalint( P, Z );
	if( w < 0 )  
	{       Z = iexp( P, -w );
		Z = list2( Z, 0 );
	}
	else
	{	Z = iexp( P, w );
		Z = rcons( 1, Z );
		Z = list2( Z, 1 );
	}
	return( Z );
}
