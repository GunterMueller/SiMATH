/*M
.SH NAME
ravalint - rational additive value with respect to integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ravalint(M,R)
int M;
rat R;

.SH DESCRIPTION
ravalint() returns the additive m-adic value w of R,
i.e.  w = iaval(M, numerator(R)) - iaval(M, denominator(R))
for M >=2 and R!=0.
M*/
/*H
	Version 1	13.08.91	J.Schmitt
   DATE ravalint      : 910915.9301__
H*/

# include <_arith1.h>

single ravalint( p,R )
int p;
rat R;
{
	single n;
	int z;
	init(z);
	bind(p,R);


	z = lfirst( R );
	n = iavalint( p,z );
	z = lsecond( R );
	n = n - iavalint( p,z );
	return( n );
}
