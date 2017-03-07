/*M
.SH NAME
leins - list element insert

.SH SYNOPSIS
.nf
#include<_list.h>

list leins(L, k,a)  
list L; 
single k; 
obj a;
  
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ...,a_n).
.TP 4
.B k
is an integer number, 0 <= k <= length(L).
.PP
leins returns the list 
.IP
(a_1, ..., a_k, a, a_k+1, ..., a_n).
.PP
L will be changed.

M*/
                 
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE leins         : 890501
H*/


# include <_list.h>

list leins ( L, i, a )
list L;
single i;
obj a;
{
	if ( i==0 )  return( lcomp(a,L));
	{
		list L1, L2;
		bind( L );
		for ( L1 = L ; --i ; L1 = lred(L1) );
		L2 = lred( L1 );
		L2 = lcomp( a,L2 );
		lsred( L1,L2 );
		return( L );
	}
}
