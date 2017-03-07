/*C
			modfolc( c, i, j, string )

	"modular following character".
	single alfolc(c,i,j,string); char c, *string; single i, j;
	X = modfolc( c, i, j, string );

	Falls das Zeichen c ein zulaessiges Folgezeichen des Operators
	mod ist, so wird der Funktionswert 1, sonst 0 an das aufrufende
	Programm zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
H*/
 
#include <_calc.h>

single modfolc( c, i, j, s1 )
char c, *s1;
single i, j;

{
	if ( c != '@' && c != '(' && c != '[' &&  c != '-' &&  !isalnum( c ) ) {
		if ( c != '\0' ) {
			errm( i, j, s1, 0 );
			if ( ps ) ferrm( i, j, s1 );
		}
		mistake( 26 );
		return( 0 );
	}
	return( 1 );
}
