/*M
.SH NAME
lelt - list element

.SH SYNOPSIS
.nf
#include<_list.h>

obj lelt(L, k)  
list L; 
single k;
 
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ...,a_n).
.TP 4
.B k
is an integer number, 1 <= k <= length(L).
.PP      
lelt returns a_k.

M*/
                    
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lelt          : 890501
H*/


# include <_list.h>

obj lelt ( L, k )
list L;
single k;
{
	while ( --k )  L = lred( L );
	return( lfirst(L) );
}
