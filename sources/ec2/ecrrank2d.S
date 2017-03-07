/*M
.SH NAME
ecrrank2d - curve over the rational numbers, rank via 2-descent

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrrank2d(E)
list E;

.SH DESCRIPTION
ecrrank2d() returns the rank of E/Q 
which is computed using the method of
2-descent via the 2-isogeny induced by the 2-torsion
or ERROR in case an error occurs.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH REFERENCES
J.E. Cremona, "Algorithms for modular elliptic curves", Cambridge University Press (1992).

.SH SEE ALSO
ecrinit, ecrrank, ecrrankg2d
M*/
/*H
        Version 1       21.10.1995      Josef Gebel
        Version 2       12.02.1996      Fehler beseitigt. JG
   DATE ecrrank2d     : 951201.960501
H*/

#include <_ec2.h>

/***************************************************************************/
/***                                                                     ***/
/***     C o n s t a n t s                                               ***/
/***                                                                     ***/
/***************************************************************************/

#define _B0 2
#define _B1 4
#define _B2 13

/***************************************************************************/
/***                                                                     ***/
/***     B e g i n n i n g   o f   t h e   s t a t i c    b l o c k      ***/
/***                                                                     ***/
/***************************************************************************/

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
            i = 1 - 2 * ( r % 2 );
            P = list5( i, r, 0, 0, 0 );
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

static list transformpts( a, b, LP )
list LP;
int  a, b;
{
    list     B, F, L, P;
    rat      a2, a4;
    floating h;

    bind( a, b, LP );
    init( B, F, L, P, h, a2, a4 );

    a2 = itor( a );
    a4 = itor( b );
    F = ecrinit( 0, a2, 0, a4, 0 );
    B = ecracbtmin( F );
    L = _0;

    while( LP != _0 )
    {
        P = lfirst( LP );
        LP = lred( LP );
        P = ecrbtp( P, B );
           
        h = eciminnetahe( F, P );

        if( !isineciminpl( F, P, h, L ) )
        {
            leset( P, 2, iabs( lsecond( P ) ) );
            eciminplinsp( P, h, &L );
        }
    }

    return( L );
}

static list makepoint( M, d )
list M;
int  d;
{
    list P;
    int u, v, w;
    init( u, v, w, P );
    bind( M, d );

    u = lfirst ( M );
    v = lsecond( M );
    w = lthird ( M );

    v = iprod( v, u );
    v = iprod( v, d );
    
    u = iprod( u, u );
    u = iprod( u, d );
    
    return( ecipnorm( list3( u, v, w ) ) );
}

static issquare( n )
int n;
{
        bind( n );
    if( isign( n ) >= 0 )
    {
        int m;
        
        init( m );
        /**bind( n ); **/
   
        m = isqrt( n );
        m = iprod( m, m );

        if( !idif( m, n ) )
        {
            return( 1 );
        }
    }
    return( 0 );
}

static list getspezeq( E )
list E;
{
    int a, b, c, s2, s4, s6;
    list L, P;
    floating f;

    init( a, b, c, s2, s4, s6 );
    init( L, P );
    init( f );

    bind( E );

    if( !ecimina1( E ) && !ecimina3( E ) )
    {
        s2 = ecimina2( E );
        s4 = ecimina4( E );
        s6 = ecimina6( E );
    }
    else
    {
        s2 = eciminb2( E );
        s4 = eciminb4( E );
        s4 = isprod( s4, 8 );
        s6 = eciminb6( E );
        s6 = isprod( s6, 16 );
    }

    P = list5( 3, 1, s2, s4, s6 );
 
    udprf( 1, P, 1, &L );
    P = lfirst( L );
 
    a = 0;
    while( P != _0 )
    {
        f = lfirst( P );
        P = lred( P );
        c = flround( f );
        b = isum ( c, s2 );
        b = iprod( b, c  );
        b = isum ( b, s4 );
        b = iprod( b, c  );
        b = isum ( b, s6 );
        if( !b )
        {
            a = 1;
            P = _0;
        }
    }

    if( a )
    {
        a = isprod( c,  3 );
        a = isum  ( a, s2 );
 
        b = isum ( a, s2 );
        b = iprod( b,  c );
        b = isum ( b, s4 );

        P = list2( a, b );
    }

    return( P );
}
    

static p_adic_sq( a, p, l )
int a, p;
single l;
{
        bind( a, p );
    if( a )
    {
        /*bind( a, p ); **/

        if( l % 2 )
        {
            return( 0 );
        }
        
        while( l-- )
        {
            a = iquot( a, p );
        }

        if( p == 2 )
        {
            if( mshom( 8, a ) != 1 )
            {
                return( 0 );
            }
        }
        else
        {
            if( ijacsym( a, p ) != 1 )
            {
                return( 0 );
            }
        }
    }
    return( 1 );
}

static ordp( p, a )
int p, a;
{
        bind( a, p );
    if( a )
    {
        int    q, r;
        single e;

        /**bind( a, p ); **/
        init( q, r );
        e = 0;
        q = a;

        while( 1 )
        {
            iqrem( q, p, &q, &r );
            if( r )
            {
                return( e );
            }
            e++;
        }
    }
    return( 1<<28 );
}
        
static isnotinsfdl( b, M ) 
int b;
list M;
{
    int k, n;
    list L;

    init( k, n, L );
    bind( b, M );

    if( ( b != 1 ) && issquare( b ) )
    {
        return( 0 );
    }

    L = M;

    while( L != _0 )
    {
        k = lfirst( L );
        if( !idif( k, b ) )
        {
            return( 0 );
        }

        L = lred( L );
    }
    return( 1 );
}

static list squarefreediv( L, S )
list L, S;
{
    int  p, q;
    list T;
 
    init( T, p, q );
    bind( L, S );

    if( L == _0 )
    {
        return( S );
    }

    p = lfirst( L );
    T = S;

    while( T != _0 )
    {
        q = lfirst( T );
        T = lred( T );
        q = iprod( q, p );
        S = lcomp( q, S );
    }

    return( squarefreediv( lred( L ), S ) );
}

static Zp_soluble( a, b, c, d, e, p, x, n )
int a, b, c, d, e, p, x;
single n;
{
    single i, l, m;
    int    g, h;

    init( g, h );

    bind( a, b, c, d, e, x, p );

    /***   Lemma 6 (p != 2) or Lemma 7 (p == 2) from B-SD paper   ***/
    g = iprod( a, x );
    g = isum ( g, b );
    g = iprod( g, x );
    g = isum ( g, c );
    g = iprod( g, x );
    g = isum ( g, d );
    g = iprod( g, x );
    g = isum ( g, e );

    l = ordp( p, g );
    if( p_adic_sq( g, p, l ) )
    {
        return( 1 );
    }
    
    h = iprod( x, isprod( a, 4 ) );
    h = isum ( h, isprod( b, 3 ) );
    h = iprod( h, x );
    h = isum ( h, isprod( c, 2 ) );
    h = iprod( h, x );
    h = isum ( h, d );

    m = ordp( p, h );

    if( p == 2 )
    {
        if( n > m )
        {
            int go;
            init( go );
    
            go = sexp( 2, l );
            go = iquot( g, go );
            go = mshom( 4, go );
 
            if( ( l >= m + n ) 
            ||  ( ( l == m + n - 1 ) && !( l % 2 ) )
            ||  ( ( l == m + n - 2 ) && ( go == 1 ) ) )
            {
                return( 1 );
            }
            return( 0 );
        }
        else if( ( l < 2 * n ) && ( l != 2 * n - 2 ) )
        {
            return( 0 );
        }
    }
    else
    {
        if( n > m )
        {
            if( l >= m + n )
            {
                return( 1 );
            }
            return( 0 );
        }
        else 
        {
            if( l < 2 * n ) 
            {
                return( 0 );
            }
        }
    }

    g = iexp( p, n );

    for( i = 0; i < p; i++, x = isum( x, g ) )
    {
        if( Zp_soluble( a, b, c, d, e, p, x, n + 1 ) )
        {
            return( 1 );
        }
    }
    return( 0 );
}
    
static Qp_soluble( a, b, c, d, e, p )
int a, b, c, d, e, p;
{
    bind( a, b, c, d, e, p );

    if( Zp_soluble( a, b, c, d, e, p, 0, 0 ) )
    {
        return( 1 );
    }
    if( Zp_soluble( e, d, c, b, a, p, 0, 1 ) )
    {
        return( 1 );
    }
    return( 0 );
}

/*************************************************************************/
/***                                                                   ***/
/***                  "everywhere locally soluble?"                    ***/
/***   static everywhere_l_s( a, b, c, B ) int a, b, c; list B;        ***/
/***                                                                   ***/
/***   everywhere_l_s( a, b, c, B ) tests if the quartic equation      ***/
/***       g: y^2 = a * x^4 + b * x^2 + c                              ***/
/***   is soluble in all p-adic fields Q_p for all rational primes p.  ***/
/***   B is a list of primes p1, ...,pr and g is knowm to be locally   ***/
/***   soluble in Q_p for all p outside of B, i.e. p != p1,..., pr.    ***/
/***   Thus local solubility has only to be tested for all p in B.     ***/
/***   Return:  p, if g is not locally soluble in Q_p (first p in B    ***/
/***               with this property)                                 ***/
/***            0, if g is everywhere locally soluble                  ***/
/***                                                                   ***/
/*************************************************************************/

static everywhere_l_s( a, b, c, B )
int a, b, c;
list B;
{
    int  p;
    init( p );
    bind( a, b, c, B );

    while( B != _0 )
    {
        p = lfirst( B );
        B = lred( B );
   
        if( !Qp_soluble( a, 0, b, 0, c, p ) )
        {
            return( p );
        }
    }
    return( 0 );
}

static real_soluble( a, b, c )
int a, b, c;
{
    bind( a, b, c );

    if( ( isign( a ) < 0 ) && ( isign( c ) < 0 ) )
    {
        int  D;

        init( D );

        D = iprod( a, c );
        D = isprod( D, 4 );
        D = idif( iprod( b, b), D );
    
        if( isign( D ) < 0 )
        {
            return( 0 );
        }
        else 
        {
            floating f;
            
            init( f );

            f = flsqrt( itofl( D ) );
            f = fldif( itofl( b ), f );
            if( flsign( f ) < 0 )
            {
                return( 0 );
            }
        }
    }
    return( 1 );
}
    

static isdivinlist( d, P ) 
single d;
list P;
{
    bind( P );

    while( P != _0 )
    {
        if( !( d - lfirst( P ) ) )
        {
            return( 1 );
        }
        P = lred( P );
    }
    return( 0 );
}

static list count( a, b, B, LP )
int a, b;
list B, *LP;
{
    single n1, n2, p;
    int    c, d, b1;
    list   L, M, P, H;
    floating f, B0, B1, B2;

    init( c, d, b1 );
    init( f, B0, B1, B2 );
    init( L, M, P, H );
    bind( a, b, B, *LP );

    n1 = 0;
    n2 = 0;
    b1 = iprod( a, a );
    b1 = idif( b1, isprod( b, 4 ) );

    B0 = itofl( _B0 );
    B1 = itofl( _B1 );
    if( _H_BOUND > 0.0 )
    {
        if( _H_BOUND > _B2 * 1.0 )
        {
            B2 = Cfltofl( _H_BOUND );
        }
        else
        {
            B2 = itofl( _B2 );
        }
    /**    B2 = fldif( B2, itofl( 4 ) ); geaendert 23.3.**/
    }
    else
    {
       /** B2 = itofl( 14 );  geaendert 23.3.**/
        B2 = itofl( 18 ); /** geaendert 23.3. **/
    }
    B2 = fldif( B2, itofl( 4 ) ); /** geaendert 23.3. **/

    M = list1( -1 );
    if( ( c = iabs( b ) ) != 1 )
    {
        L = ifel( ifact( iabs( b ) ) );
        while( L != _0 )
        {
            d = lfirst( L );
            M = lcomp( d, M );
            L = lred2( L );
        }
    }
    H = M;
    P = squarefreediv( M, list1( 1 ) );
    M = _0;
    L = _0;
    while( P != _0 )
    {
        d = lfirst( P );
        if( !isdivinlist( d, H ) )
        {
            M = lcomp( d, M );
        }
        P = lred( P );
    }

    L = lconc( H, M );

    while( L != _0 )
    {
        d = lfirst( L );
        L = lred( L );
        c = iquot( b, d );

        if( issquare( c ) || issquare( d ) )
        { 
            n1++;
            n2++;
        }    
        else if( real_soluble( d, a, c ) )
        {
            M = ecrsolve2c( d, 0, a, 0, c, 0, B1, 0, B1 );

            if( llength( M ) == 3 )
            { 
                P = makepoint( M, d );
                *LP = lcomp( P, *LP );

                n1++;
                n2++;
            }
            else if( !( p = everywhere_l_s( d, a, c, B ) ) )
            { 
                n2++;
                f = B1;

                while( 1 )
                {
                    f = flsum( f, B0 );

                    if( flcomp( f, B2 ) > 0 )
                    {
                        f = B2;
                    }
                    
                    M = ecrsolve2c( d, 0, a, 0, c, 0, f, 0, f );
    
                    if( llength( M ) == 3 )
                    { 
                        P = makepoint( M, d );
                        *LP = lcomp( P, *LP );
                        n1++;
                        break;
                    }
                    else if( flcomp( f, B2 ) >= 0 )
                    {
                        break;
                    }
                }
            }
        }
    }

    return( list2( n1, n2 ) );
}
 
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

/***************************************************************************/
/***                                                                     ***/
/***           E n d   o f   t h e   s t a t i c    b l o c k            ***/
/***                                                                     ***/
/***************************************************************************/

single ecrrank2d( E )
list E;
{
    bind( E );

    if( ecrordtor( E ) % 2 )
    {
        /***    No torsion point with order 2   ***/
        /***    Project: Call 2-covering algorithm developed by Cremona ***/
        return( ERROR );
    }
    else if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == ERROR ) )
    {
        /***   rank is not yet computed    ***/
        single r, e1, e2, f1, f2, n1, n2, m1, m2;
        int a, b, c, d, a1, b1;
        list L, B, P, LP, LQ;
     
        init( a, b, c, d, a1, b1 );
        init( L, B, P, LP, LQ );

        if( ( L = getspezeq( E ) ) == _0 )
        {
            return( ERROR );
        }

        a = lfirst ( L );
        b = lsecond( L );

        a1 = isprod( a, -2 );
        b1 = iprod( a, a );
        b1 = idif ( b1, isprod( b, 4 ) );

        if( !iprod( b, b1 ) )
        {
            return( ERROR );
        }

        /***    Minimal equation for E is  not in the form  ***/
        /***       E: y^2 = x^3 + a * x^2 + b * x           ***/
        /***    Transform equation for E into this form     ***/

        c = iprod( b, b1 );
        c = isprod( c, 2 );
        c = iabs( c );

        L = ifel( ifact( c ) );
        B = _0;

        while( L != _0 )
        {
            c = lfirst( L );
            L = lred2( L );
            B = lcomp( c, B );
        }
    
        LP = _0;
        L = count( a, b, B, &LP );

        n1 = lfirst ( L );
        n2 = lsecond( L );
        e1 = slog2( n1 ) - 1;
        e2 = slog2( n2 ) - 1;
    
        LQ = _0;
        L = count( a1, b1, B, &LQ );

        m1 = lfirst ( L );
        m2 = lsecond( L );
        f1 = slog2( m1 ) - 1;
        f2 = slog2( m2 ) - 1;
    
        while( LQ != _0 )
        {
            P = lfirst( LQ );
            LQ = lred( LQ );

            if( lfirst( P ) && lsecond( P ) )
            { 
                rat x, y, z;

                init( x, y, z );

                c = lthird( P );
                d = iprod( c, c );
                x = rcons( lfirst( P ), d );

                x = rprod( x, x );
                y = itor ( b1 );
                y = rdif ( x, y );
                y = rquot( y, x );

                d = iprod( d, c );
                z = rcons( lsecond( P ), d );

                y = rprod( y, z );
               
                z = rprod( z, z );
                x = rquot( z, x );

                c = rden( x );
                d = rden( y );
                c = iquot( d, c );
                c = iprod( c, 2 );
                a1 = rnum( x );
                d = rnum( y );

                P = ecipnorm( list3( a1, d, c ) );
    
                LP = lcomp( P, LP );
            }
        }

        if( n2 - sexp( 2, e2 ) )
        {
            /***   n2 is not a power of 2  ==>  ERROR  ***/
            return( ERROR );
        }

        if( m2 - sexp( 2, f2 ) )
        {
            /***   m2 is not a power of 2  ==>  ERROR  ***/
            return( ERROR );
        }

        n2 /= n1;
        m2 /= m1;

        r = e1 + f1 - 2;
        n1 = e2 + f2 - 2;
        m2 = n1 - r;
        n2 = sexp( 2, m2 );

        if( m2 % 2  )
        {
            /***    #III[2] = #Sel[2] / 2^r = 2 ==> rank is r + 1   ***/
            /***    one 2-covering that comes from a generator of   ***/
            /***    of the Selmer group Sel[2] was classidied as    ***/
            /***    everywhere locally but not globally soluble.    ***/
            /***    In fact it is globally soluble with a (very)    ***/
            /***    large solution not found in the search.         ***/

            r++;
            if( r % 2 )
            {
                m1 = -1;
            }
            else
            {
                m1 = 1;
            }

            L = lfourth( E );
            if( m2 == 1 )
            {
                n2 /= 2;
            }
            else
            {
                r = ERROR;
                n2 = 0;
            }
            P = list5( m1, r, 0, 0, n2 );
            leset( L, 4, P );
            leset( E, 4, L );
             
            return( r );   
        }

        L = transformpts( a, b, LP );

        if( make_basis( E, L, r ) == ERROR )
        {
            return( ERROR );
        }

        if( n2 - 1 )
        {
            r  = sha_test( E, r );
        }

        return( r );   
    }

    return( lsecond( lfourth( lfourth( E ) ) ) );
}
