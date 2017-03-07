/*M
.SH NAME
fputifel - file put integer factor exponent list

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputifel(L,pf)
list L;
FILE *pf;

.SH DESCRIPTION
fputifel()
writes the the prime factorization list L
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B L
is the factor exponent list of a positive integer.
M*/
/*H
	Version 1        3.08.1988      Christine Hollinger
	Version 2       11.08.1988      Christine Hollinger
	Version 3       11.01.1990      C.H.  ( Druckbild )
   DATE fputifel      : 890501.900315.9203__.9311__
H*/

#include <_arith1.h>

single fputifel( L, pf )
list L;
FILE *pf;
{
	single t;
	int e, p;
	init( e,p );
	bind( L );

	/*** 1.Fall: leere Liste. ***/

	if( L == _0 )
	{       t = fputi( 1, pf );
		if( t == 0 )    return( 0 );
		else    return( ERROR );
	}
	else    /*** 2.Fall: sonst. ***/
	{       while( L != _0 )
		{       p = lfirst( L );
			e = lsecond( L );
			L = lred2( L );
			t = fputi( p, pf );
			if( t != 0 ) return( ERROR );
			if( e != 1 )
			{       t = fputc( '^', pf );
				if( t != '^' )    return( ERROR );
				t = fputi( e, pf );
				if( t != 0 ) return( ERROR );
			}
			if( L != _0 )
			{       t = fputc( '*', pf );
				if( t != '*' )    return( ERROR );
			}
		}
	}
	return( 0 );
}
