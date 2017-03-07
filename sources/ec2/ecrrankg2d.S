/*M
.SH NAME
ecrrankg2d - curve over the rational numbers, rank via general 2-descent

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrrankg2d(E)
list E;

.SH DESCRIPTION
ecrrankg2d() returns the rank r of E/Q 
which is computed using the method of general 2-descent.
If the rank r is already contained in E, it will be returned;
otherwise it will be entered at the correct position in E.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.


.SH NOTE
If the value of the global variable _H_BOUND is zero, the limit
for any point search  on the quartics using ecrsolve2c() is 
automatically bounded by 11.
This is necessary to avoid a 'never ending' search on quartics 
that are everywhere locally but not globally soluble. Such
quartics occur if (and only if) the 2-part III[2] of the 
Tate-Shafarevic group is non-trivial. In these cases the function 
ecrrankbsd() might yield the order of III.
If, however, the bound for the sieving has to be larger than 11,
the global variable _H_BOUND must be set to the desired value.


.SH REFERENCES
J.E. Cremona, "Algorithms for modular elliptic curves", Cambridge University Press (1992).

.SH SEE ALSO
ecrinit, ecrrank, ecrrank2d,  ecrsolve2c, ecrrankbsd
M*/
#include <_ec2.h>

#define _B0 2    /***   Increment for bound in point search                ***/
#define _B1 7    /***   Initial bound for point search                     ***/
#define _B2 11   /***   Maximal bound for point search (see docu above)    ***/
#define UBQEC 2  /***   Upper bound for quartics from 1 equivalence class  ***/

/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                     BEGINNING of the static part                       **/
/**                                                                        **/
/**   static functions: single is_square( a ) single a;                    **/
/**                     single sha_test( E, r ) list E; single r;          **/
/**                     list optimize_basis( E, R, B, r )                  **/
/**                                   list E, B; floating R; single r;     **/
/**                     make_basis( E, L, r ) list E, L; single r;         **/
/**                     list mk_point( M, a, b, c, d, e )                  **/
/**                                   list M; single a, b, c, d, e;        **/
/**                     list mk_point_s( a, b, c, d, e, f )                **/
/**                                   int  a, b, c, d, e, f;               **/
/**                                                                        **/
/****************************************************************************/
/****************************************************************************/

/****************************************************************************/
/**   static is_square( a )   single a;                                    **/
/**   Return value: b in |N if b * b = a, -1 otherwise.                    **/
/****************************************************************************/

static is_square( a )
single a;
{
    single b, c;

    if( a <= 0 )
    {
        return( -1 );
    }
    b = ssqrt( a );
    c = b * b;
    if( c - a )
    {
        return( -1 );
    }
    return( b );
}

/****************************************************************************/
/**   static sha_test( E, r ) list E; single r;                            **/
/**   E elliptic curve list, r (conjectured) rank of E/Q.                  **/
/**   Return: r = rank, if r fits into BSD-conjecture                      **/
/**           ERROR otherwise.                                             **/
/****************************************************************************/

static sha_test( E, r )
list E;
single r;
{
    single   s, t;
    floating R, L, h;
    list     M, P;

    init( R, L, h );
    init( M, P );
    bind( E );

    R = ecrregulator( E );
    h = ecrrperiod( E );
    R = flprod( R, h );
    t = ecrprodcp( E );
    t *= ifactl( r );

    if( isign( ecimindisc( E ) ) > 0 )
    {
        t *= 2;
    }
    R = flprod( R, itofl( t ) );

    t = ecrordtor( E );
    t = t * t;
    R = flsquot( R, t );

    if( !r )
    {
        L = ecrlser( E );
    }
    else
    {
        if( r == 1 )
        {
            int N;
            init( N );

            N = ecrcond( E );

            if( icomp( N, 1000000 ) < 0 )
            {
                L = ecrlserfd( E );
            }
            else
            {
                L = ecrlserhd( E, 1 );
            }
        }
        else
        {
            L = ecrlserhd( E, r );
        }
    }

    M = lfourth( E );
    P = lfourth( M );

    if( L )
    {
        R = flquot( L, R );
        t = flround( R );
        s = isqrt( t );
        s = s * s;

        if( t == s )
        {
            leset( P, 2, r );
            leset( P, 3, L );
            leset( P, 5, s );
            leset( M, 4, P );
            leset( E, 4, M );
            return( r );
        }
    }

    leset( P, 2, ERROR );
    leset( P, 5, 0 );
    leset( M, 4, P );
    leset( E, 4, M );
    return( ERROR );
}

/****************************************************************************/
/**   static list optimize_basis( E, R, B, r )                             **/
/**          list E, B; floating R; single r;                              **/
/**   E elliptic curve list, R regulator, B basis, r rank of E/Q.          **/
/**   Return: basis B' such that all basis points have minimal height.     **/
/****************************************************************************/

static list optimize_basis( E, R, B, r )
list E, B;
floating R;
single r;
{
        bind( E, R, B );
    if( r )
    {
        single   n;
        list     L, N, M, P;
        floating f, h;

        init( L, N, M, P );
        init( f, h );

        /**bind( E, R, B ); **/

        L = B;

        while( L != _0 )
        {
            f = lsecond( L );
            L = lred2( L );
        }

        f = flsum( f, ecisnfdwhnth( E ) );
        if( _H_BOUND && ( flcomp( f, Cfltofl( _H_BOUND ) ) > 0 ) )
        {
            f = Cfltofl( _H_BOUND );
        }
        L = lcopy( B );
        h = 0;
        ecisnfpbwh( E, &L, &h, f, 2, 0, &L );

        N = _0;
        n = 0;

        while( L != _0 )
        {
            P = lfirst( L );
            f = lsecond( L );
            L = lred2( L );
            M = lcomp2( f, P, N );
            M = lcinv( M );

            if( !iseciminlpld( E, M, 1, &h ) )
            {
                n++; 
                N = lcomp2( f, P, N );
                if( n == r )
                {
                    f = flsum( R, R );
                    if( flcomp( f, h ) > 0 )
                    {
                        return( M );
                    }
                    return( B );
                }
            }
        }
    }
    return( B );
}

/****************************************************************************/
/**   static make_basis( E, L, r ) list E, L; single r;                    **/
/**   E elliptic curve list, L list of points on E, r rank of E/Q.         **/
/**   Return: 0, if the list L contained r linearly independent points     **/
/**              (basis B cmputed and entered into list E)                 **/
/**           ERROR, if L contained less than r linearly indep. points     **/
/****************************************************************************/

static make_basis( E, L, r )
list E, L;
single r;
{
    single i;
    list B, P, M;
    floating R, f;

    init( B, P, M, R, f );

    bind( E, L );

    B = _0;
    M = L;

    i = 0;
    R = itofl( 1 );

    while( i < r )
    {
        if( M == _0 )
        {
            M = lfourth( E );
            P = lfourth( M );
            P = list5( 1 - 2 * ( r % 2 ), ERROR, 0, 0, 0 );
            leset( M, 4, P );
            leset( E, 4, M );
            return( ERROR );
        }
        i++;

        P = lfirst ( M );
        f = lsecond( M );
        M = lred2( M );

        B = lcomp2( P, f, B );

        if( iseciminlpld( E, B, 1, &R ) )
        {
            /***   Points in list B are linearly dependent ==> no basis ***/
            i--;
            B = lred2( B );
        }
    }

    i = 1;
    if( r % 2 )
    {
        i = -1;
    }

    M = B;
    B = _0;
    while( M != _0 )
    {
        P = lfirst ( M );
        f = lsecond( M );
        M = lred2( M );
        B = lcomp2( P, f, B );
    }
    B = optimize_basis( E, R, B, r );

    M = lfourth( E );
    P = lfourth( M );
    P = list5( i, r, 0, R, 0 );
    leset( M, 4, P );
    leset( E, 4, M );

    if( !R )
    {
        return( ERROR );
    }

    M = lsecond( E );
    leset( M, 7, B );
    leset( E, 2, M );

    return( 0 );
}

/****************************************************************************/
/**   static list mk_point( E, M, a, b, c, d, e )                          **/
/**          list E, M;   int a, b, c, d, e;                               **/
/**   E is an elliptic curve. Y^2 = g(X) = a X^4 + b X^3 + c X^2 + d X + e **/
/**   is a 2-covering of E/Q and M = ( x  y  z ) int x, y, z; where        **/
/**   Y = y/z^2 and X = x/z is a solution of Y^2 = g(X).                   **/
/**   mk_point computes the point P on E/Q that is related to ( X, Y ).    **/
/****************************************************************************/

static list mk_point( M, a, b, c, d, e )
list M;
single a, b, c, d, e;
{
    int x, y, z, bb, cc, dd, zz;

    static list mk_point_s();

    init( x, y, z, bb, cc, dd, zz );
    bind( M );

    x = lfirst ( M );
    y = lsecond( M );
    z = lthird ( M );

    zz = iprod( z, z );

    dd = iprod (  a,  x );
    dd = isprod( dd,  4 );
    bb = iprod (  b,  z );
    bb = isprod( bb,  3 );
    dd = isum  ( dd, bb );
    dd = iprod ( dd,  x );
    bb = iprod (  c, zz );
    bb = isprod( bb,  2 );
    dd = isum  ( dd, bb );
    dd = iprod ( dd,  x );
    bb = iprod (  d, zz );
    bb = iprod ( bb,  z );
    dd = isum  ( dd, bb );
    dd = iprod ( dd,  z );

    cc = iprod (  c, zz );
    bb = iprod (  b,  x );
    bb = iprod ( bb,  z );
    bb = isprod( bb,  3 );
    cc = isum  ( cc, bb );
    bb = iprod (  a,  x );
    bb = iprod ( bb,  x );
    bb = isprod( bb,  6 );
    cc = isum  ( cc, bb );
    cc = iprod ( cc, zz );

    zz = iprod ( zz, z );

    bb = iprod (  a, x );
    bb = isprod( bb, 4 );
    bb = isum  ( bb, iprod( b, z ) );
    bb = iprod ( bb, zz );

    zz = iprod( zz, z );

    zz = iprod( a, zz );
    x  = iprod( y, y );

    return( mk_point_s( zz, bb, cc, dd, x, y ) );
}

/****************************************************************************/
/**   static list mk_point_s( a, b, c, d, e, f )                           **/
/**                       int a, b, c, d, e, f;                            **/
/**   subroutine for mk_point.                                             **/
/****************************************************************************/

static list mk_point_s( a, b, c, d, e, f )
int  a, b, c, d, e, f;
{
    int  a1, a2, a3, a4, a6;
    rat  A1, A2, A3, A4, A6;
    list B, F, P;

    init( a1, a2, a3, a4, a6 );
    init( A1, A2, A3, A4, A6 );
    init( B, F, P );
    bind( a, b, c, d, e, f );

    a2 = iprod (  f,  f );
    a2 = isprod( a2,  4 );

    a3 = iprod( a2, a2 );

    a4 = iprod( a2, a3 );
    a4 = ineg( iprod( a, a4 ) );

    a3 = iprod( a3,  b );

    a2 = iprod( a2,  c );
    a1 = iprod(  d,  d );
    a2 = idif ( a2, a1 );

    a1 = isprod( d, 2 );

    a6 = iprod( a2, a4 );

    A1 = itor( a1 );
    A2 = itor( a2 );
    A3 = itor( a3 );
    A4 = itor( a4 );
    A6 = itor( a6 );

    F = ecrinit( A1, A2, A3, A4, A6 );
    B = ecracbtmin( F );
    P = list3( ineg( a2 ), 0, 1 );
    P = ecrbtp( P, B );
    B = eciminneg( F, P );
    a1 = lsecond( P );
    a2 = lsecond( B );
    if( icomp( a2, a1 ) > 0 )
    {
        return( B );
    }
    return( P );
}

/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                        END of the static part                          **/
/**                                                                        **/
/****************************************************************************/
/****************************************************************************/

single ecrrankg2d( E )
list E;
{
    bind( E );

    if( ( lfourth( lfourth( E ) ) == _0 ) 
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == ERROR ) )
    {
        /***    the rank r has not yet been computed   ***/
        single   n, m, r;
        int      a, b, c, d, e, I, J, D, D1;
        list     B, L, M, P, Q;
        floating h, B0, B1, B2;

        init( a, b, c, d, e, I, J, D, D1 );
        init( B, L, M, P, Q );
        init( h, B0, B1, B2 );

        /***   Setting of the bounds for point search   ***/
        /***   (depending on the value of _H_BOUND).    ***/
        B0 = itofl( _B0 );
        B1 = itofl( _B1 );
        B2 = itofl( _B2 );
        if( _H_BOUND > 0.0 )
        {
            B2 = Cfltofl( _H_BOUND );
        }
        if( flcomp( B0, B2 ) > 0 )
        {
            B0 = B2;
            B1 = B2;
        }
        else if( flcomp( B1, B2 ) > 0 )
        {
            B1 = B2;
        }

        Q = ecrg2dhomsp( E );

        /**********************************************************************/
        /**   Q contains all non-trivial and everywhere locally              **/
        /***  soluble quartics (homogeneous spaces)                          **/
        /**      g:  y^2  =  a * x^4  +  b * x^3  + c * x^2  + d * x  +  e   **/
        /**   with a, b, c in the fundamental range. Q contains at least     **/
        /**   one representative from each class of the 2-part Sel[2]        **/
        /**   of the Selmer group.                                           **/
        /**********************************************************************/

        m = 1;    /***   m is counter for equivalence classes that    ***/
                  /***   are everywhere locally soluble: m = #Sel[2]  ***/
                  /***   initialization: m = 1 (trivial class)        ***/
        n = 1;    /***   n is counter for equivalence classes that    ***/
                  /***   are globally soluble: log2( n ) = r          ***/
                  /***   initialization: n = 1 (trivial class)        ***/
        B = _0;   /***   B is a list to store all global solutions    ***/
                  /***   of the non-trivial classes (points on E/Q).  ***/

        while( Q != _0 )
        {
            L = lfirst( Q );
            m++;    /***   another equivalence class                 ***/
            r = 0;  /***   r counts how many quartics from one       ***/
                    /***   equivalence class could not be solved     ***/
                    /***   r >= UBQEC ==> (assumed)                  ***/
                    /***   either class is not globally soluble      ***/
                    /***   or solution is 'large'.                   ***/
            while( ( L != _0 ) && ( r < UBQEC ) )
            {
                r++;
                M = lfirst( lfirst( L ) );
                L = lred( L );
                a = lfirst ( M );
                M = lred( M );
                b = lfirst ( M );
                M = lred( M );
                c = lfirst ( M );
                M = lred( M );
                d = lfirst ( M );
                M = lred( M );
                e = lfirst ( M );

                P = 0;
                
                if( ( D1 = is_square( a ) ) > 0 )
                {
                    /***   a is a square: solution can    ***/
                    /***   be determined immedeately      ***/
                    P = mk_point_s( e, d, c, b, a, D1 );
                }
                else if( ( D1 = is_square( e ) ) > 0 )
                {
                    /***   e is a square: solution can    ***/
                    /***   be determined immedeately      ***/
                    P = mk_point_s( a, b, c, d, e, D1 );
                }
                else 
                {
                    /***   Neither a nor e are squares:      ***/
                    /***   Find solution with point search   ***/
                    floating l;
                    init( l );

                    l = 0;
                    h = fldif( B1, B0 );

                    do
                    {
                        h = flsum( h, B0 );
                        if( flcomp( h, B2 ) > 0 )
                        {
                            h = B2;
                        }
                        /***   At this point: search already     ***/
                        /***   done for (x,z) in [0,l] x [0,l]   ***/
                        /***   (start with l = 0)                ***/
                        /***   Extend search to interval         ***/
                        /***   [0,h] x [0,h]                     ***/
                        /***     = [0,l] x [0,l] (already done)  ***/
                        /***     U [l,h] x [0,h] (1st search)    ***/
                        /***     U [0,l] x [l,h] (2nd search)    ***/

                        /***   1st search: (x,z) in [l,h] x [0,h]  ***/
                        M = ecrsolve2c( a, b, c, d, e, l, h, 0, h );
                        if( l && ( llength( M ) != 3 ) )
                        {
                            /***   2nd search: (x,z) in [0,l] x [l,h]  ***/
                            M = ecrsolve2c( a, b, c, d, e, 0, l, l, h );
                        }
                        if( llength( M ) == 3 )
                        {
                            /***   Point search successful  ***/
                            h = B2;
                            P = mk_point( M, a, b, c, d, e );
                        }
                        l = h;
                    }
                    while( flcomp( h, B2 ) < 0 );
                }

                if( P ) 
                {
                    /***   Global solution found: enter P into B   ***/
                    n++;
                    if( h = eciminnetahe( E, P ) )
                    {
                        /**   P is no torsion point  **/
                        eciminplinsp( P, h, &B );

                    }
                    L = _0;
                }
            }
            Q = lred( Q );
        }

        /***   m = #Sel[2] is a power of 2. If mot: ERROR   ***/
        e = slog2( m ) - 1;
        a = sexp( 2, e );
        if( m - a )
        {
            /***   Sel[2] is not a power of 2 ==> ERROR ***/
            return( ERROR );
        }

        /***   We have:   #Sel[2]  =  2^r  *  2^t2  *  #III[2]   ***/
        /***   where t2 = 2-order of the torsion group and       ***/
        /***   #III[2] = 2-order of the Tate Shafareivc group    ***/
        /***   #III[2] is a (conjectured) square                 ***/
        /***   We know r (if computation was correct) and t2.    ***/
        /***   Test, whether                                     ***/
        /***       #III[2] = #Sel[2] / 2^( r + t2 )              ***/
        /***   is a square or not.                               ***/

        /***   r = 2^n.                                         ***/
        /***   If n is not a power of 2, then (at least) one    ***/
        /***   globally soluble equivalence class could not     ***/
        /***   be solved (solution too large for our search).   ***/
        r = slog2( n ) - 1;
        if( ( e - r ) % 2 )
        {
            /***   #III[2] = Sel[2] / 2^(r+t2) is not a square      ***/
            /***   ==> (At least) one class with 'large' solution   ***/
            r++;
            n = sexp( 2, r );
        }

        a = ecrordtor( E );
        if( ( a % 2 ) == 0 )
        {
            /***    The order of torsion group is even: t2 >= 1.   ***/
            /***    Divide out the 2-rank t2 of the torsion group  ***/
            /***    E(Q) / 2 E(Q) >= Z^r x Z/2Z <= (Z/2Z)^(r+1)    ***/
            r--;
            e--;
            n /= 2;
            m /= 2;
            if( ( ( a % 4 ) == 0 ) && ( llength( ecrstrtor( E ) ) == 2 ) )
            {
                /***   The torsion group is Z/(2*k)Z x Z/2Z     ***/
                /***   E(Q) / 2 E(Q) = (Z/2Z)^r x Z/2Z x Z/2Z   ***/
                /***                 = (Z/2Z)^(r + 2 )          ***/
                r--;
                e--;
                n /= 2;
                m /= 2;
            }
        }
    
        if( m > n )
        {
            /***   #Sel[2] > 2^( r + t2 ) ==> #III[2] = 2^d > 1  ***/
            a = m / n;
            b = n;
            d = 0;
            while( a >= 4 )
            {
                a /= 4;
                b *= 4;
                d += 2;
            }

            if( m != b )
            {
                /***   Sel[2] != 2^( r + t2 ) * III[2]     ***/
                /***   least) one generator is too large)  ***/

                if( e % 4 )
                {
                    /***   Sel[2] / 2^(t2) is not a square ==>  ***/
                    /***   rank r must be odd ==> sign C = -1   ***/
                    a = -1;
                }
                else
                {
                    /***   Sel[2] / 2^(t2) is a square  ==>      ***/
                    /***   rank r must be even ==> sign C = -1   ***/
                    a = 1;
                }
                if( 4 * ( r + 2 ) > m )
                {
                    /***   2^r < Sel[2] / 2^(t2) < 2^(r+2) ==>  ***/
                    /***   rank must be r = log2(Sel[2]) - t2   ***/
                    r = slog2( m ) - 1;
                    b = r;
                }
                else
                {
                    /***   2^(r+2) < Sel[2] / 2^(t2)            ***/
                    /***   rank could be r or r+2               ***/
                    b = ERROR;
                }
                if( ( n > r ) && !make_basis( E, B, r ) )
                {
                    return( r );
                }
                r = b;

                M = lfourth( E );
                P = lfourth( M );
                P = list5( a, r, 0, 0, 0 );
                leset( M, 4, P );
                leset( E, 4, M );
                M = lsecond( E );
                leset( M, 7, _0 );
                leset( E, 2, M );

                return( r );
            }
        }

        if( make_basis( E, B, r ) == ERROR )
        {
            return( ERROR );
        }

        if( a >= 4 )
        {
            if( ( r = sha_test( E, r ) ) == ERROR )
            {
                return( ERROR );
            }
        }
    }
    return( lsecond( lfourth( lfourth( E ) ) ) );
}
