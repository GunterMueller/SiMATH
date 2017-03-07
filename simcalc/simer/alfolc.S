/*C
			alfolc( c, i, j, string )

	"alpha following character".
	single alfolc(c,i,j,string); char c, *string; single i, j;
	X = alfolc( c, i, j, string );

	Falls das Zeichen c ein zulaessiges Folgezeichen eines
	Alphazeichen ist, so wird der Funktionswert 1, sonst 0
	an das aufrufende Programm zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
H*/
 
#include <_calc.h>

single alfolc( c, i, j, s1 )
char c, *s1;
single i, j;

{
	single k;
	if ( !instring( s1, "curmod", &k ) && !strncmp( s1+i-2, "mod", 3 ) ) return( modfolc( c, i, j, s1 ) );
	if ( isalnum( c ) ) {
		if ( !strncmp( s1+j, "mod", 3 ) ) return( 1 );
	}
	if ( !isop( c ) && c != ')' && c != '\0' && c != '('  && c != '[' && c != ']'  &&
	     c != ';' && c != '}' && c != '_' )
	{       errm( i, j, s1, 0 );
		if ( ps ) ferrm( i, j, s1 );
		return( 0 );
	}
	return( 1 );
}
