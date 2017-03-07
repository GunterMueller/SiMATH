/*M
.SH NAME
oequal - object equal (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

single oequal(a, b)  
obj a, b;
  
.SH DESCRIPTION
oequal returns 
.TP 4
1,
if a is equal to b, and
.TP 4
0,
else.

M*/
      
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE oequal        : 890501.9011__
H*/


# include <_list.h>

single oequal ( a, b )          /* safe */
obj a,b;
{
	if ( a==b ) return( 1 );
	if ( isatom(a) || isatom(b) ) return( 0 );
	while ( a!=_0 && b!=_0 ) {
		if ( !oequal( lfirst(a),lfirst(b) ) ) return( 0 );
		if ( (a=lred(a)) == (b=lred(b)) )    return( 1 );
	}
	return( 0 );
}
