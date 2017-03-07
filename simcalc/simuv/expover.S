/*C
			expover( r, a1, a2 )

	"exponent overflow".
	single expover( r, a1, a2 ); single r; obj a1, a2;
	X = expover( r, a1, a2 );

	expover ueberprueft, ob bei Multiplikation von a1 mit a2 in
	r Variablen Exponenten entstehen, die groesser als BASIS sind.
	In diesem Fall liefert expover 0, sonst 1 zurueck.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      30.06.1988      C.Hollinger/U.Schneiders
H*/
/*cS
	expover  ruft auf:  isum, mistake, pdegvec

		   Macros:  lfirst, lred
Sc*/

#include<_calc.h>

single expover( r, a1, a2 )
single r;
obj a1, a2;

{
	list L1, L2;
	int o1, o2 ;
	init( o1, o2, L1, L2 );
	bind( a1, a2 );

	if(!a1 || !a2)  return(1);
	if( r )
	{       L1 = pdegvec( r, a1 );
		L2 = pdegvec( r, a2 );
		while( L1 != _0 )
		{       o1 = lfirst( L1 );
			o2 = lfirst( L2 );
			o1 = isum( o1, o2 );
			if( o1 >= BASIS )
			{       mistake( 28 );
				return( 0 );
			}
			L1 = lred( L1 );
			L2 = lred( L2 );
		}
	}
	return( 1 );
}
