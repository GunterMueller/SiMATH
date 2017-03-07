/*M
.SH NAME
lmemb - list member

.SH SYNOPSIS
.nf
#include<_list.h>

single lmemb(a, L)  
obj a; 
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list.
.PP
lmemb returns 1, if a is an element in L and 0 else.

M*/
             
/*H
	Version  1      22.07.1986      R.Boeffgen
   DATE lmemb         : 890501
H*/


# include <_list.h>

single lmemb ( a, L )         /* safe */
obj  a;
list L;
{
	while ( L!=_0 ) {
		if ( oequal( lfirst(L),a ) )  return( 1 );
		L = lred( L );
	}
	return( 0 );
}
