/*M
.SH NAME
rp2 - rational number power of 2

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rp2(n)
single n;

.SH DESCRIPTION
rp2() returns the n-th power of 2 as a rational number,
where n may also have negative values.
M*/
/*H
	Version  1      12.07.1986      R.Boeffgen
   DATE rp2           : 890501
H*/


# include <_arith1.h>

rat rp2 ( n )           /* safe */
single n;
{
	int A;
	A = ip2prod( 1,sabs(n) );
	if ( n<0 )  return(list2(1,A));
	return(list2(A,1));
}
