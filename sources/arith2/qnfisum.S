/*M
.SH NAME
qnfisum - quadratic number field element, integer, sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfisum( D, a, b )  
int D, b; 
nfel a;
 
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
is an integer number.
.PP
qnfisum returns an element of K, say c, where
.IP
c = a + b   (as number field elements).

.SH SEE ALSO
fputnfel

M*/
                 
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfisum       : 931130
H*/

#include <_arith2.h>

nfel qnfisum( D, a, b )
int D, b;
nfel a;
{
    bind( D, a, b );

    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !b )
    {
        return( a );
    }
    
    if( !a )
    {
        return( list3( 1, 0, b ) );
    }
    else
    {
	int N, c1;
	nfel c;

	init( N, c1 );
	init( c );

	N = lfirst( a );
	c1 = iprod( b, N );

	if( lsecond( a ) )
	{
	    /***  a = a1/N + a2/N * D^(1/2) in Q(D^(1/2))\Q   ***/
	    
	    c1 = isum( lfourth( a ), c1 );

	    c = list4( N, 1, lthird( a ), c1 );
	    c = qnfminrep( D, c );
	    return( c );
	}
	else
	{
	    /***  a = a1/N in Q  ***/
		
	    c1 = isum( lthird ( a ), c1 );

	    c = list3( N, 0, c1 );
	    c = qnfminrep( D, c );
	    return( c );
	}
    }
}
