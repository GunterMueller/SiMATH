/*M
.SH NAME
lreduct - list reductum, general

.SH SYNOPSIS
.nf
#include<_list.h>

list lreduct(L, k)  
list L; 
single k;
 
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, a_1, ..., a_n).
.TP 4
.B k
is an integer number, 0 <= k <= n.
.PP
lreduct returns the list (a_k+1, ..., a_n) or the empty list if k = n.
 
M*/         

/*H
	Version  1      08.08.1986      R.Boeffgen
   DATE lreduct       : 890501
H*/


# include <_list.h>

list lreduct ( L, i )            /* safe */
list L;
single i;
{
	while ( i-- )  L = lred( L );
	return( L );
}
