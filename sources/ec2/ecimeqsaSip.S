/*M
.SH NAME
ecimeqsaSip - curve with integer coefficients, Mordell's equation, search for all S-integral points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimeqsaSip(E, S)
list E, S;

.SH DESCRIPTION
ecimeqsaSip() returns the list of all S-integral points on E/Q, i.e. 
all points P=(x, y) on the actual model E/Q such that v_p(x)>=0
and v_p(y)>=0 for all primes p in S.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.TP 4
.B S
is a list of single precision prime numbers.

.SH REFERENCES
N. Smart, "S-integral points on elliptic curves", Proc. Camb. Phil. Soc., 116, 391-399, 1994.

.SH SEE ALSO
ecrinit
M*/
/*H
					
	Version 1       22.04.1995      Josef Gebel
   DATE ecimeqsaSip   : 951201.961201
H*/

#include <_ec2.h> 
/** #include "../sepp.h"**/

#define NC 38

static list ecmcneg( P )
list   P;
{
    bind( P );

    if( !ispecrpai( P ) )
    {
        list Q;

        init( Q );

        Q = list1( lthird( P ) );
        Q = lcomp( ineg( lsecond( P ) ), Q );
        Q = lcomp( lfirst( P ), Q );
     
        return( Q );
    }
    return( P );
}

static list ecmcdouble( a6, P )
single a6;
list P;
{
    int x1, x2, y1, y2, z1, z2, v, w, h1, h2;
    list D;

    bind( P );

    if( !( lsecond( P ) && lthird( P ) ) )
    {
	/*   P = O or P = ( x, 0 ) ==> 2 * P = O     */
	
	return( list3( 0, 1, 0 ) );
    }

    init( x1, x2, y1, y2, z1, z2, v, w, h1, h2 );
    init( D );

    x1 = lfirst ( P );
    y1 = lsecond( P );
    z1 = lthird ( P );


    h2 = isprod( y1, 2 );    /*  2 y       */
    z2 = iprod ( z1, h2 );   /*  2 y z     */

    w  = iprod ( x1, x1 );   /*  x^2       */
    v  = isprod(  w, 3 );    /*  3 x^2     */
    /***    lambda = v / z2 (cf. Silverman's 1st book, p. 58)   ***/

    /*   Berechnung der x-Koordinate des Ergebnisses   */
    x2 = iprod ( y1, y1 );
    x2 = isprod( x2, 8  );       /***  8 * y^2                    ***/

    h1 = iprod (  v, x1 );       /***  3 * x^3                    ***/
    h1 = isprod( h1,  3 );       /***  9 * x^3                    ***/
    x2 = idif  ( h1, x2 );       /***  9 * x^3 - 8 * y^2          ***/
    x2 = iprod ( x2, x1 );       /***  x * ( 9 * x^3 - 8 * y^2 )  ***/

    /*   Berechnung der y-Koordinate des Ergebnisses   */
    y2 = iexp  ( z1, 6  );       /***  z^6                             ***/
    y2 = iprod ( y2, a6 );       /***  a6 * z^6                        ***/
    y2 = isprod( y2, 2  );       /***  2 * a6 * z^3                    ***/
    h1 = iprod (  w, x1 );       /***  x^3                             ***/
    y2 = idif  ( h1, y2 );       /***  x^3 - 2 * a6 * z^6              ***/
    y2 = iprod ( y2, h2 );       /***  2 * y * ( x^3 - 2 * a6 *z^6 )   ***/
    y2 = iprod ( y2, h2 );       /***  4 * y^2 * ( x^3 - 2 * a6 *z^6 ) ***/
    h1 = iprod (  v, x2 );       /***  Denominator of lambda * x2      ***/
    y2 = idif  ( y2, h1 );

    /*   Normierung des Ergebnisses   */
    D = ecipnorm( list3( x2, y2, z2 ) );

    return( D );
}

static list ecmcsum( a6, P, Q )
single a6;
list P, Q;
{
    bind( P, Q );

    if( ispecrpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> P + Q = Q                 */
	return( Q );
    }
    if( ispecrpai( Q ) )
    {
	/*   Q = ( 0 : 1 : 0 ) ==> P + Q = P                 */
	return( P );
    }
    else
    {
        int v, w, h1, h2;
        int x1, x2, x3, y1, y2, y3, z1, z2, z3;
        list S;
    
        init( h1, h2, v, w );
        init( x1, x2, x3, y1, y2, y3, z1, z2, z3 );
        init( S );
    
        x1 = lfirst ( P );
        y1 = lsecond( P );
        z1 = lthird ( P );

        x2 = lfirst ( Q );
        y2 = lsecond( Q );
        z2 = lthird ( Q );
    
        h1 = iprod( y1, z2 );
        h1 = iprod( h1, z2 );
        h1 = iprod( h1, z2 ); /* h1 = y1 * z2^3 */
        h2 = iprod( y2, z1 );
        h2 = iprod( h2, z1 );
        h2 = iprod( h2, z1 ); /* h2 = y2 * z1^3 */
        v  = idif ( h1, h2 );
    
        h1 = iprod( x1, z2 );
        h1 = iprod( h1, z2 ); /* h1 = x1 * z2^2 */
        h2 = iprod( x2, z1 );
        h2 = iprod( h2, z1 ); /* h2 = x2 * z1^2 */
        w  = idif ( h1, h2 );

        if( w == 0 )
        {
	    /*   P = Q oder P = -Q                               */
    
            if( v == 0 )
	    {
	        /*   P = Q ==> P + Q = 2 * P                     */
	        S = ecmcdouble( a6, P );
	        return( S );
	    }
	    else
	    {
	        /*   P = -Q ==> P + Q = ( 0 : 1 : 0 )            */
	        S = list3( 0, 1, 0 );
	        return( S );
	    }
        }
        
        if( isign( w ) < 0 )
        {
	    w = ineg( w );
	    v = ineg( v );
        }
    
        h1 = igcd (  v,  w );
        v  = iquot(  v, h1 );
        w  = iquot(  w, h1 );
        z3 = iprod( z1, z2 );
        z3 = iprod( z3,  w );
    
        x3 = iprod(  v,  v );
        h1 = iprod( z3, z3 );
        h2 = iprod( x1, z2 );
        h2 = iprod( h2, z2 );
        h1 = iprod( x2, z1 );
        h1 = iprod( h1, z1 );
        h1 = isum ( h1, h2 );
        h1 = iprod( h1,  w );
        h1 = iprod( h1,  w );
        x3 = idif ( x3, h1 );
    
        h1 = iprod(  w, z2 );
        h2 = iprod( h1, h1 );
        y3 = iprod( h2, x1 );
        y3 = idif ( y3, x3 );
        y3 = iprod( y3,  v );
        h2 = iprod( h2, h1 );
        h2 = iprod( h2, y1 );
        y3 = idif ( y3, h2 );

        S = ecipnorm( list3( x3, y3, z3 ) );

        return( S );
    }
}

static list ecmcmul( a6, P, n )
single a6, n;
list   P;
{
    bind( P );
    
    if( !n )
    {
        return( list3( 0, 1, 0 ) );
    }

    if( ispecrpai( P ) || ( n == 1 ) )
    {   
	/*   P = ( 0 : 1 : 0 ) unendlich ferner Punkt oder 1 * P   */
        return( P );
    }
    else
    {
        list Q, Pn;
        single m;
    
        init( Q, Pn );

        if( n < 0 )
        {
	     /*  Fuer n < 0:  n * Q = |n| * (-Q)   */
	     Q = ecmcneg( P );
             m = (-1) * n;
	     if( m == 1 )
	     {
	         return( Q );
	     }
        }
	else
	{
            Q = P;
	    m = n;
        }

	Pn = list3( 0, 1, 0 );

        while( 1 )
        {
            if( ( m & 01 ) == 1 )
            {
                Pn = ecmcsum( a6, Q, Pn );
            }
        
            /*   Linksshift: Multiplikation von m mit 2                 */
    
            m >>= 1;

	    if( !m )
	    {
		break;
	    }
    
            /*   Rechtsshift: letztes Bit kontrolliert Addition         */
        
            Q = ecmcdouble( a6, Q );
        }
    
        return( Pn );
    }
}


static build_COEFF( A )
list *A;
{
    list L;

    init( L );

    L     = list4( 524350420, 229503448, 552532902, 2083 );
    A[38] = list2( L, 229 );
    L     = list4( 503600257, 71784367, 848890147, 312 );
    A[37] = list2( L, 223 );
    L     = list4( 160886923, 347300394, 763140797, 6 );
    A[36] = list2( L, 6 );
    L     = list4( 669054492, 307306392, 61685762, 7 );
    A[35] = list2( L, 211 );
    L     = list4( 53246041, 210175963, 65203698, 1 );
    A[34] = list2( L, 1 );
    L     = list3( 578400573, 968274111, 171255306 );
    A[33] = list2( L, 199 );
    L     = list3( 146649327, 611707421, 25762159 );
    A[32] = list2( L, 193 );
    L     = list3( 933660192, 275536790, 20734 );
    A[31] = list2( L, 1 );
    L     = list3( 546507632, 844675467, 583849 );
    A[30] = list2( L, 181 );
    L     = list3( 155209720, 23807266, 17593 );
    A[29] = list2( L, 35 );
    L     = list3( 795607768, 1021181216, 13260 );
    A[28] = list2( L, 169 );
    L     = list3( 201000800, 406464830, 2000 );
    A[27] = list2( L, 163 );
    L     = list3( 638568116, 1026364083, 301 );
    A[26] = list2( L, 157 );
    L     = list3( 839934396, 658519038, 45 );
    A[25] = list2( L, 151 );
    L     = list2( 407307204, 51063849 );
    A[24] = list2( L, 1 );
    L     = list3( 465062496, 46580537, 1 );
    A[23] = list2( L, 139 );
    L     = list2( 775606256, 24238756 );
    A[22] = list2( L, 133 );
    L     = list2( 739115163, 25722603 );
    A[21] = list2( L, 127 );
    L     = list2( 431208325, 354905 );
    A[20] = list2( L, 11 );
    L     = list2( 630709388, 5158 );
    A[19] = list2( L, 1 );
    L     = list2( 747867949, 90269 );
    A[18] = list2( L, 109 );
    L     = list2( 676555781, 13756 );
    A[17] = list2( L, 103 );
    L     = list2( 1064825071, 2099 );
    A[16] = list2( L, 97 );
    L     = list2( 196300080, 321 );
    A[15] = list2( L, 91 );
    A[14] = list2( 621885048, 1 ) ;
    L     = list2( 606232676, 7 );
    A[13] = list2( L, 79 );
    L     = list2( 177935876, 1 );
    A[12] = list2( L, 73 );
    A[11] = list2( 193536720, 67 );
    A[10] = list2( 30045015, 61 );
    A[ 9] = list2( 85215, 1 );
    A[ 8] = list2( 735471, 49 );
    A[ 7] = list2( 116280, 43 );
    A[ 6] = list2( 18564, 37 );
    A[ 5] = list2( 3003, 31 );
    A[ 4] = list2( 99, 5 );
    A[ 3] = list2( 84, 19 );
    A[ 2] = list2( 15, 13 );
    A[ 1] = list2( 3, 7 );
    A[ 0] = list2( 1, 1 );


    return( 0 );
}

static pfel ecimeqpelp( p, a6, P, A, d )
list   P;
single p, d;
rat    a6, *A;
{
    single i;
    int    z;
    pfel   x, f, g, h;
    rat    r;

    init( x, f, g, r );
    bind( a6, P, A[0..NC] );

    z = lthird( P );
    r = itor( z );
    z = lfirst( P );
    r = rprod( r, itor( z ) );
    z = lsecond( P );
    r = rquot( r, itor( z ) );

    x = rtopfel( p, d, r );
    f = pfexp( p, x, 6 );

    h  = rtopfel( p, d, a6 );
    f = pfprod( p, f, h );
    g = 0;
    i = NC;

    while( i )
    {
        g = pfprod( p, g, f );
        h = rtopfel( p, d, A[i--] );
        g = pfsum ( p, g, h );
    }

    g = pfprod( p, g, x );

    return( g );
}

static list ell_log_ins( f, L )
pfel f;
list L;
{
    single m, n;
    list   M;
    pfel   g;

    init( M, g );
    bind( f, L );
  
    m = lsecond( f );

    M = _0;
  
    while( L != _0 )
    {
        g = lfirst( L );
        n = lsecond( g );

        if( m < n )
        {
            break;
        }
        L = lred( L );
        M = lcomp( g, M );
    }
    
    M = lcomp( f, M );

    while( L != _0 )
    {
        g = lfirst( L );
        L = lred( L );
        M = lcomp( g, M );
    }

    return( linv( M ) );
}

static int int_rep( p, c, f )
single p, c;
pfel   f;
{
    bind( f );

    if( f && ( lsecond( f ) >= c ) )
    {
        int    a;
        list   L;
        single i, n, m;
    
        init( a, L );

        L = _0;
        n = lsecond( f );
        f = lred2( f );
    
        for( i = n; i < c; i++ )
        {
            m = lfirst( f );
            f = lred( f );
            L = lcomp( m, L );
        }

        a = 0;

        while( L != _0 )
        {
            a = iprod( a, p );
            i = lfirst( L );
            a = isum( a, i );
            L = lred( L );
        }

        a = iprod( a, iexp( p, n ) );
 
        return( a );
    }   

    return( 0 );
}

/***

      elliptic curve with integer coefficients, search for all p-integer points,      bound on linear combination"
***/

static ecimeqsapipblc( E, p, s, N0, A )
list E;
int  N0;
single p, s;
rat    *A;
{
    single   d, i, n, r, c, ordp;
    list     B, P, Q, L;
    matrix   M1, M2;
    int      a, z, N, N1, a6;
    rat      a6r;
    pfel     x, f, g;
    vec      v;
    floating K, l, h, logp, c9, c12;

    bind( P, N0 );
    bind( A[0..NC] );

    init( B, P, Q, L ); 
    init( M1, M2 );
    init( a, z, N, N1, a6 ); 
    init( x, f, g );
    init( a6r );
    init( v );
    init( K, l, h, logp, c9, c12 );

    logp = fllog( itofl( p ) );
    K = fllog( itofl( N0 ) );
    K = flquot( K, logp );
    d = flround( K );

    a6r = ecraca6( E );
    a6 = rnum( a6r );

    r = ecrrank( E );
    B = ecracbmwg( E );
    N = ecrcond( E );

    if( mshom( p, N ) )
    {
        c = ecrnpmsp( E, p );
    }
    else
    {
        L = B;
        c = 1;
        while ( L != _0 ) 
        {
            P = lfirst( L );
            Q = ecmcmul( a6, P, c );
            if( mshom( p, lthird( Q ) ) )
            {
                Q = P;  
                n = 1;  
                 
                while( mshom( p, lthird( Q ) ) )
                {
                    Q = ecmcsum( a6, Q, P );
                    n++;
                }
                c = ilcm( c, n );
            }
            L = lred2( L );
        }
    }
    n = ecrordtor( E );
    i = ilcm( c, n );
    L = ecrsevrm( E );

    if( !L )
    {
        /***   Error in the computation     ***/
        /***   of the smallest eigenvalue   ***/
        return( list1( 0 ) );
    }

    c9 = lfirst( L );
    c9 = flsquot( c9, 2 * s );

    c12 = ecracdwhnth( E );
    c12 = flsquot( c12, 2 * s );   
    /***   c12 here means log c12 in the article   ***/

    L = _0;

    while( B != _0 )
    {
        P = lfirst( B );
        B = lred2 ( B );
        Q = ecmcmul( a6, P, i );
        f = ecimeqpelp( p, a6r, Q, A, d );
        L = ell_log_ins( f, L );
    }

    M1 = maconsdiag( r, 1 );

    f = lfirst( L );
    ordp = lsecond( f );
    L = lred( L );
    Q = _0;

    while( L != _0 )
    {
        g = lfirst( L );
        L = lred( L );
        x = pfquot( p, g, f );
        Q = lcomp( x, Q );
    }

    n = sexp( 2, r );
    N = N0;

    while( 1 )
    {
        K = flprod( K, itofl( r ) );
        c = 1 + flfloor( K );

        if( r > 1 )
        {
            L = Q;
            i = 1;

            while( L != _0 )
            {
                f = lfirst( L );
                L = lred( L );
    
                z = int_rep( p, c, f );
    
                masetel( M1, r, i, z );
            }
            z = iexp( p, c );
            masetel( M1, r, r, z );

            M2 = mailllred( M1 );

            a = 0;
            v = lfirst( M2 );
            while( v != _0 )
            {
                z = lfirst( v );
                a = isum( a, iprod( z, z ) );
                v = lred( v );
            }
        }
        else
        {
            a = iprod( z, z );
        }
        
        l = flsquot( itofl( a ), n );
        h = itofl( N );
        h = flprod( h, h );
        h = flprod( h, itofl( r ) );

        if( flcomp( h, l ) > 0 )
        {
            /***   Conditions of Lemma 3 are satisfied   ***/
            h  = flquot( c12, logp );
            h  = flsum ( h, itofl( ordp ) );
            h  = flsum ( h, itofl( c ) );
            h  = flprod( h, logp );
            h  = flquot( h, c9 );
            h  = flsqrt( h );
            N1 = isum( 1, flfloor( h ) );

            if( icomp( N1, N ) < 0 )
            {
                N = N1;
                K = fllog( itofl( N ) );
                K = flquot( K, logp );
            }
            else
            {
                return( N );
            }
        }
        else
        {
            /***   Conditions of Lemma 3 are not satisfied           ***/
            /***   N was probably too small. Increase N (to N^2).    ***/
        
            N = iexp( N, 2 );   
        }
    }
}
                    
static Si_test( P, Pz, PP )
list P, Pz;
int PP;
{
    single p, q;
    int    z, x;

    init( z );
    bind( P, Pz, PP );

    if( !( z = lthird( P ) ) )
    {
        return( 0 );
    }

    if( z == 1 )
    {
        return( 1 );
    }
/**
    while( Pz != _0 )
    {
        p = lfirst( Pz );
        while( 1 )
        {
            iqrem( z, p, &x, &q );
            if( q )
            {
                break;
            }
            z = x;
        }

        if( z == 1 )
        {
            return( 1 );
        }

        Pz = lred( Pz );
    }
*/
while(1)
{
    x = igcd( PP, z );
    if( x == 1 )
    { 
        if( z == 1 )
        {
            return( 1 );
        }
        return( 0 );
    }
    z = iquot( z, x );
}
    return( 0 );
}

static list findSip( E, Pz, n )
list E, Pz;
single n;
{
    single i, j, k, m, p, q, r, t;
    list B, L, M, PL, TG, T, P, *Q, *R, S;
    int  a, b, a6, PP;

    bind( E, Pz );
    init( B, L, M, PL, TG, P, S, T );
    init( a, b, a6, PP );
PP=1; L = Pz;
while( L != _0 )
{
a = lfirst( L );L = lred( L );PP= isprod( PP, a );
}

    PL = _0;
    r = ecrrank( E );
    a6 = rnum( ecraca6( E ) );

    B = ecractorgr( E );
    TG = _0;
    while( B != _0 )
    {
        T = lfirst( B );
        if( lthird( T ) )
        { 
            TG = lcomp( T, TG );
        }
        B = lred( B );
    }
    T = list3( 0, 1, 0 );
    TG = lcomp( T, TG );
    /***   TG = ( T0  T1  ...  T(t-1) ) mit T0 = ( 0 : 1 : 0 )  ***/

    L = _0;
    for( i = 0; i < r; i++ )
    { 
        L = lcomp( 0, L );
    }

    B = TG;
    i = 0;
    while( B != _0 )
    {
        T = lfirst( B );
        if( isign( lsecond( T ) ) >= 0 )
        {
            if( Si_test( T, Pz, PP ) )
            {
                S = lcomp( i, lcopy( L ) );
                PL = lcomp2( T, S, PL );
            }
        }
        i++;
        B = lred( B );
    }

    if( r )
    {
        if( ( Q = ( list * ) malloc( r * sizeof( list ) ) ) == NULL )
        { 
            return( list1( 0 ) );
        }
        if( ( R = ( list * ) malloc( r * sizeof( list ) ) ) == NULL )
        { 
            free( Q );
            return( list1( 0 ) );
        }

        i = r - 1;
        init( Q[0..i] );
        init( R[0..i] );

        B = ecracbmwg( E );
        M = B;

        for( i = 0; i < r; i++ )
        {
            R[i] = lfirst( M );
            M = lred2( M ); 
        }
        
        L = list1( 0 );
        j = (-1) * n;
        Q[0] = list3( 0, 1, 0 );
    
        for( i = 0; i < r - 1; i++ )
        {
            L = lcomp( j, L );
            S = ecmcmul( a6, R[i], j );
            Q[0] = ecmcsum( a6, Q[0], S );
        }
    
        for( i = 1; i < r; i++ )
        {
            Q[i] = Q[0];
        }
        
        q = 1;
        
        while( q )
        {
            M = L;
    
            i = -1;
            while( M != _0 )
            {
                /***   Test, if L is not the negative of a linear   ***/
                /***   combination that is already contained in PL  ***/
                /***   Let L = ( l0 l1 ... l(r-1) ) be a linear     ***/
                /***   combination. Let i = min{ j : l(j) < 0 }     ***/
                /***   L is admissible if there is an l(k) > 0,     ***/
                /***   for some k < j, i.e. L is not of the form    ***/
                /***   ( 0  ...  0  -s  ...  * ) with s > 0.        ***/
                
                if( k = lfirst( M ) )
                {
                    /***   i is the first nonzero entry in L  ***/
                    i = k;
                }
                M = lred( M );
            }
            /***   If i == 0 then L = ( 0 ...          0 )         ***/
            /***   If i >  0 then L = ( 0 ... 0  s ... * ), s > 0  ***/
            /***   If i <  0 then L = ( 0 ... 0 -s ... * ), s > 0  ***/
    
            if( i >= 0 ) 
            {
                B = TG;
                i = 0;
                while( B != _0 )
                {
                    T = lfirst( B );
                    P = ecmcsum( a6, T, Q[0] );
                    if( Si_test( P, Pz, PP ) )
                    {
                        M  = lcopy( L );
                        S  = lcomp( i, M );
                        PL = lcomp2( P, S, PL );
                    }
                    i++;
                    B = lred( B );
                }
            }
    
            M = L;
            q = 1;
     
            while( 1 )
            {
                j = lfirst( M );
             
                if( j == n )
                {
                    if( q == r )
                    {
                        /***   all linear combinations are tested ***/
                        q = 0;
                        break;
                    }
 
                    i = (-1) * n;
                    leset( L, q, i );
                    Q[q] = ecmcsum( a6, Q[q], R[q] );
                    for( i = 0; i < q; i++ )
                    {
                        Q[i] = Q[q];
                    }
     
                    M = lred( M );
                    q++;
                }
                else
                {
                    leset( L, q, j + 1 );
                    if( q == 1 )
                    {
                        Q[0] = ecmcsum( a6, Q[0], R[0] );
                    }
                    break;
                }
            }
        }
    }
    
    return( PL );
}

list ecimeqsaSip( E, P )
list E, P;
{
    single   N, r;
    list     Q;

    init( Q );
    bind( E, P );

    N = 0;

    if( r = ecrrank( E ) )
    {
        single   f, n, p, s;
        int      N0;
        rat      *A;
        floating C, lambda1, delta;

        init( C, lambda1, delta );
        init( N0 );
        A = ( list * ) malloc( ( NC + 1 ) * sizeof( list ) );
        init( A[0..NC] );
        build_COEFF( A );
    
        s = llength( P ) + 1;   
    
        f = FL_EPS;
        FL_EPS  = 5 * r + f;
        N = ecisnfsaipub( E );
        FL_EPS  = 10 * s + f;
        C = ecisnfSiphhb( E, P );
        lambda1 = lfirst( ecrsevrm( E ) );
        /**delta = ecisnfdwnth( E );**/
        delta = ecisnfdwhnth( E );
        C = flsum( C, delta );
        C = flquot( C, lambda1 );
        C = flsqrt( C );
        N0 = flround( C );
        N0 = isum( N0, 1 );

        Q = P;

        while( Q != _0 )
        {
            p = lfirst( Q );
            n = ecimeqsapipblc( E, p, s, N0, A );

            if( n > N )
            {
                N = n;
            }
            Q = lred( Q );
        }
        free( A );

        n = 0;
        FL_EPS = f;
    }
    
    Q = findSip( E, P, N );

    return( Q );
}

