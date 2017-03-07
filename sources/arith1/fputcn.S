/*M
.SH NAME
fputcn - file put complex number

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputcn(a,v,n,pf)
complex a;
single v,n;
FILE *pf;

.SH DESCRIPTION
fputcn()
writes the the complex number a
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
Let a = x+y*i with floating point numbers x and y.
The output of fputcn() is of the form "x + y i",
where x and y are written using fputflfx().
fputflfx() is given the number v of decimal digits
and the number n of decimal places to write.
Special cases:
.PP
.nf
    x =  0 , "x +" will not be written
    y =  0 , "+ y i" will not be written
    y = +1 , only "i" will be written
    y = -1 , only "-i" will be written

Examples: let v = n = 1, given the value of a

    4+3*i : "4.0 + 3.0 i"
        0 : "0"
     -3*i : "-3.0 i"
        i : "i"
       -i : "-i"
     12.5 : "12.5"
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE fputcn        : 931130
H*/

#include<_arith1.h>

single fputcn( a, v, n, pf ) 
complex a;
single v, n;
FILE *pf;
{
    bind( a );

    if( a )
    {
        floating re, im;
	single s;
    
        init( re, im );
    
        re = lfirst ( a );
        im = lsecond( a );
	s = flsign( im );
    
	if( re )
	{
	    if( ( fputflfx( re, v, n, pf ) == ERROR )
            ||  ( fputc( ' ', pf ) == ERROR ) )
	    {
		return( ERROR );
	    }
	    if( s > 0 )
	    {
                if( fputc( '+', pf ) == ERROR )
		{
		    return( ERROR );
		}
            }
	}
	if( !s )
	{
            return( 0 );
	}
        if( s < 0 )
	{
            if( fputc( '-', pf ) == ERROR )
	    {
		return( ERROR );
	    }
	}
	im = flabs( im );
	if( flcomp( im, itofl( 1 ) ) )
	{
	    if( ( fputflfx( im, v, n, pf ) == ERROR )
            ||  ( fputc( ' ', pf ) == ERROR ) )
	    {
		return( ERROR );
	    }
        }
        if( fputc( 'i', pf ) == ERROR )
	{
	    return( ERROR );
	}
    }
    else if( fputc( '0', pf ) == ERROR )
    {
	return( ERROR );
    }
    return( 0 );
}
