/*C
			calc_putbits( fkeller )

	"calculator put bits" 
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_putbits( fkeller );  list fkeller;
	X = calc_putbits( fkeller );

	fkeller enthaelt ein beliebiges Objekt.
	Falls es eine single precision Zahl ist, wird die 2-Bit-
	Notation dieser Zahl ausgegeben, andernfalls die 2-Bit-
	Darstellung der Adresse der Liste.
	X = fkeller.
	Laeuft calc_putbits fehlerhaft ab, so ist  X = ERROR.
C*/
/*H
	Version  1      30.09.1992      U.Schneiders
	Version  1.1    27.07.1995      U.Schneiders
H*/

#include <_calc.h>

list calc_putbits( fkeller )
list fkeller;
{
	single k;
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if( llength( fkeller ) != 2 )
	{	mistake( 27 );
		return( ERROR );
	}
	k = lfirst( fkeller );

	/*if( lsecond( fkeller ) )
	{	mistake( 187 );
		return( ERROR );
	}
	if( !isatom( k ) )
	{	mistake( 187 );
		return( ERROR );
	}*/

	if(!assch){
	putbits( k );
	printf( "\n\n" );
	if( ps )  
	{	fprintf( datei, "out:" );	
		fputbits( k, datei );
		fprintf( datei, "\n\n" );
	}
	}

	return( fkeller );
}
