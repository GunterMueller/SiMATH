/*C
			issc( c )

	"is special character".
	single issc(c); char c;
	sch = issc( c );

	Falls c ein Sonderzeichen fuer den Calculator ist, so ist
	sch gleich 1, sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher/M.Mang
H*/
/*cS
	issc ruft auf:

	       Macros:
Sc*/
 
#include <_calc.h>

single issc( c )
char c;

{       single sch=0;

	switch( c ) {

	/*** Liste der Calculatorsonderzeichen ***/

		case '#':
		case 92 :
		case 34 :
		case '%':
		case '&':
		case ';':
		case 63 :
		case '{':
		case '}':
		case '$':
		case '~':
		case 39 :
		case '`':
		case '<':
		case '>':
		case '.':
		case '_':
		case '|': sch = 1;
			  break;
	}
	return( sch );
}
