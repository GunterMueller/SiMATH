/*C
			dfolc( c, l, j, string )

	"digit following character".
	single dfolc(c,l,j,string); char c, *string; single l, j;
	X = dfolc( c, l, j, string );

	Falls das Zeichen c ein zulaessiges Folgezeichen einer Zahl
	ist, so wird der Funktionswert 1, sonst 0 an das aufrufende
	Programm zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
	Version  1.1    31.12.1991      U.Schneiders ( Reelle Zahlen )
H*/
 
#include <_calc.h>

single dfolc( c, l, j, s1 )
char c, *s1;
single l, j;

{
	if ( isalpha( c ) && c != 'e' && c != 'E' )
	 	if ( j>0 && strncmp( s1+j, "mod" , 3 ) ) c = '(';

	if(j<0) j=(-j);		/** fuer htoi **/

	if ( !isop( c ) && c != ')' && c != ']' && c != '\0' && c != ';'  &&
	     c != '}' && !( isalpha( c ) ) && c != '.' && c != '_' )
	{       errm( l, j, s1, 0 );
		if ( ps ) ferrm( l, j, s1 );
		return( 0 );
	}
	return( 1 );
}
