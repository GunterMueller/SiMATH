/*C
			calc_herm( fkeller )

	"calculator hermite normalform".
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_herm( fkeller );      list fkeller;
	X = calc_herm( fkeller );

	fkeller besteht aus einer regulaeren quadratischen Matrix
	ueber Z mit zugehoeriger Kennung und einer single-Variablen
	vom Wert 1 oder -1 zur Angabe des Vorzeichens der Eintraege
	unter der Hauptdiagonalen. Berechnet wird in X die Hermite-
	Normalform fuer
	-1      mit nichtpositiven Eintraegen
	 1      mit nichtnegativen Eintraegen
	unter der Hauptdiagonalen.
	Laeuft calc_herm fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      06.06.1989      C.Hollinger
	Version  1.1    09.03.1993      S.Schmitt/U.Schneiders
H*/

#include<_calc.h>

list calc_herm( fkeller )
list fkeller;

{       single ken, n2;
	int n1;
	obj h, vz;
	init( n1, h, vz );
	bind( fkeller );

	/*** Ueberpruefung der Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"herm" );
		return( -BASIS );
	}
	h = lfirst( fkeller );
	ken = lsecond( h );
	vz = lfirst( h );
	if( ken || ( vz != 1 && vz != -1 ) )
	{       mistake( 96 );
		return( -BASIS );
	}
	h = lsecond( fkeller );
	ken = lsecond( h );
	if( ken != 5 )
	{       mistake( 97 );
		return( -BASIS );
	}
	h = lfirst( h );
	n1 = manrrow( h );
	n2 = manrcol( h );
	if( n1 !=  n2 )
	{       mistake( 97 );
		return( -BASIS );
	}
	n1 = maidet( h );
	if( !n1 )
	{       mistake( 97 );
		return( -BASIS );
	}

	/*** Berechnung der Hermite-Normalform. ***/

	if( vz == (-1) ) vz = 1;
	else vz = 0;
	h = maiherm( h,vz );
	h = list2( h,5 );
	return( h );
}
