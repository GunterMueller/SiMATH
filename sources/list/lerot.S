/*M
.SH NAME
lerot - list element rotation

.SH SYNOPSIS
.nf
#include<_list.h>

single lerot(L, k, l)  
list L; 
single k, l;

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ...,a_n).
.TP 4
.B k, l
are integer numbers, 1 <= k <= l <= length(L).
.PP
lerot transforms the list L to 
.PP
(a_1, ..., a_k-1, a_l, a_k, ..., a_l-1, a_l+1, ..., a_n).
  
M*/
       
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lerot         : 890501
H*/


# include <_list.h>

single lerot ( L, i, j )
list L;
single i,j;
{
	obj  a, b;
	list R;
	int k = i;
	while ( --k )  L = lred( L );
	a = lfirst( L );
	for ( R=lred(L) ; i++ < j ; R=lred(R) )  {
		b = lfirst( R );
		lsfirst( R,a );
		a = b;
	}
	lsfirst( L,a );
	return(0);
}
