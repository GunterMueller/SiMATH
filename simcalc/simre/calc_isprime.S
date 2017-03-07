/*C
			calc_isprime( fkeller )

	"calculator is prime?"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_isprime( fkeller );  list fkeller;
	X = calc_isprime( fkeller );

	fkeller ist eine Liste, bestehend aus einer positiven
	ganzen Zahl mit zugehoeriger Kennung.		
	calc_isprime entscheidet, ob die entsprechende Zahl
	Primzahl ist.
	Laeuft calc_isprime fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      09.03.1993      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_isprime( fkeller )
list fkeller;
{
	single erg;
	bind( fkeller );
	
	/*** Abfangen falscher Eingaben ***/

	if( fkeller == ERROR ) return( ERROR );
	if( lsecond( fkeller ) )
	{	mistake( 19 );
		return( ERROR );
	}
	fkeller = lfirst( fkeller );
	if( isign( fkeller ) != 1 )
	{	mistake( 19 );
		return( ERROR );
	}

	/*** eigentl. Rechnung ***/

	
#ifdef ___CASI
	erg=igkapt(fkeller,(!assch));
#else
	erg=isiprime(fkeller);
#endif

	if(!assch){
	switch( erg )
	{	case 1: printf( " %i is prime.\n", fkeller );
			if( ps )
			fprintf( datei, " out: %i is prime.\n", fkeller );
			break;
		case 0: printf( " %i is not prime.\n", fkeller );
			if( ps )
			fprintf( datei, " out: %i is not prime.\n", fkeller );
			break;
		case (-1): printf( " %i is pseudoprime.\n", fkeller );
			if( ps )
			fprintf( datei, " out: %i is pseudoprime.\n", fkeller );
			break;
	}
	}
	fkeller = list2( erg, 0 );
	return( fkeller );
}
