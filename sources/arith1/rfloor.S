/*M
.SH NAME
rfloor - rational number floor

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rfloor(R)
rat R;

.SH DESCRIPTION
rfloor() returns the biggest integer less or equal to R.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rfloor        : 890501
H*/


# include <_arith1.h>

int rfloor ( R )                /* safe */
rat R;
{
	int  m,n;
	if ( R==0 )  return( 0 );
	iqrem( lfirst(R), lsecond(R), &m,&n );
	if ( isign(n) < 0 )  m = idif( m,1 );
	return( m );
}
