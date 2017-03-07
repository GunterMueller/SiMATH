/*M
.SH NAME
linv - list inverse

.SH SYNOPSIS
.nf
#include<_list.h>

list linv(L)  
list L;
  
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ..., a_n).
.PP
linv returns the list
.IP
(a_n, a_n-1, ..., a_1).
.PP
L will be changed.
 
M*/
      
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE linv          : 890501
H*/


# include <_list.h>

list linv ( L )
list L;                            /* safe */
{
	list  M=_0, N;
	while ( L!=_0 ) {
		N = lred( L );
		lsred( L,M );
		M = L,  L = N;
	}
	return( M );
}
