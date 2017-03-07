/*C
			fileaus( )

	"file ausgabe".
	Quellbibliothek: srclib.mout
	Include- Datei: _calc.h
	fileaus( );

	fileaus gibt in alphabetischer Reihenfolge die Dateinamen aus,
	die zum Einlesen noch geoeffnet sind.
C*/
/*H
	Version  1      12.02.1991      U.Schneiders
	Version  2      26.08.1991      U.Schneiders  ( L speichert Feld-
							nr. von fname )
H*/
/*cS
	fileaus  ruft auf: fprintf, lcomp, strcmp
		   Macros: lfirst, lred, lsfirst, printf
Sc*/

#include <_calc.h>
jmp_buf tes1;

void fausstop()
{
	printf(" \n **********   Output is interrupted.   **********\n\n");
	if (ps) fprintf(datei,"\nout: **********    Output is interrupted.    **********\n\n");
	longjmp(tes1,0);
}

fileaus()
{
	list L, L1, L2, M, M1;
	single  i, j, stai;
	init( L, L1, L2, M, M1);

	L = _0;
	for( i = 0; i < 10; i++ )
	{       if( *fname[i] != '\0' )
			L = lcomp( i, L );
	}

	if( L == _0 )
	{       printf( " No file opened.\n" );
		if( ps ) fprintf( datei, "out: No file opened.\n" );
		return( 0 );
	}

	printf( " The following files are opened:" );
	if( ps ) fprintf( datei, "out: The following files are opened:" );

	/*** Sortieren ***/

	M = _0;
	do
	{       L1 = L;
		i = lfirst( L1 );
		M1 = _0;
		while ( (L2 = lred(L1)) != M )
		{       j = lfirst( L2 );
			if ( strcmp(fname[i],fname[j])>0 )
			{       lsfirst( L1,j );
				lsfirst( L2,i );
				M1 = L2;
			}
			else i = j;
			L1 = L2;
		}
	}
	while ( (M=M1) != _0 );

	/*** Ausgabe ***/

	while ( L != _0 )
	{       stai = ST_INDEX;
		setjmp(tes1);
		signal(SIGINT,fausstop);
		ST_INDEX = stai;
		if ( L == _0 ) break;
		i = lfirst( L );
		L = lred( L );
		printf( "\n       %s", fname[i] );
		if( ps ) fprintf( datei, "\n       %s", fname[i] );
	}
	printf( "\n" );
	if( ps ) fprintf( datei, "\n" );
	return(0);
}
