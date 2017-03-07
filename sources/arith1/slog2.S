/*M
.SH NAME
slog2 - single-precision logarithm, base 2

.SH SYNOPSIS
.nf
#include<_arith1.h>

single slog2(a)
single a;

.SH DESCRIPTION
slog2() returns the integer part of log2(|a|) incremented by 1
or 0 if a equals 0.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      05.07.1991      ueberfl. Variable m beseitigt.  PS
   DATE slog2         : 890501.910715
H*/


# include <_arith1.h>

single slog2 ( a )                /* safe */
single a;
{
	if ( a==0 )  return( 0 );
	a = sabs( a );
	{
    /***    binaere Suche    ***/
		single  /*m=0,*/ n=32;
		unsigned  mask=~0<<16, sh=16;
		while ( sh )
		if (a & mask) { /*m += sh;*/  sh >>= 1;  mask <<= sh; }
		else          { n -= sh;  sh >>= 1;  a <<= sh; }
		return( n );
	}
}
