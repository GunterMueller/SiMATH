/*M
.SH NAME
ecisnfsaip - curve with integer coefficients, short normal form, search for all integral points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecisnfsaip(E)
list E;

.SH DESCRIPTION
ecisnfsaip() returns the list
L=(P1  L1  ...  Pk  Lk); list P1, L1, ..., Pk, Lk;
of all integral points P1, ..., Pk on the short model of E/Q
together with their linear combination with respect to the torsion 
group and the basis contained in the list E.
If an error occurs, the list (0) will be returned.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH EXAMPLE
The linear combinations Li might be of the form
.PP
.nf
L1 = ( 0 1  2 ): P1 =  O + 1 * B1 + 2 * B2
L2 = ( 1 0 -1 ): P2 = T1 - 1 * B2
.fi
.PP
where ( T0 = O, T1, ..., Tt ) is the torsion subgroup,
rank(E/Q) = 2 and ( B1, B2 ) is the basis of the short model 
contained in the list E.

.SH NOTE
ecisnfsaip() uses the global double variable _H_BOUND
to limit the height in the search for points in ecisnfpbwh().
For the default value _H_BOUND=0.0 the search is not limited.
For most applications _H_BOUND=11.0 is sufficient.

.SH REFERENCES
J. Gebel, A. Pethoe and H. G. Zimmer,
"Computing Integral Points on Elliptic Curves",
Acta arithmetica (to appear)

.SH SEE ALSO
ecrinit, ecisnfpbwh
M*/
/*H
	Version 1       22.02.1994      Josef Gebel
	Version 2	21.11.1994	ECIMINMWGBASE -> ECIMINBMWG. MP
	Version 3	07.12.1996	Replacemant of the constant ETA by 
                                        a smaller value;
   DATE ecisnfsaip    : 930531.951201
H*/

#include <_ec2.h> 

#define EPSILON 0.000000001
#define ETA Cfltofl( EPSILON )
#define EPS Cfltofl( 0.1 )

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

/*c
               is_inlist( E, PL, M ) 

        static is_inlist( E, PL, M ) list PL, M;
        s = is_inlist( E, PL, M );
        PL = ( M1  M2  ...  Ms ) list M1, ..., Ms; s >= 0.
        Mi = ( a1  a2 ... ak ) single a1, ..., ak; k > 0;
        Return: s = 1, if M is alredy contained in PL: M = Mj (1 <= j <= s),
                    0  otherwise
c*/             

static is_inlist( E, PL, M )
list E;	/** dazu SS **/
list PL, M;
{
    single i, j, k, t;
    list P, L, N;
 
    init( P, L, N );
    bind( E, PL, M );

    t = ecrordtor( E );

    P = PL;

    while( P != _0 )
    {
        k = 1;
        L = lfirst( P );
        N = M;

        if( t > 1 )
        {
            i = lfirst( N );
            j = lfirst( L );
            L = lred( L );
            N = lred( N );
            if( ( i - j ) && ( i + j - t ) )
            {
                /***   torsion point in L != +/- torsion point in N   ***/
                k = 0;
            }
            else if( !( i + j - t ) )
            {
                while( k && ( N != _0 ) )
                {
                    /***   torsion point in L = - torsion point in N   ***/
                    /***   Check whether M = ( i 0 ... 0 ).            ***/
                    /***   If yes then test if ( -i 0 ... 0 ) is in PL ***/
                    i = lfirst( N );
                    j = lfirst( L );
                    if( i || j )
                    {
                        k = 0;
                    }
                    L = lred( L );
                    N = lred( N );
                }
                if( k )
                {
                    return( 1 );
                }
            }
        }
        while( k && ( N != _0 ) )
        {
            i = lfirst( N );
            j = lfirst( L );
            if( i - j )
            {
                k = 0;
            }
            L = lred( L );
            N = lred( N );
        }

        if( k )
        { 
            return( 1 );
        }
 
        P = lred( P );
    }
    return( 0 );
}

/************************************************ is_inlist *** END ***/
    
/*c
                          lincombneg( E, L )

        "linear combination negation"
        static list lincombneg( E, L ) list E, L;
        M = lincombneg( E, L );
        If L = ( i0  i1  ...  ir ) then M = ( -i0  -i1  ...  -ir ).
        Return: M.
c*/

static list lincombneg( E, L )
list E, L;
{
    single i;
    list M, N;

    init( M, N );
    bind( E, L );
        
    M = L;

    if( i = lfirst( M ) ) 
    {
        single j;
        list T, S;

        init( T, S );

        T = ecisnftorgr( E );
        j = i;

        while( j > 0 )
        {
            S = lfirst( T );
            if( lthird( S ) )
            {
                j--;
            }
            T = lred( T );
        }
     
        if( lsecond( S ) )
        {
            list R;
          
            init( R );

            T = ecisnftorgr( E );
            i = 0;

            while( T != _0 )
            {
                R = lfirst( T );
                if( lthird( R ) )
                {
                    i++;
                }
                if( ecrpcomp( S, R ) == -1 )
                {
                   break;
                }
                T = lred( T );
            }
        }
    }

    N = list1( i );
    M = lred( M );

    while( M != _0 )
    {
        i = (-1) * lfirst( M );
        N = lcomp( i, N );
        M = lred( M );
    }
    return( linv( N ) );
}
/*********************************************** lincombneg *** END ***/
    
/*c
                          lincomb( E, L )

        "linear combination"
        static list lincomb( E, L ); list E, L;
        M = lincombneg( E, L );
	E is a list containing important data of the elliptic curve E/Q.
        L = ( i0  i1 ... ir ) single i0, i1, ..., ir; with r = rk(E/Q).
        Return: M = L = ( -i0  -i1 ... -ir )
c*/
      
static list lincomb( E, L )
list E, L;
{
    single j;
    list B, P, Q, R, T;

    init( B, P, Q, R, T );
    bind( E, L );

    B = ecisnfbmwg( E ) ;

    T = ecisnftorgr( E );

    if( ( j = lfirst( L ) ) )
    {
       while( j > 0 )
       {
           R = lfirst( T );
           T = lred( T );
           if( lthird( R ) )
           {
               j--;
           }
       }
    }
    else
    {
       R = list3( 0, 1, 0 );
    }
    L = lred( L );

    while( L != _0 )
    {
        if( ( j = lfirst( L ) ) )
        {
            P = lfirst( B );
            Q = ecisnfmul( E, P, j );
            R = ecisnfsum( E, Q, R );
        }
        B = lred2( B );
        L = lred ( L );
    }
    return( R );
}
/************************************************** lincomb *** END ***/
    
/*c
                          ecflsnfsum( a, b, P, Q )

        "elliptic curve over floatings sum of points"
        static list ecflsnfsum( a, b, P, Q )  
                       floating a, b; list P, Q;
        Q = ecflsnfsum( a, b, P, Q );
	a and b are the coefficients of the sWNF-model of E, 
        P and Q are points on this model.
        Return: R = P + Q.
c*/

static list ecflsnfsum( a, b, P, Q )
floating a, b;
list P, Q;
{
    bind( P, Q );
    bind( a, b );

    if( !lthird( P ) )
    {
        return( Q );
    }
    if( !lthird( Q ) )
    {
        return( P );
    }
    else
    {
        /***   P, Q != O  ***/

        floating x1, x2, y1, y2, w, x, y, z;
        single   f;

        init( x1, x2, y1, y2, w, x, y, z );
    
        x1 = lfirst ( P );
        x2 = lfirst ( Q );
        y1 = lsecond( P );
        y2 = lsecond( Q );
        f = 1;

        w = fldif( x2, x1 );
    
        if( flcomp( flabs( w ), ETA ) < 0 )
        {
            /***   P = +/- Q   ***/
            y = flabs( flsum( y1, y2 ) );
            if( flcomp( y, ETA ) < 0 )
            {
                /***   P = -Q   ***/
                return( list3( 0, 0, 0 ) );
            }
            y = flabs( fldif( y1, y2 ) );
            if( flcomp( y, ETA ) < 0 )
            {
                /***   P = Q   ***/
                w = flsum( y1, y1 );
                x = flprod( x1, x1 );
    
                z = flprod( itofl( 3 ), x );
                z = flsum ( z, a );
    
                y = fldif ( a, x );
                y = flprod( y, x1 );
                y = flsum ( y, b );
                y = flsum ( y, b );
                f = 0;
            }
        }
        if( f )
        {
            /***   P != +/- Q   ***/

            y = flprod( y1, x2 );
            z = flprod( y2, x1 );
            y = fldif (  y, z  );

            z = fldif( y2, y1 );
        }

        z = flquot( z, w );
        y = flquot( y, w );

        x = flprod( z,  z );
        x = fldif ( x, x1 );
        x = fldif ( x, x2 );

        y = flsum ( y, flprod( z, x ) );
        y = flneg( y );

        return( list3( x, y, 1 ) );
    }
}
/*********************************************** ecflsnfsum *** END ***/
    
/*c
                          ecflsnfdouble( a, b, P )

        "elliptic curve over floatings double of point"
        static list ecflsnfdouble( a, b, P )  floating a, b; list P;
        Q = ecflsnfdouble( a, b, P );
	a and b are the coefficients of the sWNF-model of E, 
        P is a point on this model.
        Return: Q = 2 * P = P + P.
c*/

static list ecflsnfdouble( a, b, P )
list P;
floating a, b;
{
    bind( a, b );
    bind( P );

    if( lthird( P ) )
    {
        floating x;
    
        init( x );

        x = flabs( lsecond( P ) );
                   
        if( flcomp( x, ETA ) > 0 )
        {
            /***   P != O and neither a 2-torsions point  ***/
            floating w, y, z, p, q;
    
            init( w, y, z, p, q );

            p = lfirst ( P );
            q = lsecond( P );
    
            x = flsum ( q, q );
            w = flprod( p, p );
    
            z = flprod( w, itofl( 3 ) ) ;
            z = flsum ( z, a );
            z = flquot( z, x );

            y = fldif ( a, w );
            y = flprod( y, p );
            y = flsum ( y, b );
            y = flsum ( y, b );
            y = flquot( y, x );
    
            x = flprod( z, z );
            x = fldif ( x, p );
            x = fldif ( x, p );

            y = flsum ( y, flprod( x, z ) );
            y = flneg ( y );

            return( list3( x, y, 1 ) );
        }
    }
    return( list3( 0, 0, 0 ) );
}
/******************************************** ecflsnfdouble *** END ***/
    
/*c
                          ecflsnfmul( a, b, P, n )

        "elliptic curve over floatings multiplication of point"
        static list ecflsnfmul( a, b, P, n )  
                       floating a, b; list P; single n;
        Q = ecflsnfmul( a, b, P, n );
	a and b are the coefficients of the sWNF-model of E, 
        P is a point on this model.
        Return: Q = n * P = P + ... + P (n times).
c*/

static list ecflsnfmul( a, b, P, n )
floating a, b;
list P;
single n;
{
    bind( P );
    bind( a, b );

    if( n && lthird( P ) )
    {
        single m;
        list   Q, S;

        init( Q, S );

        S = list3( 0, 0, 0 );
        Q = lcopy( P );
        m = sabs( n );

        while( 1 )
        {
            if( ( m & 01 ) == 1 )
            {
                S = ecflsnfsum( a, b, Q, S );
            }

            /*   right shift: division of m by 2   */
            m >>= 1;

            if( !m )
            {
                break;
            }

            Q = ecflsnfdouble( a, b, Q );
        }
        if( n < 0 )
        {
            floating y;
            init( y );

            y = lsecond( S );
            y = flneg( y );
            leset( S, 2, y );
        }
        return( S );
    }
    return( list3( 0, 0, 0 ) );
}
/*********************************************** ecflsnfmul *** END ***/
    
/*c
                          eciptofl( P )

        "elliptic curve over integers point to floating"
        static list eciptofl( P )  list P;
        Q = eciptofl( P );
        P = ( x  y  z ) int x, y, z; is a point on E/Q with integral
        (rational) coefficients.
        Q = ( 0.0  0.0  0.0 )  if z = 0
            ( X  Y  1 ) floating X, Y; with X = 1.0 * x/z^2,
                                            Y = 1.0 * y/z^3, else.
        Return: Q.
c*/

static list eciptofl( P )
list P;
{
    bind( P );

    if( !lthird( P ) )
    {
        return( list3( 0, 0, 0 ) );
    }
    else
    {
        floating w, x, y, z;

        init( w, x, y, z );
    
        x = itofl( lfirst ( P ) );
        y = itofl( lsecond( P ) );
        z = itofl( lthird ( P ) );
        w = flprod( z, z );
        x = flquot( x, w );
        w = flprod( w, z );
        y = flquot( y, w );
      
        return( list3 ( x, y, 1 ) );
    }
}
/************************************************* eciptofl *** END ***/
    
/*c
                          isiponecfl( E, P )

        "is integral point on elliptic curve with floating
         point coefficients"
        static isiponecfl( E, P ); list E, P;
        i = isiponecfl( E, P );
        Return: 1, if P is an integral point on E,
                0  otherwise
c*/

static isiponecfl( E, P )
list E, P;
{
    bind( P );

    if( lthird( P ) )
    {
        int      x;
        floating a;
      
        init( x, a );
        bind( E );
      
        a = lfirst ( P );
        x = flround( a );


        a = fldif( a, itofl( x ) );
        a = flabs( a );
        if( flcomp( a, EPS ) < 0 )
        {
            int      y;
            floating b;

            init( y, b );

            b = lsecond( P );
            y = flround( b );

            b = fldif( b, itofl( y ) );
            b = flabs( b );
            if( flcomp( b, EPS ) < 0 )
            {
                int h;
                init( h );

                h = iprod( x, x );
                h = isum ( h, ecisnfa4( E ) );
                h = iprod( h, x );
                h = isum ( h, ecisnfa6( E ) );
                y = iprod( y, y );
                h = idif ( h, y );

                if( !h )
                { 
                    return( 1 );
                }
            }
        }
    }
    return( 0 );
}
/*********************************************** isiponecfl *** END ***/

/*c
                     findintpoints( E, n )
         "find integral points"

        static list findintpoints( E, n ) list E; single n;
        L = findintpoints( E, n );
        Return: list ( P1  L1 ...  Pk  Lk ), _0 or ( 0 )
                (see documentation of 'ecisnfsaip').
c*/

static list findintpoints( E, n )
list E;
single n;
{
    single i, j, k, m, p, r, t, FL_EPS_OLD;
    list L, M, PL, TG, *T, *P, *Q, *R, S;
    floating a, b;

    bind( E );
    init( L, M, PL, TG, S );
    init( a, b );
    FL_EPS_OLD = FL_EPS;

    r = ecrrank( E );
    if( r )
    {
        i = r;
    }
    else
    {  
        i = 1;
    }

    if( ( P = ( list * ) malloc( i * sizeof( list ) ) ) == NULL )
    { 
        return( list1( 0 ) );
    }
    if( ( Q = ( list * ) malloc( i * sizeof( list ) ) ) == NULL )
    { 
        free( P );
        return( list1( 0 ) );
    }
    if( ( R = ( list * ) malloc( i * sizeof( list ) ) ) == NULL )
    { 
        free( P );
        free( Q );
        return( list1( 0 ) );
    }

    t = ecrordtor( E );
    t--;
    if( t )
    {
        i = t;
    }
    else
    {
        i = 1;
    }

    m = r * n / 2;

    if( m > 5 )
    {
        FL_EPS = m;
    }

    if( ( T = ( list * ) malloc( t * sizeof( list ) ) ) == NULL )
    { 
        free( P );
        free( Q );
        free( R );
        FL_EPS = FL_EPS_OLD;
        return( list1( 0 ) );
    }

    TG = ecisnftorgr( E );
    i--;
    init( T[0..i] );

    if( r )
    {
        i = r - 1;
    }
    init( P[0..i] );
    init( Q[0..i] );
    init( R[0..i] );

    
    PL = _0;

    if( t )
    {
        i = 0;

        while( TG != _0 )
        {
            L = lfirst( TG );
            if( lthird( L ) )
            {
                T[i] = eciptofl( L );
    
                p = 1;
                M = PL;
                a = lfirst( T[i] );
                i++;
        
                while( M != _0 )
                {
                    Q[0] = lfirst( M );
                    j = lfirst( Q[0] ) - 1;
                    b = flabs( fldif( lfirst( T[j] ), a ) );
                    if( flcomp( b, ETA ) <= 0 )
                    {
                        p = 0;
                        break;
                    }
                    M = lred( M );
                }
    
                if( p )
                {
         
                    L = _0;
                    for( j = 0; j < r; j++ )
                    {
                        L = lcomp( 0, L );
                    }
                    L = lcomp( i, L );

                    PL = lcomp( L, PL );
                }
            }
            TG = lred( TG );
        }
    }

    if( r )
    {
        a = itofl( ecisnfa4( E ) );
        b = itofl( ecisnfa6( E ) );

        M = ecisnfbmwg( E );

        for( i = 0; i < r; i++ )
        {
            P[i] = lfirst( M );
            R[i] = eciptofl( P[i] );
            M = lred2( M ); 
        }
    
        L = list1( 0 );
        j = (-1) * n;
        Q[0] = list3( 0, 0, 0 );
    
        for( i = 0; i < r - 1; i++ )
        {
            L = lcomp( j, L );
            P[0] = ecflsnfmul( a, b, R[i], j );
            Q[0] = ecflsnfsum( a, b, Q[0], P[0] );
        }
    
        for( i = 1; i < r; i++ )
        {
            Q[i] = Q[0];
        }
    
        p = 1;
    
        while( p )
        {
            M = L;
            j = 1;
    
            while( M != _0 )
            {
                k = lfirst( M );
                if( j && k )
                {
                    /***   i is the first nonzero entry in L  ***/
                    i = k;
                    j = 0;
                }
                M = lred( M );
            }
    
            if( k || ( i > 0 ) )
            {
                S = Q[0];
                j = 0; 
                while( 1 )
                {
                    if( isiponecfl( E, S ) )
                    {
                        M = lcopy( L );
                        M = lcomp( j, M );

                        if( !is_inlist( E, PL, M ) )
                        {
                            PL = lcomp( M, PL );
                        }
                    }
                    if( j == t )
                    {
                        break;
                    }
                    S = ecflsnfsum( a, b, Q[0], T[j] );
                    j++;
                }
            }
        
            M = L;
            p = 1;
    
            while( 1 )
            {
                j = lfirst( M );
             
                if( j == n )
                {
                    if( p == r )
                    {
                        /***   all linear combinations are tested ***/
                        p = 0;
                        break;
                    }
    
                    i = (-1) * n;
                    leset( L, p, i );
    
                    Q[p] = ecflsnfsum( a, b, Q[p], R[p] );
                    for( i = 0; i < p; i++ )
                    {
                        Q[i] = Q[p];
                    }
    
                    M = lred( M );
                    p++;
                }
                else
                {
                    leset( L, p, j + 1 );
                    if( p == 1 )
                    {
                        Q[0] = ecflsnfsum( a, b, Q[0], R[0] );
                    }
                    break;
                }
            }
        }
    }
    
    /***    PL is the list containing all linear combinations    ***/
    /***    of the torsion and the basis points whose floating   ***/
    /***    point representation is 'close' to an integral       ***/
    /***    point. Test now the integrality of these linear      ***/
    /***    combinitions using the ratinal representation of     ***/
    /***    the torsion and the basis points.                    ***/

    M = _0;

    while( PL != _0 )
    {
        L = lfirst( PL );
        Q[0] = lincomb( E, L );

        if( lthird( Q[0] ) == 1 )
        {
            /***   Q[0] is integral  ***/

            if( isign( lsecond( Q[0] ) ) < 0 )
            {
                /***   y_Q[0] < 0: Q[0] <--  -Q[0] and   ***/
                /***   L = ( i0  i1  ...  ir )           ***/
                /***     <-- ( i0'  -i1  ...  -ir )      ***/
                /***   where Ti0' = -Ti0                 ***/

                L = lincombneg( E, L );
                Q[0] = ecisnfneg( E, Q[0] );
            }

            M = lcomp2( Q[0], L, M );
        }
        PL = lred( PL );
    }

    FL_EPS = FL_EPS_OLD;
    /***   resetting of the floating point pecision   ***/

    return( M );
}
/******************************************** findintpoints *** END ***/
    
/*c
                          lipunion( E, L1, L2 )

        "lists of intergral points union"
        static list lipunion( E, L1, L2 );
        U = lipunion( E, L1, L2 );
        Return: U.
c*/

static list lipunion( E, L1, L2 )
list E, L1, L2;
{
    single i;
    list K, M1, M2, P, Q;

    init( K, M1, M2, P, Q );
    bind( E, L1, L2 );

    K  = L1;
    M2 = L2;

    while( M2 != _0 )
    {
        P = lfirst( M2 );
  
        M1 = L1;
        i = 1;
        while( M1 != _0 )
        {
            Q = lfirst( M1 );
            if( ecrpcomp( P, Q ) )
            {
                /***   P or -P are already in L1   ***/
                i = 0;
                break;
            }
            M1 = lred2( M1 );
        }
        if( i )
        {
            /***   neiter P nor -P were yet in L1   ***/
            Q = lsecond( M2 );
            K = lcomp2( P, Q, K );
        }
        M2 = lred2( M2 );
    }
    return( K );
}
/************************************************* lipunion *** END ***/

/**********************************************************************/
/***                                                                ***/
/***               s t a t i c   f u n c t i o n s                  ***/
/***                          ( E n d )                             ***/
/***                                                                ***/
/***                                                                ***/
/***     B e g i n n i n g   o f   t h e   m a i n   p a r t        ***/
/***                                                                ***/
/**********************************************************************/

list ecisnfsaip( E )
list E;
{
    list B, L;
    single r, N;

    bind( E );
    init( B, L );


    B = _0;

    if( ( N = ecisnfsaipub( E ) ) == ERROR )
    {
        return( list1( 0 ) );
    }

    if( r = ecrrank( E ) )
    {
        single   i;
        int      a, b;
        list     P, U, BT;
        rat      s, t;
        floating u, v, w, V;

        init( a, b );
        init( P, U, BT );
        init( s, t );
        init( u, v, w, V );

        /***             extra search procedure:                  ***/
        /***                                                      ***/
        /***   Let f( x ) = x^3 + a * x + b                       ***/
        /***      = ( x - x1 ) * ( x - x2 ) * ( x - x1 )          ***/
        /***   where x1 is the largest real root of f(x).         ***/
        /***   Search for integral points in { log| x_P | < m }   ***/
        /***   with   m = max{ my_oo, xi_0 },                     ***/ 
        /***      my_oo = log max{ |a|^(1/2), |b|^(1/3) }         ***/ 
        /***               /  2 * x1 + M    if x2, x3 are real    ***/
        /***   and xi_0 = <                                       ***/ 
        /***               \  max{ 2 * x1, x2 + x3 } + M  else    ***/
        /***   where M = exp( my_oo ) / ( 2^(1/3) - 1 )           ***/
        /***   Moreover, we have: Re( x2 ) = Re( x3 ) = x1 / 2    ***/
        /***   (since all coefficients of f( x ) are real and     ***/
        /***   the coefficient at x^2 is zero.)                   ***/
        /***   Thus xi_0 = 2 * x1 + M.                            ***/

        /***   computation of my_oo                               ***/
        a = ecisnfa4( E );
        b = ecisnfa6( E );
        v = flsqrt( itofl( iabs( a ) ) );
        w = flsqrt( itofl( iabs( b ) ) );
        if( flcomp( v, w ) < 0 )
        {
            v = w;
        }
        u = fllog( v );
        /***   u := my_oo                                         ***/

        /***   computation of xi_0                                ***/
        v = flprod( v, itofl( 4 ) );  

        /***   Estimate: 1 / [2^(1/3) - 1] = 1 / 0.2599... < 4    ***/
        s = itor( a );
        t = itor( b );
        L = ecrsnfrroots( s, t );
        if( llength( L ) == 3 )
        {  
            L = lred2( L );
        }
        w = lfirst( L );
       
        w = flsum( w, w );
        if( flsign( w ) > 0 )
        {
            v = w;
        }
        else
        {
            v = flsum( w, v );
        }
        /***   v := xi_0                                          ***/
 
        if( flcomp( u, v ) > 0 )
        {
            v = u;
        }
        /***   v := m = max{ my_oo, xi_0 }                        ***/
        w = fllog( v );

        u = 0;
        U = _0;
        L = _0;
        for( i = 0; i <= r; i++ )
        {
            /***   set the linear combination L := ( 0 ... 0 )    ***/
            /***   for those points P that are found by the       ***/ 
            /***   extra search procedure but  n o t  by the      ***/ 
            /***   routine 'findpoints( E, N )' below,            ***/ 
            /***   i.e. P = T + n1 * P1 + .. + nr * Pr            ***/ 
            /***        with |k| > N for some 1 <= k <= r.        ***/ 
            L = lcomp( 0, L );
        }

        if( _H_BOUND > 0.0 )
        {
            V = Cfltofl( _H_BOUND );
            if( flcomp( w, V ) > 0 )
            {
                w = V;
            }
        }
        ecisnfpbwh( E, &U, &u, w, -9, 0, &U );
 
        BT = eciminbtsnf( E );

        while( U != _0 )
        {
            P = lfirst( U );
            P = ecrbtp( P, BT );
            B = lcomp2( P, L, B );
            U = lred2( U );
        }
    }

    /***   test for integrality of all points            ***/
    /***        P = T + n1 * P1 + ... + nr Pr            ***/
    /***   where T runs through the torsion subgroup     ***/
    /***   and | nk | <= N for all 1 <= k <= r.          ***/

    L = findintpoints( E, N );

    L = lipunion( E, L, B );

    return( L );
}
/*********************************************** ecisnfsaip *** END ***/
