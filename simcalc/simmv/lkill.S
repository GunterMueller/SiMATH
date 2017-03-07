/*C
			lkill( L, pos )

	"listkill".
	list lkill( L, pos );
	list L;
	single pos;

	lkill eliminiert das pos.te Element aus der Liste L und
	liefert die um ein Element verkuerzte Liste zurueck.
	Laeuft lkill fehlerhaft ab, d.h. ist pos groesser als die
	Anzahl der Listenkomponenten, so liefert lkill -BASIS
	zurueck.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.01.88        C.Hollinger/U.Schneiders
H*/
/*cS
	lkill ruft auf: lcomp, lconc, linv

		Macros: lfirst, lred
Sc*/
 
#include<_calc.h>

list lkill( L, pos )
list L;
single pos;

{
	list L1, L2;
	single i;
	obj l;
	init( L1, L2, l );
	bind( L );

	if ( L == _0 ) return( -BASIS );
	i = 1;
	L1 = _0;
	l = lfirst( L );
	L = lred( L );
	while ( i < pos && L != _0 )
	{       L1 = lcomp( l, L1 );
		l = lfirst( L );
		L = lred( L );
		i++;
	}
	if ( i < pos && L == _0 ) return( -BASIS );
	L2 = linv( L1 );
	L1 = _0;
	L1 = lconc( L2, L );
	return( L1 );
}
