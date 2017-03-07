/*M
.SH NAME
lcomp - list composition

.SH SYNOPSIS
.nf
#include<_ec3.h>

list lcomp(a, L);
obj a;
list L;

.SH DESCRIPTION
lcomp() returns the list (a, a1, ... , an)
obtained by inserting the element a at the beginning
of the list L = (a1, ... , an)
M*/

/*H
	Version 1       08.08.1986      R.Boeffgen
	Version 2       11.03.1987      beschleunigt durch Umgehung der
					SIMATH-Konventionen.  RB
	Version 3	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE lcomp         : 890501.941201
H*/

# include <_list.h>

list lcomp( a, L )
obj a;
list L;
{
	list L1;
	if ( AVAIL == _0 ) {
   /***    Parameter sichern    ***/
		bind2( a,L );
   /***    neue Zellen suchen   ***/
		gc();
	}
   /***    composition durchfuehren    ***/
	L1 = AVAIL,  AVAIL = lred( L1 );
	lsfirst( L1,a ),  lsred( L1,L );
	return( L1 );
}
