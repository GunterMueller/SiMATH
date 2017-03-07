/*M
.SH NAME
usinter - unordered set intersection

.SH SYNOPSIS
.nf
#include<_list.h>

list usinter(L1, L2)  
list L1, L2;
 
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists.
.PP 
usinter returns a list, containing the intersection of L1 and L2.

M*/
          
/*H
	Version  1      11.08.1986      R.Boeffgen
   DATE usinter       : 890501
H*/


# include <_list.h>

list usinter ( L, M )   /* unsafe L,M */
list L, M;
{
	single  a;
	list  S=_0;
	bind( L ); bind( M );
	while ( L!=_0 )  {
		a = lfirst( L ),  L = lred( L );
		if ( lmemb( a,M ) )  S = lcomp( a,S );
	}
	return( S );
}
