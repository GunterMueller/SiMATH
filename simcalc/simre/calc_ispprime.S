/*C
			calc_ispprime( fkeller )

	"calculator is pseudo prime?"
	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_ispprime( fkeller );  list fkeller;
	X = calc_ispprime( fkeller );

	fkeller ist eine Liste, bestehend aus einer positiven
	ganzen Zahl mit zugehoeriger Kennung.		
	calc_ispprime entscheidet, ob die entsprechende Zahl
	Pseudo-Primzahl ist.
	Laeuft calc_ispprime fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      30.03.1999      S.Schmitt
H*/

#include <_calc.h>

list calc_ispprime( fkeller )
list fkeller;
{
	single erg,k;
	int a;
	bind( fkeller );
	init(a);
	
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

	k = 10;
	a = irand(500000);
	a = isum(a,2);
	while(k-- && (erg = isipprime(fkeller, a)))
	{
		if(k)
		{
			a = irand(500000);   
			a = isum(a,2);
		}
	}


	if(!assch){
	switch( erg )
	{	case 1: printf( " %i is pseudoprime.\n", fkeller );
			if( ps )
			fprintf( datei, " out: %i is prime.\n", fkeller );
			break;
		case 0: printf( " %i is not pseudoprime.\n", fkeller );
			if( ps )
			fprintf( datei, " out: %i is not prime.\n", fkeller );
			break;
	}
	}
	fkeller = list2( erg, 0 );
	return( fkeller );
}
