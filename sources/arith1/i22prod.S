/*M
.SH NAME
i22prod - integer 2x2 product

.SH SYNOPSIS
.nf
#include<_arith1.h>

int i22prod(A,B)
int A,B;

.SH DESCRIPTION
i22prod() returns A*B.
.PP
.TP 4
.B A
is an integer 2^30 <= |A| < 2^60
.TP 4
.B B
is an integer 2^30 <= |B| < 2^60
M*/
/*H                       
	Version 1	14.02.1992	Marc Conrad
   DATE i22prod       : 920331
H*/


# include <_arith1.h>

int i22prod( A, B )
int A, B;
{
	single  a,b, a2, d, c0, c1, c2, c3, e;
	
	sprod( (a=lfirst( A )), (b=lfirst( B )), &c1, &c0 );
	sprod( (a2=lsecond( A )), b, &c2, &d );
	c1 += d; 
	if      (c1 >=  BASIS) c1 -= BASIS, c2++;
	else if (c1 <= -BASIS) c1 += BASIS, c2--;     
	sprod ( a, b = lsecond( B ), &e, &d );
	c1 += d;
	if      (c1 >=  BASIS) c1 -= BASIS, e++;
	else if (c1 <= -BASIS) c1 += BASIS, e--;  
	sprod ( a2, b, &c3, &d );
	c2 += e; 
	if      (c2 >=  BASIS) c2 -= BASIS, c3++;
	else if (c2 <= -BASIS) c2 += BASIS, c3--;     
	c2 += d; 
	if      (c2 >=  BASIS) c2 -= BASIS, c3++;
	else if (c2 <= -BASIS) c2 += BASIS, c3--;     
	if ( c3 ) A = list4( c0, c1, c2, c3 );
	else A = list3( c0, c1, c2 );
	return ( A );
	}
