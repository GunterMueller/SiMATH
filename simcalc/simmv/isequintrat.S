/*C
			isequintrat( V1, V2 )

	"is equal integer or rational".
	single isequintrat( V1, V2 );
	list V1, V2;

	isequintrat untersucht V1 und V2 auf Gleichheit,falls beide
	in Z oder Q sind. Bei Gleichheit gibt isequintrat 1 zurueck,
	sonst 0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1     17.03.88         C.Hollinger/U.Schneiders
H*/
/*cS
	isequintrat ruft auf: mistake

		      Macros: isatom, lfirst, lred
Sc*/

#include<_calc.h>
single isequintrat( V1, V2 )
list V1, V2;

{
	single is1, is2;
	int v1, v2;
	init( v1, v2 );
	bind( V1, V2 );

	is1 = isatom( V1 );
	is2 = isatom( V2 );
	if( !is1 && !is2 )
	{       v1 = lfirst( V1 );
		v2 = lfirst( V2 );
		V1 = lred( V1 );
		V2 = lred( V2 );
		while( v1 == v2 && V1 != _0 && V2 != _0 )
		{       v1 = lfirst( V1 );
			v2 = lfirst( V2 );
			V1 = lred( V1 );
			V2 = lred( V2 );
		}
		if( v1 == v2 && V1 == _0 && V2 == _0 )  return( 1 );
		else
		{       mistake( 33 );
			return( 0 );
		}
	}
	else
	{       if( is1 && is2 )
		{       if( V1 == V2 ) return( 1 );
			mistake( 33 );
			return( 0 );
		}
		else
		{       mistake( 33 );
			return( 0 );
		}
	}
}
