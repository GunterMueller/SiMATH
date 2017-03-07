/*C
			isequpol( r, P1, P2 )

	"is equal polynomial".
	single isequpol( r, P1, P2 );
	single r;
	pol P1, P2;

	P1 und P2 sind Polynome ueber einer gemeinsamen Variablen-
	liste der Laenge r. isequpol untersucht P1 und P2 auf Gleich-
	heit. Bei erfolgreichem Test gibt isequpol 1 zurueck,sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1     17.03.88         C.Hollinger/U.Schneiders
H*/
/*cS
	peval ruft auf: mistake, oequal

		Macros: lfirst, lred
Sc*/

#include<_calc.h>

single isequpol( r, P1, P2 )
single r;
pol P1, P2;

{       list O1, O2;
	single exp1, exp2, i, h;
	bind( P1, P2 );
	init( O1, O2 );

	while( P1 != _0 && P2 != _0 )
	{       O1 = lfirst( P1 );
		P1 = lred( P1 );
		O2 = lfirst( P2 );
		P2 = lred( P2 );
		h = oequal( O1, O2 );
		if( !h )
		{       mistake( 33 );
			return( 0 );
		}
	}
	if( P1 == _0 && P2 == _0 ) return( 1 );
	else 
	{	mistake( 33 );
		return( 0 );
	}
}
