/*C
			isop( c )

	"is operator".
	single isop(c); char c;
	sch = isop( c );

	Falls c ein dem Calculator bekannter Operator ist,
	so ist sch gleich 1, sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
H*/
/*cS
	isop ruft auf:

	       Macros:
Sc*/
 
#include <_calc.h>

single isop( c )
char c;

{       single sch;

	switch( c )
	{       case '/' :
		case '!' :
		case '+' :
		case '*' :
		case ':' :
		case '-' :
		case '=' :
		case ',' :
		case '^' : 
		case '<' :
		case '>' :
		case '&' :
		case '|' : sch = 1;
			   break;
		default : sch = 0;
			  break;
	}
	return( sch );
}
