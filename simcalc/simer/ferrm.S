/*C
			ferrm( l, j, string )

	"file Error message".
	ferrm(l,j,string); char *string; single l,j;
	ferrm( l, j, string );

	Der Eingabestring wird auf die Protokolldatei geschrieben,
	wobei das l-te bis j-te Zeichen unterstrichen werden.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher/M.Mang
H*/
/*cS
	ferrm ruft auf: fputc

		Macros: fprintf
Sc*/
 
#include <_calc.h>

ferrm ( l, j, s )
single l, j;
char *s;

{
	single i=0, k, m, n, sch=0, sch1=0, z;

	if ( l/77 - j/77 ) --j;
	fprintf( datei, "out: * Error:\n" );
	while ( *(s+i) != '\0' ) {
		k=0;
		while ( *(s+i) != '\0' && k<77 ) {
			if ( i==l ) sch=1;
			if ( i==j ) sch1=1;
			fputc( *(s+i), datei ); ++i; ++k;
		}
		if ( *(s+i) == '\0' && k<77 ) fputc( '\n', datei );
		if ( sch && sch1 ) {
			m = (l%77);
			z = 1;
			while ( z <= m ) {
				fputc( ' ', datei );
				++z;
			}
			if ( j == 0 ) n=0;
			else n = j%77;
			while ( m <= n ) fputc( '=', datei ), ++m;
			fputc( '\n', datei );
			sch=0; sch1=0;
		}
		if ( sch ) {
			m = l%77;
			z = 1;
			while ( z <= m+1 ) {
				fputc( ' ', datei );
				++z;
			}
			while ( m+1 <= 77 ) fputc( '=', datei ), ++m;
			l=0;
		}
	}
}
