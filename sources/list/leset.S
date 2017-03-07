/*M
.SH NAME
leset - list element set

.SH SYNOPSIS
.nf
#include<_list.h>

single leset(L, k, a)  
list L; 
single k; 
obj a;

.SH DESCRIPTION
.TP 4
.B L
is a list.
.TP 4
.B k
is an integer number, 1 <= k <= length(L).
.PP
leset replaces the k-th element of L with a.
          
M*/
   
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE leset         : 890501
H*/


# include <_list.h>

single leset ( L, k, a )
list L;
single k;
obj a;
{
	while ( --k )  L = lred( L );
	lsfirst( L, a );
	return(0);
}
