/*M
.SH NAME
sinter - set intersection

.SH SYNOPSIS
.nf
#include<_list.h>

list sinter(L1,L2)  
list L1, L2;
   
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists of singles, arranged in ascending order.
.PP                                                   
sinter returns a list, containing the intersection of L1 and L2.

M*/
       
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE sinter        : 890501
H*/


# include <_list.h>

list sinter ( L, M )            /* unsafe L,M */
list L, M;
{
	single a,b;
	list  S=_0;
	bind( L ); bind( M );
	while ( L!=_0 && M!=_0 )  {
		a = lfirst( L ),  b = lfirst( M );
		if ( a<b )      L = lred( L );
		else if ( a>b ) M = lred( M );
		else  {
			S = lcomp( a,S );
			L = lred( L );
			M = lred( M );
		}
	}
	return( linv(S));
}
