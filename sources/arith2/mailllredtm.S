/*M
.SH NAME
mailllredtm - matrix of integers, LLL reduction transformation matrix

.SH SYNOPSIS
.nf
#include<_arith2.h>

matrix  mailllred(B)  
matrix B;

.SH DESCRIPTION
.TP 4
.B B
is an n x n matrix over Z with n > 0, such that the rows of B form n over Z linearly independent vectors in Z^n.
.PP 
mailllredtm returns the transformation matrix, say T, transforming the basis B into an LLL-reduced basis, say L, where B and L generate the same Z-module: L = T * B. 
.PP
In case of an error occurs, mailllredtm returns 0.
 
.SH SEE ALSO

Literature: B. de Weger: "Algorithms for Diophantine 
                          Equations",
            Dissertation, Centrum voor Wiskunde en 
            Informatica, Amsterdam 1987.

M*/
                  
/*H
	Version 1	08.03.1994	Josef Gebel
   DATE mailllredtm   : 941201
H*/

#include <_arith2.h>

static matrix swap_rows(matrix,single);
static matrix reduct(single,single,single,single,matrix,int*,int*);
static int nnrstintq(int,int);
static getstartvalues(matrix,single,int*,int*);

matrix mailllredtm( B )
matrix B;
{
    single i, j, k, n, p, q;
    int    h, u, v, *d, *l;
    matrix T;

    bind( B );

    n = llength( B );
    j = n + 1;

    if( ( d = ( int * ) malloc( j * sizeof( int ) ) ) == NULL )
    {
        return( 0 );
    }

    init( d[0..n] );

    j = ( ( n - 1 ) * n ) / 2;
    if( ( l = ( int * ) malloc( j * sizeof( int ) ) ) == NULL )
    {
        free( d );
        return( 0 );
    }
 
    j--;
    init( l[0..j] );

    init( T );
    init( h, u, v );

    T = maconsdiag( n, 1 );

    k = 2;

    if( getstartvalues( B, n, l, d ) )
    {
        free( d );
        free( l );
        return( 0 );
    }
    
    p = ( k * ( k - 3 ) ) / 2;             /***  l[p+i] = l[k,i]   ***/

    while( 1 )
    {
        while( 1 )
        {
            T = reduct( k, k - 1, n, p, T, l, d );

            j = p + k - 1;
            h = iprod( d[k], d[k - 2] );
            u = iprod( l[j], l[j] );
            h = isum( h, u );
            h = isprod( h, 4 );
    
            u = iprod( d[k - 1], d[k - 1] );
            u = isprod( u, 3 );

            if( icomp( h, u ) < 0 )
            {
                T = swap_rows( T, k );

                if( k > 2 )
                {
                    j = ( ( k - 1 ) * ( k - 4 ) ) / 2; 
                                         /***   l[j+i] = l[k-1,i]  ***/

                    /***   swap l[k,i] und l[k-1,i] for 1<=i<k-1   ***/
                    for( i = 1; i < k - 1; i++ )
                    {
                        h = l[p + i];
                        l[p + i] = l[j + i];
                        l[j + i] = h;
                    }
                }
                
                u = l[p + k - 1];      /***   u = l[k,k-1]         ***/
            
                i = k + 1;
                j = ( k * i ) / 2 - 1; /***   l[j+s] = l[k+1,k+s]  ***/
                                       /***          = l[  i,k+s]  ***/
                                       /***   ( 0 <= s < i - k )   ***/

                while( i <= n )
                {
                    h = l[j];   /***   h = l[i,k]                  ***/

                    /***   l[i,k] := l[i,k-1] * d[k]               ***/
                    /***             - l[i,k] * l[k,k-1]           ***/
                    v    = iprod( h, u );
                    l[j] = iprod( d[k], l[j - 1] );
                    l[j] = idif ( l[j], v );
                    l[j] = iquot( l[j], d[k - 1] );
            
                    /***   l[i,k-1] := l[i,k-1] * l[k,k-1]         ***/
                    /***               + l[i,k] * d[k-2]           ***/
                    /***   with the value of l[i,k]  b e f o r e   ***/
                    /***   the loop (saved in the variable h)      ***/
                    j--;
                    v    = iprod( u, l[j] );
                    h    = iprod( h, d[k - 2] );
                    v    = isum ( h, v );
                    l[j] = iquot( v, d[k - 1] );

                    j += i;
                    i++;
                }

                v = iprod( d[k - 2], d[k] );
                h = iprod( u, u );
                v = isum ( h, v );
                d[k - 1] = iquot( v, d[k - 1] );

                if( k > 2 )
                {
                    k--;
                    p -= k;
                    p++;                  /***  l[p+i] = l[k,i]   ***/
                }
            }
            else
            {
                /***   4 * ( d[k-2] * d[k] + l[k,k-1]^2 )         ***/
                /***                             >= 3 * d[k-1]    ***/

                j = k - 2;
                while( j > 0 )
                {
                    T = reduct( k, j, n, p, T, l, d );
                    j--;
                }

                if( k == n )
                {
                    free( d );
                    free( l );
                
                    return( T );
                }
                p += k;
                p--;                      /***  l[p+i] = l[k,i]   ***/
                k++;
                break;
            }
        }
    }
}
/******************************************* mailllredtm *** END ***/

/*c 
                           swap_rows( T, k )

	"swap rows"
        static matrix swap_rows( T, k ) matrix T; single k;
        A = swap_rows( T, k ) matrix T; single k;
        swap_rows( T, k ) swaps the k-th and the (k-1)-th
        rows of the matrix T.
        Return value: The 'swapped' matrix T.
c*/

static matrix swap_rows( T, k )
matrix T;
single k;
{
    matrix A, M;
    single i;

    bind( T );
    init( A, M );

    i =  1;
    A =  T;
    M = _0;
            
    while( A != _0 )
    {
        if( i == k - 1 )
        {
            M = lcomp( lsecond( A ), M );
            M = lcomp( lfirst ( A ), M );
            A = lred2( A );
            break;
        }
        else
        {
            M = lcomp( lfirst( A ), M );
            A = lred( A );
        }
        i++;
    }
    M = linv( M );
    M = lconc( M, A );

    return( M );
}
/******************************************* swap_colums *** END ***/

/*c 
                          reduct( k, j, n, p, T, l, d )

	"reduction"
        static matrix reduct( k, j, n, p, T, l, d ) 
            single k, j, n, p; matrix T; int *l, *d;
        A = reduct( k, j, n, p, T, l, d );
        reduct( k, j, n, p, T, l, d ) is the procedure (*) for l = j 
        in the paper of de Weger.
        Return value: The 'reduced' matrix T.
c*/

static matrix reduct( k, j, n, p, T, l, d )
single k, j, n, p;
matrix T;
int *l, *d;
{
    int      h;
    
    init( h );
    bind( T );

    if( h = nnrstintq( l[p + j], d[j] ) )
    {
        /***   2 * | l[k,j] | > d[j]                      ***/
        single i, q;
        vec    K, L;
        matrix M;
    
        init( K, L, M );

        q = ( j * ( j - 3 ) ) / 2;
        
        M = T;
        for( i = 1; i < k; i++ )
        {
            if( i == j )
            {
                L = lfirst( M );
            }
            M = lred( M );
        }
        K = lfirst( M );    /***   L = T_j and K = T_k   ***/
    
        K = vecilc( 1, h, K, L ); 
        /***   K := K - { l[k,j] / d[j] } * L            ***/
    
        M = T;
        leset( M, k, K );
    
        l[p + j] = isum( l[p + j], iprod( h, d[j] ) );

        for( i = 1; i < j; i++ )
        {
            l[p + i] = isum( l[p + i], iprod( h, l[q + i] ) );
        }
    
        return( M );
    }
    return( T );
}
/************************************************ reduct *** END ***/

/*c 
                   vecisquare( V );

	"vector of integers, square"
        static int vecisquare( V ) vec V;
        v = veciquot( V );
        V = ( v1  v2  ...  vn ) int vi; is a vector of integers vi.
        Return value: v = v1^2 + v2^2 + ... + vn^2.
c*/

static int vecisquare( V )
vec V;
{
    vec W;
    int a, b;

    bind( V );
    init( W, a, b );

    W = V;

    while( W != _0 )
    {
       a = lfirst( W );
       W = lred( W );
       b = isum( b, iprod( a, a ) );
    }

    return( b );
}
/******************************************** vecisquare *** END ***/
    
/*c 
                          veciquot( V, a )

	"vector of integers, quotient"
        static vec veciquot( V, a ) vec V; int a;
        W = veciquot( V, a );
        V = ( v1  v2  ...  vn ) int vi; is a vector of integers vi,
        a is a non-zero integer.
        Return value: W = ( v1:q  v2:q  ...  vn:q ), where vi:q is the 
           largest integer smaller than the quotient vi/q.
c*/

static vec veciquot( V, a )
vec V;
int a;
{
    vec U, W;
    int b;

    bind( V, a );
    init( U, W, b );

    W = _0;
    U = V;

    while( U != _0 )
    {
       b = lfirst( U );
       U = lred( U );
       b = iquot( b, a );
       W = lcomp( b, W );
    }

    return( linv( W ) );
}
/********************************************** veciquot *** END ***/
    
/*c 
                          nnrstintq( a, b )

	"negative of nearest integer to quotient of two integers"
        static int nnrstintq( a, b ) int a, b;
        c = nnrstintq( a, b );
        nclstintq( a, b ) computes the negative of the integer c for
        which | c - a/b | is minimal. If | c - a/b | is minimal for 2
        values c1 and c2 the result will be the larger of the two.
c*/
              
static int nnrstintq( a, b )
int a, b;
{
    int c, d, e, f;
 
    init( c, d, e, f );
    bind( a, b );

    e = iabs( a );
    f = iabs( b );

    c = iquot( e, f );

    d = iprod( c, f );
    d = idif ( e, d );
    d = isprod( d, 2 );

    e = icomp( d, f );
    d = isign( a ) * isign( b );

    if( ( e > 0 )  ||  ( !e  && ( d < 0 ) ) )
    {
        c = isum( c, 1 );
    }

    if( d > 0 )
    {
        return( ineg( c ) );
    }

    return( c );
}
/********************************************* nnrstintq *** END ***/

/*c 
                      getstartvalues( B, n, l, d )

	"get start values"
        static getstartvalues( B, n, l, d )
        matrix B; single n; int *l, *d;
        c = getstartvalues( B, n, l, d );
        getstartvalues computes the start values for the algorithm.
        c = 0 in case of success, c = 1 otherwise.
c*/

static getstartvalues( B, n, l, d )
matrix B;
single n;
int *l, *d;
{
    single i, j, p;
    int    h;
    vec    b, *c;
    matrix M;

    bind( B );
    init( b, h, M );

    if( ( c = ( vec * ) malloc( n * sizeof( vec ) ) ) == NULL )
    {
        return( 1 );
    }

    i = n - 1;

    init( c[0..i] );

    d[0] = 1;

    M = B;
    i = 1;
    p = -1;

    while( M != _0 )
    {
        b = lfirst( M );
        c[i - 1] = b;

        for( j = 1; j < i; j++ )
        {
            l[p + j] = vecisprod( b, c[j - 1] );
            h        = ineg( l[p + j] );
            c[i - 1] = vecilc( d[j], h, c[i - 1], c[j - 1] );
            c[i - 1] = veciquot( c[i - 1], d[j - 1] );
        }
        h    = vecisquare( c[i - 1] );
        d[i] = iquot( h, d[i - 1] );

        M = lred( M );
        p += i;
        p--;
        i++;
    }

    free( c );

    return( 0 );
}
/**************************************** getstartvalues *** END ***/
