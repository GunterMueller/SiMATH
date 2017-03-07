/*C
			errm( l, j, string, b )

	"Error message"
	errm(l,j,string); char *string; single l, j;
	errm( l, j, string );

	Der Eingabestring wird auf stdout geschrieben, wobei
	das l-te bis j-te Zeichen des Eingabestrings unterstrichen
	werden. b ist 1, falls errm aus basad aufgerufen wurde, sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher
H*/
/*cS
	errm ruft auf: putc

	       Macros: printf
Sc*/
 
#include <_calc.h>

errm ( l, j, s, b )
single l, j, b;
char *s;

{       single i=0, k, m, n, sch=0, sch1=0, z;

	if(b) printf("              ");
	else printf( " ***** Error:\n " );
	while ( *(s+i) != '\0' ) {
		k=0;
		while ( *(s+i) != '\0' && k<78 ) {
			if ( i==l ) sch=1;
			if ( i==j ) sch1=1;
			putc( *(s+i), stdout ); ++i; ++k;
		}
		if ( *(s+i) == '\0' && k<78 ) putc( '\n', stdout );
		if(b) printf("             ");
		if ( sch && sch1 ) {
			m = l%78;
			z = 1;
			putc( ' ', stdout );
			while ( z <= m ) {
				putc( ' ', stdout );
				++z;
			}
			if ( j == 0 ) n=0;
			else n = j%78;
			while ( m <= n ) putc( '=', stdout ), ++m;
			putc( '\n', stdout );
			sch=0; sch1=0;
		}
		if ( sch ) {
			m = l%78;
			z = 1;
			putc( ' ', stdout );
			while ( z <= m ) {
				putc( ' ', stdout );
				++z;
			}
			while ( m+1 <= 78 ) putc( '=', stdout ), ++m;
			l=0;
		}
	}
}
