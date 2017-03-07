/*C
			stellen( L )

	"Stellenanzahl".
	stellen( L ); list L;
	stellen( L );
	L ist eine Liste bestehend aus einer rationalen Zahl und zu-
	gehoeriger Kennung.
	Falls die rationale Zahl in L eine positive einfachgenau gan-
	ze Zahl ist, so wird diese der Systemvariablen DIGITS zugewie-
	sen. Die Variable DIGITS gibt die Anzahl der Nachkommastellen
	an, mit der eine rationale Zahl beim Funktionsaufruf prd ausge-
	geben wird.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  2      27.01.1992      U.Schneiders ( FL_EPS )
H*/
/*cS
	stellen ruft auf:  flinit, mistake
		  Macros:  fprintf, iabs, lfirst, lsecond, printf, smax
Sc*/
 
#include <_calc.h>

stellen( L )
list L;

{
	bind( L );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( lsecond( L ) )     
	{	mistake( 29 );
		if(fosch!=2) fosch=1;
	}
	else if ( iabs( lfirst( L ) ) >= BASIS )     
	{	mistake( 30 );
		if(fosch!=2) fosch=1;
	}
	     else if ( lfirst( L ) <= 0 )            
	     {		mistake( 29 );
			if(fosch!=2) fosch=1;
	     }

	/*** Zuweisung an DIGITS ***/

		  else
		  {     DIGITS = lfirst( L );
			printf("%t DIGITS = %i\n", 8, lfirst( L ) );
			if ( ps )
			fprintf( datei, "out: DIGITS = %i\n", lfirst( L ) );
			if(DIGITS<OUTPUTDIG) 
			{	OUTPUTDIG = DIGITS;
				printf("%t OUTPUTDIG = %i\n", 8, OUTPUTDIG);
				if ( ps )
				fprintf( datei, "out: OUTPUTDIG = %i\n", OUTPUTDIG);
			}

			FL_EPS = smax( flinit( DIGITS ), 5 );
		  }
}
