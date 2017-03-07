/*C
			calc_puto( fkeller )

	"calculator put object" 
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_puto( fkeller );  list fkeller;
	X = calc_puto( fkeller );

	fkeller enthaelt ein Objekt mit zugehoeriger Kennung.
	X = fkeller.
	Ausgegeben wird die interne Darstellung diese Objektes.
	Laeuft calc_puto fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
H*/

#include <_calc.h>

list calc_puto( fkeller )
list fkeller;
{
	single k;
	obj a;
	init( a );
	bind( fkeller );

	if( llength( fkeller ) != 2 )
	{	mistake1( 34,"puto" );
		return( ERROR );
	}

	if(!assch){
	k = lsecond( fkeller );
	a = lfirst( fkeller );
	
	/*** Strukturen in Variablen ***/

	if( ( k > 1 && k < 5 ) || ( k > 6 && k < 10 ) || ( k > 11 && k < 15 )
         || k == 18 || k == 20 || k == 22 || k == 25 || k == 27 || k == 29 
         || k == 32 || k == 34 || k == 36 || k == 38 || k == 39 )
		a = lsecond( a );

	printf(" " );
	puto( a );
	printf( "\n\n" );
	if( ps )  
	{	fprintf(datei, "out: " );
		fputo( a, datei );
		fprintf( datei, "\n\n" );
	}
	}

	return( fkeller );
}
