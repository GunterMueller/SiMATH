/*C
			pfaktaus( VL, P, ken, L, alg )

	"Polynomfaktorisierungsausgabe".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	pfaktaus( VL, P, ken, L, alg ); list VL; obj P; single ken;
					list L; single alg;
	X = pfaktaus( VL, P, ken, L, alg );

	Ist ein spezielles Polynomfaktorisierungsausgabeprogramm, das
	nur bei der Faktorisierung des Polynoms P mit Variablenliste VL
	und Kennung ken aufgerufen wird. Die Liste L hat folgende Form:
	( c, P1, e1, ..., Pk, ek ), wobei c = sign( P ) * cont( P ),
	falls man ueber Z rechnet, oder c = sign( P ) * cont( P ) / N
	mit N = Hauptnenner der Koeffizienten von P, wenn ueber Q ge-
	rechnet wird, und Pi die einzelnen Primfaktoren von P mit zuge-
	hoerigen Exponenten ei.
	alg gibt an, ob man ein Polynom ( alg=1 ) oder den Zaehler
	( alg=2 ) oder den Nenner ( alg=3 ) einer rationalen Funktion
	faktorisiert hat.
C*/
/*H
	Version  1      12.09.1988      U.Schneiders
	Version  1.2    04.12.1989      U.Schneiders
H*/

#include<_calc.h>

pfaktaus( VL, P, ken, L, alg )
list VL;
obj P;
single ken;
list L;
single alg;

{
	single mn, mz, r, nsch, exp;
	pol PN, PZ;
	obj c;
	init( PN, PZ, c );
	bind( VL, P, L );

	r = llength( VL );
	nsch = 0;

	if(!assch){
	if( alg != 3 )
	{       printf( " factorization of " );
		if( ps ) fprintf(datei, "out: factorization of " );
	}
	switch( ken )
	{       case 2: putpi( r, P, VL );
			printf(":\n" );
			if( ps )
			{       fputpi( r, P, VL, datei );
				fprintf(datei, ":\n" );
			}
			break;
		case 3: putpr( r, P, VL );
			printf(":\n" );
			if( ps )
			{       fputpr( r, P, VL, datei );
				fprintf(datei, ":\n" );
			}
			break;
		case 4: if( alg == 2 )
			{       PZ = lfirst( P );
				PN = lsecond( P );
				mz = ispmonom( r, PZ );
				mn = ispmonom( r, PN );
				if( !mz )
				{       printf( "( " );
					if( ps ) fprintf(datei, "( " );
				}
				putpi( r, PZ, VL );
				if( ps ) fputpi( r, PZ, VL, datei );
				if( !mz )
				{       printf( " )" );
					if( ps ) fprintf(datei, " )" );
				}
				printf( " / " );
				if( ps ) fprintf(datei, " / " );
				if( !mn )
				{       printf( "( " );
					if( ps ) fprintf(datei, "( " );
				}
				putpi( r, PN, VL );
				if( ps ) fputpi( r, PN, VL, datei );
				if( !mn )
				{       printf( " )" );
					if( ps ) fprintf(datei, " )" );
				}
				printf( ":\n" );
				printf( " numerator:" );
				if( ps )
				{       fprintf(datei, ":\n" );
					fprintf(datei, "out: numerator:" );
				}
			}
			else
			{       printf( " denominator:" );
				if( ps ) fprintf(datei, "out: denominator:" );
			}
			break;
	}
	}
	c = lfirst( L );
	L = lred( L );
	if( c != 1 && c != -1 && L != _0 && !assch )
	{       if( isign( c ) == 1 )
		{       if( ken == 2 || ken == 4 )
			{       printf( " %i * ", c );
				if( ps )
				{       if( ken == 2 )  fprintf(datei, "out: %i * ", c );
					else fprintf(datei, " %i * ", c );
				}
			}
			else
			{       printf( " %r * ", c );
				if( ps ) fprintf(datei, "out: %r * ",c );
				
			}
		}
		else if( isign( c ) == -1 )
		{       if( ken == 2 || ken == 4 )
			{       printf( " ( %i ) * ", c );
				if( ps )
				{       if( ken == 2 )  fprintf(datei, "out: ( %i ) * ", c );
					else fprintf(datei, " ( %i ) * ", c );
				}
			}
			else
			{       printf( " ( %r ) * ",c );
				if( ps ) fprintf(datei, "out: ( %r ) * ", c );
			}
		}
	}
	else if( L == _0 )
	{    if(!assch){
	     if( ken == 2 || ken == 4 )
	     {       printf( " %i ", c );
		     if( ps )
		     {       if( ken == 2 )  fprintf(datei, "out: %i ", c );
		             else fprintf(datei, " %i ", c );
		     }
             }
	     else
	     {       printf( " %r ", c );
	             if( ps ) fprintf(datei, "out: %r ",c );
	     }
	     }
	     P = lfirst(P);
	}
	else if( c == -1 && !assch )
	{       printf( " - ( " );
		nsch = 1;
		if( ps )
		{       if( ken == 2 )  fprintf(datei, "out: - ( " );
			else fprintf(datei, " - ( " );
		}
	}
	else if( c==1 && !assch )   /* c==1 */
	{       printf( " " );
		if( ps )
		{       if( ken == 2 ) fprintf(datei, "out: " );
			else fprintf(datei, " " );
		}
	}
	mn = llength( L );
	while( L != _0 )
	{       P = lfirst( L );
		L = lred( L );
		if(!assch){
		exp = lfirst( L );
		L = lred( L );
		if( mn != 2 || ( c != 1 && c != (-1) ) || exp > 1 )
		{       mz = ispmonom( r, P );
			if( !mz )
			{       printf( "( " );
				if( ps ) fprintf(datei, "( " );
			}
		}
		putpi( r, P, VL );
		if( ps ) fputpi( r, P, VL, datei );
		if( mn != 2 || ( c != 1 && c != (-1) ) || exp > 1 )
		{       if( !mz )
			{       printf( " )" );
				if( ps ) fprintf(datei, " )" );
			}
		}
		if( exp > 1 )
		{       printf( "^%i", exp );
			if( ps ) fprintf(datei, "^%i", exp );
		}
		if( L != _0 )
		{       printf( " * " );
			if( ps ) fprintf(datei, " * " );
		}
		}
		else L=lred(L);
	}
	if(!assch){
	if( nsch )
	{       printf( " )\n" );
		if( ps ) fprintf(datei, " )\n" );
	}
	else
	{       printf( "\n" );
		if( ps ) fprintf(datei, "\n" );
	}
	}
	return(P);
}
