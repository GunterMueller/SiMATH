/*M
.SH NAME
rtorfr - rational number to rational function over rationals

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rtorfr(r, R)  
single r; 
rat R;
          
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B R
is a rational number.
.PP
rtorfr returns R as a rational function in r variables over the rationals.

M*/
      
/*H
	Version 1       05.07.1991      Th. Weis
   DATE rtorfr        : 910915
H*/

# include <_arith3.h>

rfunc rtorfr( r, R )
single r;
rat    R;
{
	bind( R );

	/*** R = 0 -> f = 0. ***/

	/*** R != 0, so umformen. ***/
	if( R != 0 )
	{ 
	        list r1,r2;
		init( r1,r2 );

		r1 = pvinsert(0,lfirst(R),r);
		r2 = pvinsert(0,lsecond(R),r);
		R = list2( r1, r2 );
	}
	return( R );
}
