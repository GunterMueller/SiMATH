/*C

			muster( s, s1 )

	"Mustersuche".    (rekursiv)
	single muster(s,s1); char *s, *s1;
	X = muster( s, s1 );
	Das Programm untersucht ob das Muster der Zeichenkette s
	in der Zeichenkette s1 vorkommt.
	Bei Erfolg ist der Funktionswert 1, sonst 0.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H

	Version  1      18.09.1987      H.Stroeher/M.Mang

H*/

 
#include <_calc.h>

single muster( s, s1 )
char *s, *s1;

{
	single i=0, j=0, m;
	char *c, *strchr();

	while ( *(s+i) != '\0' && *(s+i) == '*' ) ++i;
	if ( *(s+i) == '\0' ) return( 1 );
	if ( i > 0 ) {
		c = s1;
		while ( ( c = strchr( c, *(s+i) ) ) != NULL ) {
			m = muster( s+i, c );
			if ( m != 0 ) return( m );
			c++;
		}
		return( 0 );
	}
	else {
		while ( *(s+i) == *(s1+j) && *(s+i) != '\0' ) ++i, ++j;
		if ( *(s+i) == '\0' ) {
			if ( *(s1+j) == '\0' ) return( 1 );
			else return( 0 );
		}
		if ( *(s+i) == '*' ) return( muster( s+i, s1+j ) );
		else return( 0 );
	}
}
