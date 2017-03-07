/*C
			error( string )

	"error examination".
	single error(string); char *string;

	Der Eingabestring wird auf syntaktische Fehler und unzulaessige
	Zeichen untersucht.
	Falls der Eingabestring fehlerfrei ist, so wird der
	Funktionswert 1, sonst 0 an das aufrufende Programm zurueck-
	geliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
	Version  2      04.01.1988      C.Hollinger/U.Schneiders
H*/
/*cS
	error ruft auf: errm, ferrm ,syntax
Sc*/
 
#include <_calc.h>

single error( s )
char *s;

{
	single erg, i=0, l=0, p=0, z=0, z1=0, z2 = 0;

	/*** Ueberpruefen unzulaessiger Tastenbedienung ***/

	while ( *(s+i) != '\0' )
	{       if ( *(s+i) == 27 )
		{       mistake( 0 );
			return( 0 );
		}
		++i;
	}

	/*** Ueberpruefen der Klammerstruktur ***/

	while ( *(s+l) != '\0' )
	{       switch( *( s+l ) )
		{       case '(': if(seven(z2)) ++z;
				  break;
			case ')': if(seven(z2)) --z;
				  break;
			case '[': if(seven(z2)) ++z1;
				  break;
			case ']': if(seven(z2)) --z1;
				  break;
			case '"': if(!l || *(s+l-1) !='\\')
				  ++z2;
				  break;
			case '=': if(seven(z2)) 
				  {	i=prechar(s,l); 
				  	if(i == '=') p--;
				  	else if(i!= '>' && i != '<' && i != '!') ++p;
				  }
				  break;
			default: break;
		}
		if ( z < 0  || z1 < 0 ) {
			mistake( 1 );
			return( 0 );
		}
		++l;
	}
	if ( z > 0  || z1 > 0 ) {
		mistake( 2 );
		return( 0 );
	}
	if(sodd(z2))
	{	mistake(310);
		return(0);
	}

	erg = syntax( s, p, 0 );
	return( erg );
}
