/*M
.SH NAME
fputfactl - file put factor list

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputfactl(L,pf)
list L;
FILE *pf;

.SH DESCRIPTION
fputfactl()
writes the the factor list L
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B L
is a list of the form ( p_1  e_1  p_2  e_2  ...  p_n  e_n )
with integers p_1, p_2, ..., p_n and singles e_1, e_2, ..., e_n 
(c.f. 'ifel'). It will be written as p1^e_1 * p2^e_2  * ... * p_n^e_n.
M*/

/*H
	Version 1	17.12.1992	Josef Gebel
   DATE fputfactl     : 930531
H*/	

#include <_arith1.h>

fputfactl( L, pf )
list L;
FILE *pf;
{
    list H;

    bind( L );
    init( H );

    H = L;
    while( H != _0 )
    {
        if( fprintf( pf, "%i", lfirst( H ) ) < 0 )
	{
	    return( ERROR );
	}
        if( lsecond( H ) > 1 )
        {
            if( fprintf( pf, "^%i", lsecond( H ) ) < 0 )
	    {
		return( ERROR );
	    }
        }
        if( lsecond( H ) < 0 )
        {
            if( fprintf( pf, "^(%i)", lsecond( H ) ) < 0 )
	    {
		return( ERROR );
	    }
        }
        H = lred2( H );
        if( H != _0 )
        {
            if( fprintf( pf, " * " ) < 0 )
	    {
		return( ERROR );
	    }
	}
    }
    return( 0 );
}
