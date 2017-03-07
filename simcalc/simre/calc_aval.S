/*C
			calc_aval( fkeller )

	"calculator additive valuation"
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_aval( fkeller );  list fkeller;
	X = calc_aval( fkeller );

	fkeller ist eine Liste, bestehend aus einer rationalen Zahl z
	mit Kennung und einer Primzahl p mit Kennung.
	Berechnet wird die additive p- adische Bewertung von z.
	Laeuft calc_aval fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      26.08.1988      U.Schneiders
	Version  2      19.12.1988      C.Hollinger/U.Schneiders
H*/

#include<_calc.h>

list calc_aval( fkeller )
list fkeller;

{
	obj P, Z, N;
	single ken, kenp, v, w, s;
	init( P, Z );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"aval" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	Z = lfirst( fkeller );
	ken = lsecond( Z );
	if( ken > 1 || ken < 0 )
	{       mistake( 201 );
		return( -BASIS );
	}
	Z = lfirst( Z );
	if( !Z )
	{       mistake( 201 );
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
	{       case 0: w = iaval( P,Z );
			break;
		case 1: N = lsecond( Z );
			Z = lfirst( Z );
			w = iaval( P,Z );
			v = iaval( P,N );
			w = idif( w,v );
			break;
		default:break;
	}  */
	
	if( !ken ) Z = itor( Z );
	w = ravalint( P, Z );
	Z = list2( w, 0 );
	return( Z );
}
