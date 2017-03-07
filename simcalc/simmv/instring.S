/*C
			instring( string, arg, i )

	"is in string".
	single instring(string,arg,i); char *string, *arg; single *i;
	X = instring( string, arg, i );

	Falls die Zeichenkette arg in der Zeichenkette string enthalten
	ist, so wird der Funktionswert 1 an das aufrufende Programm
	zurueckgeliefert, andernfalls der Funktionswert 0.
	*i gibt die Position von arg in string an.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
H*/
/*cS
	instring ruft auf: strlen, strncmp

		   Macros:
Sc*/
 
#include <_list.h>

int instring( string , arg, i )
char *string, *arg;
single *i;

{       /*** Deklarationen und Vorbesetzungen ***/

	single j, k;
	*i=0;
	k = strlen( arg );
	j = strlen( string ) - k;

	/*** Suche von arg in string ***/

	while ( *i <= j ) {
		if ( !strncmp( string, arg, k ) ) {
			return( 1 );
		}
		++*i;
		string += 1;
	}
	return( 0 );
}
