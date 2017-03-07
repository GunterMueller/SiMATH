/*M
.SH NAME
rexp - rational number exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rexp(R,n)
rat R;
single n;

.SH DESCRIPTION
rexp() returns R ^ n for n >=0.
M*/

/*H
	Version 1       24.11.1987      H. Stroeher
   DATE rexp          : 890501
H*/


#include <_arith1.h>

rat rexp( R, n )
rat R;
single n;

{
	int  r1,r2;
	init2( r1, r2 );

	if ( !n ) R = itor(1);
	else if ( R ) {
		r1 = lfirst( R );
		r2 = lsecond( R );
		r1 = iexp( r1, n );
		r2 = iexp( r2, n );
		R = list2( r1, r2 );
	}
	return( R );
}
