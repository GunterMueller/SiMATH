/*M
.SH NAME
oextent - object extent (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

single oextent(a)  
obj a;
  
.SH DESCRIPTION
oextent returns the number of cells in SPACE, allocated by the object a.
 
M*/
      
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE oextent       : 890501
H*/


# include <_list.h>

single oextent ( a )          /* safe */
obj a;
{
	single  n = 0;
	if    ( isatom(a) )    return( 0 );
	while ( a != _0 ) {
		n += oextent( lfirst(a) ) + 1;
		a = lred(a);
	}
	return( n );
}
