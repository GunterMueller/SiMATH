/*C

			matrfolc( c, i, j, string )

	"matrix following character".
	single matrfolc(c,i,j,string); char c, *string; single i, j;
	X = matrfolc( c, i, j, string );
	Falls das Zeichen c ein zulaessiges Folgezeichen von } ist,
	so wird der Funktionswert 1, sonst 0 an das aufrufende
	Programm zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H

	Version  1      26.09.1988      C.Hollinger/U.Schneiders

H*/

 
#include <_calc.h>

single matrfolc( c, i, j, s1 )
char c, *s1;
single i, j;

{
	if ( isalpha( c ) ) {
		if ( !strncmp( s1+j, "mod", 3 ) ) c = '/';
	}
	if ( strchr( "/+*-^,;)><!=", c ) == NULL && c != '\0' && c != '_' ) {
		errm( i, j, s1, 0 );
		if ( ps ) ferrm( i, j, s1 );
		return( 0 );
	}
	return( 1 );
}
