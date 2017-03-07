/*M
.SH NAME
sunion - set union

.SH SYNOPSIS
.nf
#include<_list.h>

list sunion(L1, L2)  
list L1, L2;
     
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists of singles, arranged in ascending order.
.PP  
sunion returns a list, containing the union of L1 and L2.

M*/
   
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE sunion        : 890501
H*/


# include <_list.h>

list sunion ( L, M )            /* unsafe L,M */
list L, M;
{
	single  a,b;
	list  U=_0, V;
	bind( L ); bind( M );
	while ( L!=_0 && M!=_0 )  {
		a = lfirst( L ),  b = lfirst( M );
		if ( a<b ) {
			U = lcomp( a,U );
			L = lred( L );
		}
		else {
			U = lcomp( b,U );
			M = lred( M );
			if ( a==b )  L = lred( L );
		}
	}
	if ( L==_0 )  L = M;
	if ( U==_0 )  V = L;
	else  V = linv( U ), lsred( U,L );
	return( V );
}
