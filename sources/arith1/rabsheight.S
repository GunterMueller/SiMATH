/*M
.SH NAME
rabsheight - rational number absolute height

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating rabsheight(r)
rat r;

.SH DESCRIPTION
rabsheight() returns the absolute height of r.
Let r = s/t with gcd(s, t) = 1 a rational number.
Then the absolute height of r is defined 
to be h(r) = log max{ |s|, |t| }.
M*/
/*H
	Version 1	12.11.1992	Josef Gebel
   DATE rabsheight    : 921130
H*/

#include<_arith1.h>

floating rabsheight( r )
   rat      r;
{
    floating        result;
    int             z, n;

    bind( r );

    init( result );
    init( z, n );
    
    z = iabs( rnum( r ) );
    n = iabs( rden( r ) );

    if( icomp( z, n ) > 0 )
    {
       result = fllog( itofl( z ) );
    }
    else
    {
       result = fllog( itofl( n ) );
    }

    return( result );
}
