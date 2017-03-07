/*C
			ispolvar( name, i )

	"is polynomial variable"
	single ispolvar( name, i );
	char *name; single i;

	ispolvar liefert 1 zurueck, falls der unter name angegebene
	Variablenname eine Unbestimmte des unter varlist[i] abgespei-
	cherten Polynoms ist; sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      7.12.1987       C.Hollinger/U.Schneiders
H*/
 
#include<_calc.h>

single ispolvar( name, i )
char *name;
single i;

{
	single sch, n;
	int v;
	list A1, V;
	pol A;

	init4( A, A1, V, v );
	if(varlist[i].typ!=2 && varlist[i].typ!=(-3)){
	A = lfirst( varlist[i].varwert );
	A1 = lfirst( A );

	/*** Durchsuchen der Variablenliste des unter varlist[i]
	     abgespeicherten Polynoms.  ***/

	while ( A1 != _0 ) {
		V = lfirst( A1 );
		A1 = lred( A1 );
		n = 0;
		sch = 1;
		while ( V != _0 && sch ) {
			v = lfirst( V );
			V = lred( V );
			if ( v == *(name + n) ) ++n;
			else sch = 0;
		}
		if ( sch && *(name + n) == '\0' ) return( 1 );
	}
	}
	return( 0 );
}
