/*M
.SH NAME
lcinv - list constructive inverse

.SH SYNOPSIS
.nf
#include<_list.h>

list lcinv(L)  
list L; 

.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_0, a_1, ..., a_n).
.PP
lcinv returns the list 
.IP
(a_n, a_n-1, ..., a_1, a_0).
 
M*/
       
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lcinv         : 890501
H*/


# include <_list.h>

list lcinv ( L )         /* unsafe L */
list L;
{
	list L1,L2;
	obj  a;
	bind( L );
	L1 = _0,  L2 = L;
	while ( L2 != _0 ) {
		a = lfirst( L2 );
		L2 = lred( L2 );
		L1 = lcomp( a,L1 );
	}
	return( L1 );
}
