/*M
.SH NAME
ecisnfsaipub - curve with integer coefficients, short normal form, search for all integral points, upper bound

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecisnfsaipub(E)
list E;

.SH DESCRIPTION
Let r be the rank and P1, ... , Pr be a basis of E/Q 
where the points Pi lie on the short model of E/Q. 
Then for any point P on E/Q we have a representation
.PP
        P = n1 * P1 + ... + nr * Pr + T (*)
.PP
with a torsion point T and integers n1, ..., nr.
ecisnfsaipub() returns a single precision integer N
such that it holds for any integer point P that
.PP
          |ni| <= N for 1<=i<=r in (*)
.PP
or -1 in case N could not be computed.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH REFERENCES
J. Gebel, A. Pethoe and H. G. Zimmer, "Computing Integral Points on Elliptic Curves",
Acta arithmetica 68 (1994) 171-192.

.SH SEE ALSO
ecrinit
M*/
/*H
	Version 1       20.04.1995      Josef Gebel
	Version 2       07.12.1996      Errors fixed, new routine for the
                                        elliptic logarithm, initial bound
                                        by Hajdu-Herendi. JG.
   DATE ecisnfsaipub  : 951201.970101
H*/

#include <_ec2.h> 

/**************************************************************************/
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/

static floating ecisnfelog_lk( E, P )
list E, P;
{
    /***   z = l_1 * w_1 + l_2 * w_2  elliptic logarithm of P  ***/
    /***   where w_1 = real period, w_2 = complex period.      ***/
    /***   Return value: l_1 such that -1/2 < l_1 <= 1/2.      ***/

    complex  z;
    floating w1, v1, v2;

    init( z, w1, v1, v2 );
    bind( E, P );

    w1 = ecrrperiod( E );
    z  = ecisnfelog( E, P );
    v1 = creal( z );
    v2 = cimag( z );

    if( v2 && ( isign( ecisnfdisc( E ) ) < 0 ) )
    {
        /***   Re(w2) != 0. Find l_2 and set Re(z) = Re(z - l_2 * w2)   ***/
        complex  w2;
        floating u1, u2;

        init( u1, u2, w2 );

        w2 = ecrcperiod( E );
        u1 = creal( w2 );
        u2 = cimag( w2 );
        v2 = flquot( v2, u2 );
        u1 = flprod( v2, u1 );
        v1 = fldif ( v1, u1 );
    }

    v1 = flquot( v1, w1 );
    v1 = flabs( v1 );
    v2 = rtofl( rcons( 1, 2 ) );
    if( flcomp( v1, v2 ) > 0 )
    {
        v1 = fldif( v1, v2 );
    }
    v2 = itofl( isign( lsecond( P ) ) );
    v1 = flprod( v1, v2 );
    return( v1 );
}
/*c
                         David_bound( r )

        "David's bound for elliptic logarithms"
        static floating David_bound( r ) single r;
	C = David_bound( r );
        David_bound( ) ist static zu ecisnfsaipub.
        computation of the David bound 
           C = 1.1 * 10^(7*r+2) * (2/e)^(2*(r-1)^2) * r^(4*r^2+2*r-6)
        Return: C.
        Literature: S. David: Minorations de formes lineaires de logarithmes
           elliptiques, Publ. Math. de l'Un. Pierre et Marie Curie no. 106,
           Problemes diophantiens 1991-1992, expose no. 3.
c*/

static floating David_bound( r )
single r;
{
    single   e;
    int      a, b;
    floating C, h;

    init( C, h );
    init( a, b );

    e = 7 * r + 8;
    a = iexp( 10, e );
    b = isprod( a, 10 );
    a = isum( a, b );
    
    e = 4 * r * r + 10 * r;  
    b = r + 1;
    b = iexp( b, e );

    a = iprod( a, b );

    e = 2 * r * r;
    b = iexp( 2, e );
     
    a = iprod( a, b );

    h = itofl( e );
    h = flexp( h );

    C = itofl( a );
    C = flquot( C, h );
    
    return( C );
}
/********************************************** David_bound *** END ***/

/*c
                     function_01( x, r, c1, c2 )

        static floating function_01( x, r, c1, c2 )
             single r; floating x, c1, c2;
        Return: F(x)/F'(x) with F from N_function
c*/

static floating function_01( x, r, c1, c2 )
floating x, c1, c2;
single r;
{
    floating a, b, y, z;

    bind( x, c1, c2 );

    init( a, b, y, z );

    z = fllog ( x );
    z = flsum ( z, z );
    a = flsexp( z, r + 1 );
    a = flprod( a, c2 );
    b = flprod( a, itofl( r + 2 ) );
    y = flprod( x,  x );
    b = fldif ( y,  b );
    b = flsum ( b,  b );

    a = flprod( a,  z );
    a = fldif ( y,  a );
    a = fldif ( a, c1 );
    a = flprod( a,  x );
    a = flquot( a,  b );
    
    return( a );
}
/********************************************** function_01 *** END ***/

/*c
                     N_function( x, r, c1, c2 )

        "function F for N"
        static floating N_function( x, r, c1, c2 ); 
             single r; floating x, c1, c2;
        y = N_function( x, r, c1, c2 );
        Return: F(x) := x^2 - c2 * [ log ( x^2 ) ]^( r + 2 ) - c1.
c*/

static floating N_function( x, r, c1, c2 )
floating x, c1, c2;
single r;
{
    floating a, b;

    init( a, b );
    bind( x, c1, c2 );

    a = flprod( x, x );
    b = fllog ( a );
    b = flsexp( b, r + 2 );
    b = flprod( b, c2 );
    b = flsum ( b, c1 );
    a = fldif ( a,  b );
   
    return( a );
}
/*********************************************** N_function *** END ***/

/*c
                     N_function_der_1( x, r, c2 )

        "function F for N, 1st derivative"
        static floating N_function_der_1( x, r, c2 ); 
             single r; floating x, c2;
        y = N_function_der_1( x, r, c2 );
        Return: F'(x) with F from N_function
c*/

static floating N_function_der_1( x, r, c2 )
floating x, c2;
single r;
{
    floating a;

    init( a );
    bind( x, c2 );

    a = fllog ( x );
    a = flprod( a, itofl( 2 ) );
    a = flsexp( a, r + 1 );
    a = flprod( a, c2 );
    a = flprod( a, itofl( r + 2 ) );
    a = flquot( a, x );
    a = fldif ( x, a );
    a = flprod( a, itofl( 2 ) );

    return( a );
}
/***************************************** N_function_der_1 *** END ***/

/*c
                     N_function_der_2( x, r, c2 )

        "function F for N, 2nd derivative"
        static floating N_function_der_2( x, r, c2 ); 
             single r; floating x, c2;
        y = N_function_der_2( x, r, c2 );
        Return: F"(x) with F from N_function
c*/

static floating N_function_der_2( x, r, c2 )
floating x, c2;
single r;
{
    floating a, b, c;

    init( a, b, c );
    bind( x, c2 );

    a = flprod( x, x );
    b = fllog ( x );
    c = itofl( 2 * r - 2 );
    c = fldif ( c, b );
    b = flsexp( b, r );
    b = flprod( b, c );
    b = flquot( b, a );
    b = flprod( b, itofl( r + 2 ) );
    b = flprod( b, c2 );
    a = fldif( itofl( 1 ), b );
    a = flprod( a, itofl( 2 ) );

    return( a );
}
/***************************************** N_function_der_2 *** END ***/

/*c
                     isqlfvec( M );

        "integer square of the length of the first vector"
        static int isqlfvec( M ) matirx M;
        a = isqlfvec( M );
        M is an (r x r)-matix over the integers.
        Return: M[1,1]^2 + ... + M[r,1]^2.
c*/

static int isqlfvec( M )
matrix M;
{
    list   V;
    int a, b;

    bind( M );
    init( a, b, V );

    V = lfirst( M );

    while( V != _0 )
    {
        b = lfirst( V );
        a = isum( a, iprod( b, b ) );
        V = lred( V );
    }
    return( a );
}
/************************************************* isqlfvec *** END ***/

/**********************************************************************/
/***                                                                ***/
/***               s t a t i c   f u n c t i o n s                  ***/
/***                          ( E n d )                             ***/
/***                                                                ***/
/***                                                                ***/
/***     B e g i n n i n g   o f   t h e   m a i n   p a r t        ***/
/***                                                                ***/
/**********************************************************************/

ecisnfsaipub( E )
list E;
{
    int N;
    list B, L;
    single r;

    bind( E );
    init( N );
    init( B, L );

    B = _0;

    if( r = ecrrank( E ) )
    {
        /***   rank( E/Q ) > 0                   ***/

        single   g, i, k, m, n, q, t, l10, FL_EPS_old;
        int      a, b, N1, N2;
        floating C, c11, c1, c2, h, l1, nh, u, V, v, W, w, x;
        list     P, U;
        rat      j;
        complex  tau;
        matrix   M1, M2;

        init( a, b, N1, N2 );
        init( C, c11, c1, c2, h, l1, nh, u, V, v, W, w, x );
        init( P, U );
        init( j );
        init( tau );
        init( M1, M2 );
  
        FL_EPS_old = FL_EPS;

        t = ecrordtor( E );
        if( llength( ( B = ecisnfbmwg( E ) ) ) == 1 )
        {
            return( ERROR ) );
        }
        
        L = ecrsevrm( E ); 

        if( !L )
        {
            /***   Error in the computation     ***/
            /***   of the smallest eigenvalue   ***/

            return( ERROR );
        }
        
        l1 = lfirst( L );

        P = lfirst( B );
        if( ( r == 1 ) && ( t == 1 ) && ( lthird( P ) != 1 ) )
        {
            /***   rank( E/Q) = 1 and the torsion is trivial:  ***/
            /***   the only points on E/Q are of the form      ***/
            /***   k * P (k in N). If P is not integral then   ***/
            /***   neither k * P (k in Z\{0}) is integral.     ***/
            /***   ==> there are no integral points on E/Q     ***/
       
            return( 0 );
        }

        m = r + 1;
        w = ecrrperiod( E );

        /***   computation of the constant c_1' from the paper   ***/
        /***   (c_1' will be denoted by c11 in this program )    ***/
        c11 = itofl ( 2 );
        c11 = flpow ( c11, Cfltofl( 2.25 ) );
        c11 = flquot( c11, w );

        /***   computation of the constant h from the paper      ***/
        a = iabs( ecisnfa4( E ) );
        b = iabs( ecisnfa6( E ) );
        if( icomp( a, b ) < 0 )
        {
            a = b;
        }
        a = isprod( a, 4 );
        j = ecrjinv( E );
        b = rden( j );
        a = iprod( a, b );
        b = iabs( rnum( j ) );
        if( icomp( a, b ) < 0 )
        {
            a = b;
        }
        h = fllog( itofl( a ) );

        /***   computation of the elliptic logarithms u_i      ***/
        /***   the basis points P_i (to compute the constants  ***/
        /***   V_i (1 <= i <= r) from the paper)               ***/
        /***   (here a lower precision is sufficient).         ***/

        tau = ecrquotper( E );

        u = cimag( tau );
        u = flprod( u, w );
        u = flprod( u, w );
        x = flPi();
        x = flprod( x, itofl( 3 ) );
        x = flquot( x, u );

        L  = B;
        /***   W will be the product over all V_i (1 <= i <= r)   ***/
        W  = itofl( 1 );
        /***   V will be the maximum of all V_i (1 <= i <= r)     ***/
        V  = 0;

        i = 0;
        n = flinit( 40 );

        do
        {
            P  = lfirst ( L );
            nh = lsecond( L );
            u = ecisnfelog_lk( E, P );

            v = flprod( u, u );
            v = flprod( v, x );

            if( flcomp( v, h ) < 0 )
            {
                v = h;
            }
            if( flcomp( v, nh ) < 0 )
            {
                v = nh;
            }

            W = flprod( W, v );

            if( flcomp( V, v ) < 0 )
            {
                V = v;
            }
        }
        while( ( L = lred2( L ) ) != _0 );

        /***   W = product over all V_i ( 1 <= i <= r )      ***/
        /***   V = max{ V_i : 1 <= i <= r }                  ***/

        C = David_bound( r );

        /***   computation of                                  ***/
        /***      c1 = max{ log( c_1' * t ) / lambda_1 }       ***/
        v = flprod( c11, itofl( t ) );
        v = fllog( v );
        v = flquot( v, l1 );
        c1 = itofl( 1 );
        if( flcomp( v, c1 ) > 0 )
        {
            c1 = v;
        }
       
        /***   computation of                                  ***/
        /***      c2 = max{ C/l1, 10^9 } * (h/2)^(r+1) * W     ***/
        c2 = flquot( C, l1 );
        u  = itofl( 10 );
        u  = flsexp( u, 9 );
        if( flcomp( u, c2 ) > 0 )
        {
           c2 = u;
        }
        u = flsquot( h, 2 );
        u = flsexp ( u, m  );
        c2 = flprod( c2, u );
        c2 = flprod( c2, W );

        V = flexp( V );

        /***   computation of                                  ***/
        /***      N1 = max{ 2V/(r+2), 2^(r+2) * (c1*c2)^(1/2)  ***/
        /***                * (ln(c2*(r+2)^(r+2)))^((r+2)/2) } ***/
        i = r + 2;
        N = iexp( i, i );
        x = flprod( c2, itofl( N ) );
        x = fllog ( x );
        x = flsqrt( x );
        x = flsexp( x, i );

        u = flprod( c1, c2 );
        u = flsqrt( u );
        x = flprod( x, u );

        N = iexp( 2, i );
        x = flprod( x, itofl( N ) );

        u = flsum( V, V );
        u = flsquot( u, m );
        if( flcomp( u, x ) > 0 )
        {
            x = u;
        }
        /***   x initial bound using David's results  ***/

        u = ecisnfSiphhb( E, _0 );
        u = flsum( u, ecisnfdwhnth( E ) );
        u = flquot( u, l1 );
        u = flsqrt( u );
        /***   u initial bound using Hajdu and Herendi's results  ***/

        if( flcomp( x, u ) > 0 )
        {
            /***   Hajdu-Herendi bound smaller than David bound  ***/
            x = u;
        }
        /***   else: David bound smaller than Hajdu-Herendi bound  ***/

        N = flround( x );
        
        l10 = ilog10( N ) + 1;
        k = l10 * ( r + 3 ) / 2;
        if( k > FL_EPS )
        {
            FL_EPS = k;
        }

        /***    incrementation of the precision for the       ***/
        /***    floating point arithmetic                     ***/

        U = _0;
        L = B;
        i = 0;

        do
        {
            P = lfirst( L );
            u = ecisnfelog_lk( E, P );
            U = lcomp( u, U );
        }
        while( ( L = lred2( L ) ) != _0 );

        U = lcomp( itofl( 1 ), U );

        n = 4 + r * ( 5 + r );
        a = iexp( 2, r );
        a = iprod( a, n );
        a = iprod( a, t * t );
        h = itofl( a );
        h = fllog( h );
        h = flsquot( h, 2 );
        /***   h = log[sqrt(2^r * (r^2 + 5 * r + 4)) * t]       ***/
        /***     = (1/2) * log[2^r * (r^2 + 5 * r + 4) * t^2]   ***/

        x = fllog( itofl( 2 ) );
        x = flprod( x, Cfltofl( 7.0 / 6.0 ) );
        /***    x = log(2^(1/2) * 4^(1/3)) = (6/7) * log(2)     ***/

        h = flsum( h, x );
        x = fllog( w );
        h = fldif( h, x );

        /***                      2^(1/2) * 4^(1/3)             ***/
        /***    h = log( ----------------------------------- )  ***/
        /***              w_1 / ((2^r * (r^2+5r+4))^(1/2)*t)    ***/

        /***   de Weger reduction of the initial value N       ***/

        while( 1 )
        {
            N1 = N;
            u  = fllog( itofl( N1 ) );
            v  = fllog( itofl( 10 ) );
            u  = flquot( u, v );
            q  = flfloor( u ) + 1;
            q *= m;
            b  = iexp( 10, q );
    
            while( 1 )
            {
                C = itofl( b );
                u = fllog( C );

                g = 1; /***  g = gamma in de Weger's PhD thesis  ***/

                /***   u = (r + 1) * log( N1 ) = log( N1^(r+1) ) ***/
                if( q < 13 )
                {
                    g = 14 - q / 2;
                }
                i = m;

                M1 = _0;
                L  = _0;
   
                while( U != _0 )
                {
                    v = fltofl( lfirst( U ) );
                    L = lcomp( v, L );
                    v = flprod( v, C );
                    v = flprod( v, itofl( g ) );
                    N = flfloor( v );

                    M2 = list1( N );

                    for( k = m - 1; k > 0; k-- )
                    {
                        if( k - i )
                        {
                            M2 = lcomp( 0, M2 );
                        }
                        else
                        {
                            M2 = lcomp( g, M2 );
                        }
                    }
                    i--;

                    U = lred( U );
                    M1 = lcomp( M2, M1 );
                }

                U = linv( L );

                M2 = mailllred( M1 );

                a = isqlfvec( M2 );

                /***   a = || M1 ||^2 :                          ***/
                /***   a^(1/2) is the length of the first        ***/
                /***   vector of the LLL-reduced basis M2        ***/
    
                q = r * ( r + 4 + g * g ) + 4;
                q *= sexp( 2, r );
                x = flsquot( itofl( a ), q );
                x = flsqrt( x );
                N2 = flfloor( flsqrt( x ) );
                if( !N2 ) 
                {
                    N2 = 1;
                }
                x = fllog( x );
                /***   x = log( N~ )  and   N2 = sqrt( N~ )      ***/

                u = flsum( u, h );
                u = flsum( u, fllog( itofl( g ) ) );
                x = fldif( u, x );
                x = flquot( x, l1 );
                x = flprod( x, itofl( 2 ) );
                x = flsqrt( x );

                N = flfloor( x );
                if( !N )
                {
                    N = 1;
                }
    
                if( icomp( N, N2 ) > 0 )
                {
                    /***   N > N~: N1 was too small                 ***/
                    b = iprod( b, N );
                }
                else
                {
                    /***   N = reduced bound and N <= N~            ***/
                    break;
                }

            }

            if( !idif( N, N1 ) || ( N == 1 ) )
            {
                /***   N cannot be reduced any further        ***/

                FL_EPS = FL_EPS_old;
                return( N );
            } 

            l10 = ilog10( N ) + 1;
            k = smax( 2 * r * l10, 5 );

            if( ( k < n ) && ( k > 4 ) )
            {
                n = k;
                FL_EPS = k;
                h = fltofl( h );
            }
            /***    decremention of the precision for the         ***/
            /***    floating point arithmetic                     ***/
        }
    }

    return( 0 );
}
/********************************************* ecisnfsaipub *** END ***/
