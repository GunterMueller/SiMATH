/*M
.SH NAME
rlog2 - rational number logarithm, base 2

.SH SYNOPSIS
.nf
#include<_arith1.h>

single rlog2(R)
rat R;

.SH DESCRIPTION
rlog2() returns the smallest integer less or equal to log2(|R|)
for R!=0.
M*/
/*H
	Version  1      30.06.1986      R.Boeffgen
   DATE rlog2         : 890501
H*/


# include <_arith1.h>

single rlog2 ( R )               /* unsafe r1,r2  */
rat R;
{
	single  n;
	int  r1, r2;
	r2 = lsecond( R );
	bind( r2 );
	r1 = iabs( lfirst(R) );
	bind( r1 );
	n = ilog2( r1 ) - ilog2( r2 );
	if ( n<0 ) r1 = ip2prod(r1,-n);
	     else  r2 = ip2prod(r2, n);
	if ( icomp( r1,r2 ) >0 )  n++;
	return( n );
}
