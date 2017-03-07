/*M
.SH NAME
mamstom2 - matrix over modular single to matrix over Z/2Z

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mamstom2(M, n)
list M;
single n;

.SH DESCRIPTION
mamstom2() returns the matrix M represented as an
n-dimensional vector of gf2 elements in special bit representation.

.PP
.TP 4
.B M
is a matrix over Z/2Z.


.SH SEE ALSO
udpm2tosb
M*/




/*H
	Version 1       09.09.1994      Josef Gebel
   DATE mamstom2      : 941201
H*/

#include <_matr1.h>

list mamstom2( M, n )
matrix M; 
single n;
{
    single k, r, t;
    int    L;
    list   K, N;
    matrix M1;

    bind( M );
    init( L );
    init( K, N );
    init( M1 );

    t = n % 30;

    M1 = M;
    N = _0;

    while( M1 != _0 )
    {
        r = t;
        L = _0;
        K = lfirst( M1 );
        while( K != _0 )
        {
            k = 0;
            while( r )
            {
                k ^= lfirst( K );
                r--;
                if( r )
                {
                    k <<= 1;
                }
                K = lred( K );
            }
            L = lcomp( k, L );
            r = 30;
        }
  
        L = linv( L );
       
        while( !lfirst( L ) && ( L != _0 ) )
        {
            L = lred( L );
        }
        
        k = llength( L );
        if( !k )
        {
            N = lcomp( 0, N );
        }
        else 
        {
            L = lcomp( k, L );
            N = lcomp( L, N );
        }
        M1 = lred( M1 );
    }
 
    return( linv( N ) );
}
