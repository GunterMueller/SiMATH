/*C
			ofolc( c, i, j, string )

	"operator following character".
	single ofolc(c,i,j,string); char c, *string; single i, j;
	X = ofolc( c, i, j, string );

	Falls das Zeichen c ein zulaessiges Folgezeichen eines
	dem Calculator bekannten Operators ist, so wird der Funktionswert
	1, sonst 0 an das aufrufende Programm zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
	Version  1.1    31.12.1991      U.Schneiders ( Reelle Zahlen )
H*/
 
#include <_calc.h>

single ofolc( c, i, j, s1 )
char c, *s1;
single i, j;

{
	if ( !strncmp( s1+j, "mod", 3 ) )       c = ' ';

	if ( c != '(' && c != '[' && c != '-' && !isalnum( c ) && c != '@' &&
	     c != '\0' && c != '{' && c != '.' )
	{       errm( i, j, s1, 0 );
		if ( ps ) ferrm( i, j, s1 );
		return( 0 );
	}
	return( 1 );
}
