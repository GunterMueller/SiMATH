/*M
.SH NAME
rtonf - rational number to number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rtonf( R )         
rat R;
  
.SH DESCRIPTION
.TP 4
.B R
is a rational number.
.PP
rtonf returns the representation of R as a number field element (s. fputnfel)

.SH SEE ALSO
fputnfel

M*/
                        
/*H
	Version 1       01.03.1989      Christine Hollinger
   DATE rtonf         : 890601.9107__
H*/

# include <_arith2.h>

nfel rtonf( R )
rat R;
{
	bind( R );

	/*** R = 0 -> a = 0. ***/

	/*** A != 0, so umformen. ***/
	if( R )
	{       int r1,r2;
		init( r1,r2 );

		r1 = lfirst( R );
		r2 = lsecond( R );
		R = list3( r2, 0, r1 );
	}
	return( R );
}
