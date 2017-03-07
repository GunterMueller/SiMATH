/*M
.SH NAME
lpair - list pair

.SH SYNOPSIS
.nf
#include<_list.h>

list lpair(L1, L2)  
list L1, L2;
  
.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists.
.PP
Let L1 = (a_1, ..., a_n) and L2 = (b_1, ..., b_m). Let l = min{n,m}. Then lpair returns the list
.IP
(a_1, b_1, ..., a_l, b_l).

M*/
        
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lpair         : 890501
H*/


# include <_list.h>

list lpair ( L, M )              /* unsafe L,M */
list L, M;
{
	list  P=_0;
	bind( L ); bind( M );
	while ( L!=_0 && M!=_0 )  {
		P = lcomp2( lfirst(M), lfirst(L), P );
		L = lred( L );
		M = lred( M );
	}
	return( linv(P));
}
