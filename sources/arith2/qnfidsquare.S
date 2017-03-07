/*M
.SH NAME
qnfidsquare - quadratic number field ideal square

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfidsquare(D, A)  
int D; 
list A;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B A
is an ideal in the ring of integers O_K of the field K (for representation of ideals s. below).
.PP  
qnfidsquare returns the ideal C (say), where
.IP
C = A^2 = A * A.

.SH SEE ALSO
qnfidprod

M*/
                                    
/*H
        Version 1	14.10.1993      Josef Gebel
	Version 2 	08.11.1994	Aufruf von isqnfidone. US.
   DATE qnfidsquare   : 931130.941201
H*/

#include <_arith2.h>

list qnfidsquare( D, A )
int  D; 
list A;
{
    bind( D, A );

    if( !lfirst( A ) || isqnfidone( D, A ) )
    {
	/***   A ist das Null- oder das Eins-Ideal: A^2 = A  ***/
	return( A );
    }
    else
    {
	single s;
	int    Q, P, h, k, u, x;

	init( Q, P, h, k, u, x );

	Q = lsecond( A );
	P = lthird ( A );
	s = lfourth( A );

	h = isquot( Q, s );
	k = isprod( P, 2 );
	k = isquot( k, s );

	u = ihegcd( h, k, &x );

	if( icomp( u, h ) )
	{
	    k = iprod( P, P );
	    k = idif ( D,  k );
	    k = iprod( k, x );
	    k = iquot( k, Q );

	    x = iquot( Q, u );

	    if( x == 1 )
	    {
	        k = 0;
	    }
	    else
	    {
	        k = mihom( x, k );
	    }
	    
	    h = iprod( k, h );
	    h = iquot( h, u );
	    h = isum ( h, P );
    
	    x = iprod ( x, x );
	    x = isquot( x, s );

	    if( x == 1 )
	    {
	        h = 0;
	    }
	    else
	    {
	        h = mihom( x, h );
	    }
        }
	else
	{
	    /***   u = Q/s ==> Q' = s, P' = P mod s  ***/
	    x = s;
	    h = s - 1;
	}

	k = lfirst( A );
	u = iprod( u, k );
	u = iprod( u, k );

	return( list4( u, x, h, s ) );
    }
}
