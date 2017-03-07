/*M
.SH NAME
mam2toms - matrix over Z/2Z to matrix over modular single

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2toms(M, n)
list M;
single n;

.SH DESCRIPTION
mam2toms() returns the matrix M represented as an nxn matrix over Z/nZ.

.PP
.TP 4
.B M
is a matrix over Z/2Z in special bit representation.


.SH SEE ALSO
mamstom2
M*/
/*H
	Version 1       09.09.1994      Josef Gebel
   DATE mam2toms      : 941201
H*/

#include <_matr1.h>

matrix mam2toms( M, n )
list M; 
single n;
{
    single i, j, k, l;
    matrix N;
    list   K, M1;
    int	   L;

    bind( M );
    init( N );
    init( L );
    init( K, M1 );
 
    N = _0;
    M1 = lcopy( M );

    for( i = 0; i < n; i++ )
    {
	K = _0;
	L = lfirst( M1 );
	l = n; 

	if( !L )
	{
	    for( j = 0; j < n; j++ )
	    {
		K = lcomp( 0, K );
	    }
	}
	else
	{
	    L = lred( L );
	    L = linv( L );

	    while( L != _0 )
	    {
		k = lfirst( L );
		for( j = 0; ( j < 30 ) && l; j++ )
		{
		    K = lcomp( k & 1, K );
		    k >>= 1;
		    l--;
		}
		L = lred( L );
	    }

	    while( l-- )
	    {
		K = lcomp( 0, K );
	    }
	}

	M1 = lred( M1 );
	N = lcomp( K, N );
    }
    
    return( linv( N ) );
}
