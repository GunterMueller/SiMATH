/*M
.SH NAME
rceil - rational number ceiling

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rceil(R)
rat R;

.SH DESCRIPTION
rceil() returns the smallest integer greater or equal to R.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rceil         : 890501
H*/


# include <_arith1.h>

int rceil( R )                /* safe */
rat R;
{
	int m,n;
	if ( R==0 )  return( 0 );
	iqrem( lfirst(R), lsecond(R), &m,&n );
	if ( isign(n) > 0 )  m = isum( m,1 );
	return( m );
}
