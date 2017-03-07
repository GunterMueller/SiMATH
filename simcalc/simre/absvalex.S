/*C
			absvalex ( arg, arg2 )

	"absolute-value expression".
	absvalex(arg,arg2)  char *arg, *arg2;
	absvalex( arg, arg2 );
	Der String innerhalb einer oeffnenden und der zugehoerigen
	schliessenden Betragsklammer wird bestimmt und arg2 zugewiesen.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher
	Version  2      19.08.1991      U.Schneiders ( 2 Argumente )
H*/
/*cS
	absvalex ruft auf:
		   Macros:
Sc*/

#include <_list.h>

absvalex( arg, arg2 )
char *arg, *arg2;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=1, j=1;

	/*** Isolierung des geklammerten Ausdrucks ***/

	while ( i )
	{       switch( *arg )
		{       case '[': ++i;
				  break;
			case ']': --i;
				  break;
			default: break;
		}
		if ( i > 0 ) *( arg2+j-1 ) = *arg;
		++j;
		arg += 1;
	}
	*( arg2+j-2 ) = '\0';
	return( 0 );
}
