/*M
.SH NAME
qnfrsum - quadratic number field element, rational number, sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfrsum( D, a, b )  
int D; 
nfel a; 
rat b;
  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an element of K (for representation of number field elements s. fputnfel).
.TP 4
.B b
is a rational number.
.PP
qnfrsum returns an element of K, say c, where
.IP
c = a + b  ( as number field elements).

.SH SEE ALSO
fputnfel
                       
M*/

/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfrsum       : 931130
H*/

#include <_arith2.h>

nfel qnfrsum( D, a, b )
int D;
nfel a;
rat b;
{
    bind( D, a, b );

    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !b )
    {
        return( a );
    }
    else
    {
	int N, c1, h;
	init( N, c1, h );

	N = lfirst( a );

	if( lsecond( a ) )
	{
	    /***  a = a1/N + a2/N * D^(1/2) in Q(D^(1/2))\Q   ***/

	    int c2;
	    init( c2 );
	    
	    h  = rnum( b );
	    c1 = iprod( N, h );
	    h  = rden( b );
	    c1 = isum( c1, iprod( lfourth( a ), h ) );

	    c2 = iprod( lthird( a ), h );
	    
	    N = iprod( N, h );

	    return( qnfminrep( list4( N, 1, lthird( a ), c1 ) ) );
	}
	else
	{
	    /***  a = a1/N in Q  ***/
		
	    h  = rnum( b );
	    c1 = iprod( N, h );
	    h  = rden( b );
	    c1 = isum( c1, iprod( lfourth( a ), h ) );
	    
	    N = iprod( N, h );

	    return( qnfminrep( list3( N, 0, c1 ) ) );
	}
    }
}
