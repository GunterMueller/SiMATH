/*M
.SH NAME
usdiff - unordered set difference

.SH SYNOPSIS
.nf
#include<_list.h>

list usdiff(L1,L2)  
list L1, L2;
 
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists.
.PP
usdiff returns a list, containing all elements of L1 which are not in L2. 

M*/
     
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE usdiff        : 890501
H*/


# include <_list.h>

list usdiff ( L, M )    /* unsafe L,M */
list L, M;
{
	single  a;
	list  D=_0;
	bind( L ); bind( M );
	while ( L!=_0 )  {
		a = lfirst( L ),  L = lred( L );
		if ( !lmemb( a,M ) )  D = lcomp( a,D );
	      }
	return( D );
}
