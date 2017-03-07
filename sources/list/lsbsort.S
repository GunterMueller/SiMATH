/*M
.SH NAME
lsbsort - list of single precision bubble sort

.SH SYNOPSIS
.nf
#include<_list.h>

single lsbsort(L)  
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list of single precision numbers.
.PP
lsbsort sorts the elements in L in ascending order.
L will be changed.

M*/
         
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lsbsort       : 890501
H*/


# include <_list.h>

single lsbsort( L )              /* safe */
list L;
{
	single  a1,a2;
	list L1,L2,M,M1;
	if ( L==_0 ) return(0);
	M = _0;
	do {
		L1 = L;
		a1 = lfirst( L1 );
		M1 = _0;
		while ( (L2 = lred(L1)) != M )  {
			a2 = lfirst( L2 );
			if ( a1>a2 ) {
				lsfirst( L1,a2 );
				lsfirst( L2,a1 );
				M1 = L2;
			}
			else  a1 = a2;
			L1 = L2;
		}
	}
	while ( (M=M1) != _0 );
	return(0);
}
