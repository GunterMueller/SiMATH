/*C
			expoverint( r, P, a )

	"exponent overflow concerning integers".
	single expoverint( r, P, a );  single r; obj P; int a;
	X = expoverint( r, P, a );

	expoverint ueberprueft, ob bei Multiplikation einer ganzen
	Zahl a mit einem Polynom P in r Variablen Exponeneten ent-
	stehen, die grosser als BASIS sind. In diesem Fall liefert
	expoverint 0, sonst 1 zurueck.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      30.06.1988      C.Hollinger/U.Schneiders
H*/
/*cS
	expoverint ruft auf:   iprod, mistake, pdegvec

		     Macros:   lfirst, lred
Sc*/

#include<_calc.h>

single expoverint( r, P, a )
single r;
obj P;
int a;

{       list L;
	obj o;
	init( L, o );
	bind( P, a );

	if( r )
	{       L = pdegvec( r, P );
		while( L != _0 )
		{       o = lfirst( L );
			o = iprod( o, a );
			if( o >= BASIS )
			{       mistake( 28 );
				return( 0 );
			}
			L = lred( L );
		}
	}
	return( 1 );
}
