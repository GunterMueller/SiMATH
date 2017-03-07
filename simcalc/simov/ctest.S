/*C
			ctest( s, c );

	"character test".
	single ctest(s,c); char *s, c;
	X = ctest( s, c );
	Falls jedes Zeichen der Zeichenkette s gleich dem Zeichen c
	ist, so ist der Funktionswert 1, sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      21.09.1987      H.Stroeher/M.Mang
H*/
/*cS
	ctest ruft auf:

		Macros:
Sc*/
 
#include <_calc.h>

single ctest( s, c )
char *s, c;

{
	single i=0;

	while ( *(s+i) != '\0' ) {
		if ( *(s+i) != c ) return( 0 );
		++i;
	}
	return( 1 );
}
