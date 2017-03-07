/*M
.SH NAME
rinv - rational number inverse

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rinv(R)
rat R;

.SH DESCRIPTION
rinv() returns R^(-1) for R!=0.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rinv          : 890501
H*/


# include <_arith1.h>

rat rinv ( R )                /* unsafe r1,r2 */
rat R;
{
	int  r1 = lfirst( R );
	int  r2 = lsecond( R );
	bind( r2 );
	if ( isign(r1) < 0 )  {
		bind( r1 );
		r1 = ineg( r1 );
		r2 = ineg( r2 );
	}
	R = list2( r2,r1 );
	return( R );
}
