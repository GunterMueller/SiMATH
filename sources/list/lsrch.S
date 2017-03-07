/*M
.SH NAME
lsrch - list search

.SH SYNOPSIS
.nf
#include<_list.h>

single lsrch(a, L)  
obj a; 
list L;
  
.SH DESCRIPTION
.TP 4
.B L
is a non empty list.
.PP
lsrch returns 0, if a is not an element in L, else lsrch returns the position of the first occurrence of a in L.
L will be changed.
 
M*/
       
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lsrch         : 890501
H*/


# include <_list.h>

single lsrch ( a, L )          /* safe */
obj  a;
list L;
{
	single i = 1;
	do {
		if ( oequal( lfirst(L) , a ) ) return( i );
		i++;
	}
	while ( (L=lred(L)) != _0 );
	return( 0 );
}
