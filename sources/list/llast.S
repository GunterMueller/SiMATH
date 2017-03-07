/*M
.SH NAME
llast - list last object

.SH SYNOPSIS
.nf
#include<_list.h>

list llast(L)  
list L;
  
.SH DESCRIPTION
.TP 4
.B L
is a list.
.PP
llast returns a list, containing the last element of the list L.

M*/
      
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE llast         : 890501
H*/


# include <_list.h>

list llast ( L )         /* safe */
list L;
{
	list L1;
	L1 = L;
	while ( L != _0 ) {
		L1 = L;
		L = lred( L1 );
	}
	return ( L1 );
}
