/*M
.SH NAME
lsins - list of single precisions insert

.SH SYNOPSIS
.nf
#include<_list.h>

list lsins(n,L)  
single n; 
list L; 

.SH DESCRIPTION
.TP 4
.B L
is a list of singles, sorted in ascending order.
.TP 4
.B n
is an integer number, 0 <= n < BASIS.
.PP
lsins returns a list L1. L1 arises by inserting n in L. L1 will be sorted in ascending order.
L will be changed.

M*/
               
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lsins         : 890501
H*/


# include <_list.h>

list lsins ( n, L )            /* unsafe L */
single n;
list L;
{
	if ( L==_0 || n<lfirst(L) )  return(lcomp(n,L));
	{
		list  L1=L, L2=lred(L1), L3;
		bind( L );
		while ( L2 != _0  &&  n >= lfirst(L2) )
			L1 = L2,  L2 = lred( L1 );
		L3 = lcomp( n,L2 );
		lsred( L1,L3 );
	}
	return( L );
}
