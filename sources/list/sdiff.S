/*M
.SH NAME
sdiff - set difference

.SH SYNOPSIS
.nf
#include<_list.h>

list sdiff(L1, L2)  
list L1, L2;
 
.SH DESCRIPTION
.TP 4
.B L1, L2 
are lists of singles, arranged in ascending order.
.PP
sdiff returns a list, containing all elements of L1 which are not in L2.

M*/
       
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE sdiff         : 890501
H*/


# include <_list.h>

list sdiff ( L, M )     /* unsafe L,M */
list L, M;
{
	single a,b;
	list  C=_0, D;
	bind( L ); bind( M );
	while ( L!=_0 && M!=_0 )  {
		a = lfirst( L ),  b = lfirst( M );
		if ( a==b )      L = lred( L ), M = lred( M );
		else if ( a<b )  C = lcomp( a,C ), L = lred( L );
		else             M = lred( M );
	}
	if ( C==_0 )  D = L;
	else  D = linv( C ), lsred( C,L );
	return( D );
}
