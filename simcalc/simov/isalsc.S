/*C
			isalsc( c )

	"is alpha or special character".
	single isalsc(c); char c;
	X = isalsc( c );

	Es wird geprueft ob c ein Zeichen ist, dass in einem
	Dateinamen auftreten kann. Ist dies der Fall, so wird
	der Funktionswert 1, andernfalls 0, an das aufrufende
	Programm zurueckgeliefert.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
H*/
/*cS
	isalsc ruft auf:

		 Macros: isalpha
Sc*/
 
#include <_list.h>

single isalsc( c )
char c;

{
	if ( isalpha( c ) || c == '_' || c == '.' ) return( 1 );
	return( 0 );
}
