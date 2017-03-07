/*
                   upgf2nbnfact(G, MT, PN, P)
                        
        "univariate polynomial over Galois-field of characteristic 2
        with coefficients in normal basis representation,
        Niederreiter factorization"
        Source library: srclib.pol3
        Include file:   _pol3.h
        list upgf2nbnfact(G, MT, PN, P)  
               obj G; list *MT; matrix PN;  pol P;
        L = upgf2nbnfact(G, MT, PN, P);
        Conditions:
        - G is an irreducible monic polynomial in one variable
          over Z/2Z of degree n in special bit representation
          (see udpm2tosb) as generating polynomial of GF(2^n).
        - *MT is a pointer on an array of (n * (n + 1) / 2 gf2-elements
          MT is the multiplication table of a normal basis of GF(2^n).
        - PN is the matrix (with rows in special bit notation) that
          transforms an element in power basis representation into
          an element in normal basis representation.
        - P is a polynomial of positive degree in one variable
          over GF(2^n) given in special bit representation with respect 
          to the normal basis corresponding to MT.
        upgf2nbnfact computes a list of all irreducible factors P_i of P
        over GF(2^n):
                  L = ( P_1  ...  P_t ) pol P_1, ..., P_t;
        P = P_1 * ... * P_t.
        The list L is ordered by the following rules:
        Let a_l and b_l be the coefficients at x^l of P_i and P_(i+1), 
        respectively. Then:
                  1. deg( P_i ) > deg( P_(i+1) ) 
                                or
                  2. deg( P_i ) == deg( P_(i+1) ) =: d and
                     a_d = b_d, a_(d-1) = b_(d-1), ..., 
                     a_(k+1) = b_(k+1) 
                                    and
                     2a. deg( a_k ) > deg( b_k ), a_k and b_k are
                         interpreted as polynomials over GF(2), 
                                      or
                     2. deg( a_k ) = deg( b_k ) and: 
                         Running from left to right through the special 
                         bit representation of a and b, b has the 
                         first 0.
        The polynomials P_i are given in special bit representation 
        with respect to the normal basis corresponding to MT.
      
        Literature: Harald Niederreiter: "Factorization of Polynomials
                    and Some Linear Algebra Over Finite Fields", 
                    Linear Algebra Appl. 192 (1993).
C*/
/*H
        Version 1       09.09.1994      Josef Gebel
	Version 2       25.10.1995      New arithmetic for matrices
                                        over GF(2). JG.
   DATE upgf2nbnfact  : 941201.951201
H*/

#include <_pol3.h>

static upgf2polcomp( G, P, Q )
pol G, P, Q;
{
    single  p, q, r;
    pol     P1, Q1;
    gf2el   a, b;

    init( P1, Q1 );
    init(  a,  b );
    bind( G, P, Q );

    P1 = pgf2sum( 1, G, P, Q );

    if( !P1 )
    {
        /***   P = Q   ***/
        return( 0 );
    }

    r = lfirst( P1 );
   
    P1 = P;
    p  = lfirst( P1 );

    while( p > r )
    {
        P1 = lred2( P1 );
        p  = lfirst( P1 );
    }
    
    Q1 = Q;
    q = lfirst( Q1 );

    while( q > r )
    {
        Q1 = lred2( Q1 );
        q  = lfirst( Q1 );
    }
    if( P1 == _0 )
    {
        /***   Q = P + R, deg( R ) >= 0   ***/
        return( -1 );
    }

    if( Q1 == _0 )
    {
        /***   P = Q + R, deg( R ) >= 0   ***/
        return( 1 );
    }
        
    if( p > q )
    {
        /***   a_n = b_n, ..., a_(p+1) = b_(p+1), a_p != 0, b_p = 0 ***/
        return( 1 );
    }

    if( q > p )
    {
        /***   a_n = b_n, ..., a_(p+1) = b_(p+1), a_p = 0, b_p != 0 ***/
        return( -1 );
    }

    /***   a_n = b_n, ..., a_(p+1) = b_(p+1), a_p != 0, b_p != 0    ***/
    /***   Find out, which a_p or b_p has higher degree (as a       ***/
    /***   polynomial over GF(2)). Note: a_p != b_p.                ***/

    a = lsecond( P1 );
    b = lsecond( Q1 );

    while( 1 )
    {
        p = lfirst( a );
        q = lfirst( b );

        if( p > q )
        {
            return( 1 );
        }

        if( q > p )
        {
            return( -1 );
        }

        a = lred( a );
        b = lred( b );

        if( b == _0 )
        {
            return( 1 );
        }

        if( a == _0 )
        {
            return( -1 );
        }
    }
}

/*c
                  factor_insert( L, P, e )
          "factor insertion"
          static list factor_insert( L, P, e ) list L; pol P; single e;
          M = factor_insert( L, P, e );
          L = ( P_1  ...  P_t ) (see documentation of 'upgfnb2fact' 
          above) P is an irreducible polynomial in GF(2^n), e > 0.
          M = ( P_1  ...  P_s  P  ...  P  P_(s+1)  ...  P_t )
                               e times
          such that M is ordered by the rules at the end of the
          documentation of 'upgf2nbnfact' above.
c*/

static list factor_insert( G, L, P, e )
pol    G, P;
list   L;
single e;
{
    single n, f;
    list   K, M;
    pol    Q, R;
    gf2el  a, b;

    init( K, M );
    init( Q, R );
    init( a, b );
    bind( G, L, P );

    K = L;
    M = _0;
    f = 0;
    n = 1;

    while( K != _0 )
    {
        Q = lfirst ( K );
        f = lsecond( K );
             
        if( ( n = upgf2polcomp( G, P, Q ) ) >= 0 )
        {
            break;
        }
    
        M = lcomp2( f, Q, M );
        K = lred2 ( K );
    }

    if( n )
    {
        /***   P was not yet in the list   ***/
        f = e;
    }
    else
    {
        /***   P was already in the list   ***/
        f += e;
        K = lred2( K );
    }

    M = lcomp2( f, P, M );
    
    while( K != _0 )
    {
        /***   Enter the rest of K into M   ***/
        Q = lfirst ( K );
        f = lsecond( K );

        M = lcomp2( f, Q, M );
        K = lred2 ( K );
    }

    return( linv( M ) );
}

/*c
                 is_pol_one( P, n )
          "is polynomial one?"
          static is_pol_one( P, n ) pol P; single n;
          s = is_pol_one( P, n );
          n = field degree of the Galois field (over GF(2))
          P is a polynomial in GF(2^n) with coefficients in normal
          basis representation.
          s = 1, if P = 1, i.e. 1 * x^0
              0  otherwise.
c*/

static is_pol_one( P, n )
pol P;
single n;
{
    /***   The coefficients of P are given in special bit notation  ***/
    /***   and represented with respect to a normal basis           ***/
    bind( P );

    if( !lfirst( P ) )
    {
        /***   deg( P ) = 0   ***/
        single a1, e, m;
        gf2el a;

        init( a );

        a = lsecond( P );

        /***   1 has the representation [111....111]    ***/
        /***   <--> a = ( n  u  v  ...  v ) with        ***/
        /***   u = 0...01...1  n % 30 times '1'         ***/
        /***   v = 001111...1      30 times '1'         ***/
        /***   v appears n : 30 + 1 times in a.         ***/
        /***   ( u does not appear if n % 30 = 0 )      ***/
    
        a1 = lfirst( a );

        if( n - a1 - 1 )
        {
            /***   degree of a != (n-1) ==> a != 1      ***/
            return( 0 );
        }
        
        a = lred( a );
        a1 = lfirst( a );

        /***   Test if a1 == u ( u described as above ) ***/

        if( m = n % 30 )
        {
            a = lred( a );
        }

        while( m )
        {   
            if( !( a1 & 1 ) )
            {
                return( 0 );
            }
            m--;
            a1 >>= 1;
        }

        /***   Test if all other entrie in 


        m = ( 1 << 30 ) - 1;
        /***   m = 001111...1  (30   times '1' )     ***/

        while( a != _0 )
        {
            a1 = lfirst( a );
            if( !( a1 & m ) )
            {  
                return( 0 );
            }
            a = lred( a );
        }
        return( 1 );
    }
    return( 0 );
}

/*c
                 get_coeff( P, i )
          "get coefficient"
          static gf2el get_coeff( P, i )    pol P;    single i;
          a = get_coeff( P, i );
          s = is_pol_one( P, n );
          P is a polynomial in GF(2^n) with coefficients in normal
          basis representation. 
          0 <= i <= k where k = degree( P ).
          Then P = a_k * x^k + a_(k-1) + x^(k-1) + .. + a_1 x + a_0.
          Return value: a = a_i
c*/

static gf2el get_coeff( P, i )
pol    P;
single i;
{
    if( P )
    {
        single j;

        bind( P );

        while( 1 )
        {
            j = lfirst( P );
            if( i >= j )
            {
                if( i == j )
                {
                    return( lsecond( P ) );
                }
                return( 0 );
            }
            P = lred2( P );
        }
    }
    return( 0 );
}

/*c
                set_up_solve_K_q( G, f, MT, d, n )
          "set up and solve matrix K_q"
          static set_up_solve_K_q( G, f, MT, d, n ) 
                  pol G, f; list *MT; single d, n;
          s = set_up_solve_K_q( G, f, MT, d, n )
          G is the definig polynomial of the Galois field GF(2^n)
          f is a polynomial in GF(2^n) of degree d with coefficients 
          in normal basis representation. 
          MT is the adress of athe multiplication table of the normal
          basis
          d and n are the degrees of G and f, respectively, as 
          mentioned above.
          set_up_solve_K_q( G, f, MT, d, n ) sets up the 
          matrix K_q as descibed in the paper of Niederreiter.
          s = dim( null space of K ).
c*/

static set_up_solve_K_q( G, f, MT, d, n )
pol    G,   /***   G in GF(2)[X], defining polynomial of GF(2^n)    ***/
       f;   /***   f in GF(2^n)[x], polynomial to factor            ***/
list   *MT; /***   Multiplication table in GF(2^)                   ***/
single d,   /***   degree of the polynomial f                       ***/
       n;   /***   field degree (= degree of G)                     ***/
{
    pol    g;
    single i, j, k, k1, kn, l, a1, b1, c1, sa, sb, ta, tb, 
           nb, pb, qb, mb, xa, xb; 
    gf2el  a, b, c;
    matrix K; 

    bind( G, f );

    init( K, a, b, c );

    k = d * n;
    K = mam2conszero( k, k );

    /*****************************************************************/
    /***   Set up the matrix K_{2^n}( f )           (Beginning)   ****/
    /*****************************************************************/

    /***              k1                                           ***/
    /***             ----                      2                   ***/
    /***   Compute   \     f         *  h  -  h                    ***/
    /***             /____  2*j+1-k      k     j                   ***/
    /***            k = k0                                         ***/

    pb = ( ( n - 1 ) * n ) / 2; 
        
    for( j = 0; j < d; j++ )
    {
        /***   k0 = max{ 2 * j + 1 - d, 0 }   ***/
        /***   k1 = min{ 2 * j + 1, d - 1 }   ***/

        if( ( k = 2 * j + 1 - d ) < 0 )
        {
            k = 0;
        }
  
        if( ( k1 = 2 * j + 1 ) > d - 1 )
        {
            k1 = d - 1;
        }

        l = 2 * j + 1 - k;
        kn = ( d - k - 1 ) * n;

        /***          2                                           ***/
        /***   Enter h  into the matrix K                         ***/
        /***          j                                           ***/

        qb = j * n;
        mb = qb + n;
        i = ( d - j ) * n;

        nb = mb - 1;
        do 
        {
               mam2setel( K, nb, i, 1 );
               i--;
               nb--;
        }
        while( nb > qb );
        mam2setel( K, mb, i, 1 );
        /***   h_j^2 entered in K.                                 ***/

        while( k <= k1 )
        {
            if( c = get_coeff( f, l ) )
            {
                sb = n;
                i = kn;
                xb = pb;

                while( sb )
                {
                    xb += sb;
                    sb--;
                    xb -= n;
                    i++;

                    a = c;

                    ta = 1 + lfirst( a );
                    if( !( a1 = ta % 30 ) )
                    {
                        ta -= 30;
                    } 
                    else
                    {
                        ta -= a1;
                    }
        
                    a = lred( a );

                    /***   Compute  beta^(2^sb) * a,    ***/
                    /***   beta = normal element        ***/
                
                    b = 0;

                    while( a != _0 )
                    {
                        a1 = lfirst( a );
                        sa = ta; 
                        xa = ( ( ( n << 1 ) - sa - 1 ) * sa ) >> 1;

                        while( a1 )
                        {
                            if( a1 & 1 )
                            {
                                /***  Let su = min{ sa, sb } and    ***/
                                /***      sv = max{ sa, sb }. Then  ***/
                                /***               ( su + 1 ) * su  ***/
                                /***  xu = su * n - --------------- ***/
                                /***                      2         ***/
                                /***  (u = a, v = b or u = b, v = a)***/
                                /***  and MT[xu + sv] = beta^(2^i)  ***/
 
                                if( sa > sb )
                                {
                                    b = gf2sum( G, b, *( MT + sa + xb ) );
                                }
                                else
                                {
                                    b = gf2sum( G, b, *( MT + sb + xa  ) );
                                }
                            }
    
                            a1 >>= 1;
                            xa += n;
                            sa++;
                            xa -= sa;
                        }
                        ta -= 30;
                        a = lred( a );
                    }
          
                    /***  Here b = beta^(2^sb) * a    ***/

                    nb = lfirst( b ) / 30;
                    mb = ( j + 1 ) * n - nb * 30;
   
                    b = lred( b );
 
                    while( b != _0 )
                    {
                        b1 = lfirst( b );
                        nb = mb;
    
                        while( b1 )
                        {
                            if( b1 & 1 )
                            {
                                c1 = mam2selel( K, nb, i );
                                c1 ^= 1;
                                mam2setel( K, nb, i, c1 );
                            }
                            nb--;
                            b1 >>= 1;
                        }
        
                        b = lred( b );
                        mb += 30;
                    }
                }
                while( sb );
            }
            kn -= n;
            k++;
            l--;
        }
    }
    return( mam2nsb( K ) );
}

/*c
                     islm2ero( w )
          "is list of elements from GF(2) zero?"
          static single islm2zero( w ) list w;
          s = islm2zero( w );
          w is a list of elemnets from GF(2) of length > 0.
          s = 0, if w has at least one entry different from 0,
              1, if w = ( 0  0  ...  0 ).
c*/

static single islm2zero( w )
list w;
{
    bind( w );
 
    while( w != _0 )
    {
        if( lfirst( w ) )
        {
            return( 0 );
        }
        w = lred( w );
    }
    return( 1 );
}

/*c
                  static lm2listins( L, v )
          "list of elements from GF(2) list insert"
          static lm2listins( L, v ) list L, v;
          M =  lm2listins( L, v )
          L is a list of lists of elements from GF(2) in 
          lexicographical order.
          If the list v is the zero list or if v is already in L, 
          then L remains unchanged.
          If v != 0 is not yet in L, then v is inserted in L such 
          that L stays in lexicographical order.
*/

static list lm2listins( L, v )
list L, v;
{
    if( islm2zero( v ) )
    {
        return( L );
    }
    if( L == _0 )
    {
        return( list1( v ) );
    }
    else
    {
        single a, b, f;
        list   M, w, x;
    
        init( M, w, x );
        bind( L, v );
    
        M = _0;
        f = 1;
    
        while( L != _0 )
        {
            w = lfirst( L );

            if( f )
            {
                /***   v is not yet inserted and a w in L    ***/
                /***   with v = w has not yet been found     ***/
                x = v;
                while( w != _0 )
                {
                    a = lfirst( x );
                    b = lfirst( w );
                    w = lred( w );
                    x = lred( x );
                    if( a ^ b )
                    {
                        /***   v and w are different    ***/
                        /***   at this place            ***/
                        if( b )
                        {
                            M = lcomp( v, M );
                            f = 0;
                            w = _0;
                        }
                        break;
                    }
                    if( x == _0 )
                    {
                        /***   v == w: v must not be inserted in M  ***/
                        f = 0;
                    }
                }
            }
            w = lfirst( L );
            M = lcomp( w, M );
            L = lred( L );
        }

        if( f )
        {
            M = lcomp( v, M );
        }
        M = linv( M );
        return( M );
    }
}

isinlcl( w, M ) 
list w, M;
{
    list L, v;

    init( v );

    bind( w, M );
 
    while( M != _0 )
    {
        v = lm2sum( lfirst( M ), w );
        if( islm2zero( v ) )
        {
            return( 1 );
        }
        M = lred( M );
    }
    return( 0 );
}

/*c
                     make_pol( n, d, v )
          "make polynomial"
          static pol make_pol( n, d, v ) single n, d; list v;
          L = make_pol( n, d, v );
          P = make_pol( n, d, v );
          n is the degree of the Galois field F = GF(2^n), 
          n*d is the length of the list v of elements from GF(2).
          v = ( v_(n-1,d-1) ... v_(n-1,0)  v_(n-2,d-1) ... v_(0,0) ) 
          with v_(i,j) in GF(2).
          make_pol builds up the polynomial 
              P = a_(d-1) * x^(d-1) + ... + a_1 * x + a_0,
          where a_i is an element of GF(2^n) in special bit 
          representation with respect to a normal basis. Let b be the
          normal element of GF(2^n) that induces the basis. Then
              a_i = v_(n-1,i) * b^(2^(n-1)) + ...
                           ... + v_(1,i) * b^2 + v_(0,1i) * b
          Return: P (described as above)
c*/

static pol make_pol( n, d, v )
single n, d;
list v;
{
    single c, e, f, g, i, j, k, m, s;
    list   b, w;
    pol    P;

    init( P, b );
    
    P = _0;
    w = lcinv( v );
    e = 1;

    m = lfirst( w );
    w = lred( w );

    f = 0;
    c = 0;
    g = ( 1 << 30 );
    
    while( 1 )
    {
        b = _0;
        j = -31;
        f = 0;
        k = 1;

        for( i = 0; i < n; i++ )
        {
            if( e & m ) 
            {
                f |= k; 
            }
            e <<= 1;
            if( e == g )
            {
                if( w != _0 )
                {
                    m = lfirst( w );
                    w = lred( w );
                    e = 1;
                }
            }
            k <<= 1;
            if( k == g )
            {
                j += 30;
                b = lcomp( f, b );
                f = 0;
                k = 1;
            }
        }
        if( k != g )
        {
            j += 30;
            b = lcomp( f, b );
        }

        while( ( b != _0 ) && !lfirst( b ) )
        {
            j -= 30;
            b = lred( b );
        }
        if( b != _0 )
        {
            s = lfirst( b );
            while( s ) 
            {
                s >>= 1;
                j++;
            }
            b = lcomp( j, b );
            P = lcomp2( c, b, P );
        } 
        c++;
        if( c == d )
        {
            break;
        }
    }

    if( P == _0 )
    {
        return( 0 );
    }

    return( P );
}

/*c
                upgf2nbnfacts( G, P1, P, MT, PN, E, a, n, d )
          "univariate polynomial over Galois field with 
           characteristic 2, factoization (special verison)" (recursive)
          static list upgf2nbnfacts( G, P1, P, MT, PN, E, a, n, d )
           obj G; pol P1, *P; list *MT, PN, E; gf2el a; single d, n;
          L = upgf2nbnfacts( G, P1, P, MT, PN, E, a, n, d );
          G is the generating polynomial of the Galois field 
            F = GF(2^n),
          n is the degree of F,
          P is a polynomial in GF(2^n)[x],
          d is the degree of P,
          MT is the adress of the multiplication table of a normal 
            basis of F,
          PN is the transformation matrices from normal basis
            to power basis representation and vice versa, respectively,
          E = ( ( e1  Q1 )  ...  ( er  Qr ) )  
                      single e1, ..., er; pol Q1, ..., Qr;
          with irreducible polynomials Qi over GF(2^n) and exponents
          ei > 0.  Let Q = Q1^(e1) * ... * Qr^(er).
          upgf2nbnfacts( G, P, MT, PN, E, a, n, d ) is part of the 
          factorization of the polynomial R = P * Q over GF(2^n).
          Q is the part of R that has already been factored, 
          P is the part of R that is not yet factored.
          Return: list L = ( ( e'1 Q'1 )  ... ( e'r' Q'r' ) ) 
                  (Q'i and e'i as in the list above), where 
                  P * Q = Q'1^(e'1) * ... * Q'r'^(e'r').
          The list L is ordered as the list F at the end of the 
          documentation of 'upgf2nbnfact'.
c*/

static list upgf2nbnfacts( G, P1, P, MT, PN, E, n, d )
obj    G;
pol    P1, *P;
list   *MT, PN, E;
single d, n;
{
    single i, j, l, e, k, z;
    list   F, LC, K, L, M, Q, pN, w, v;
    pol    R, S;

    bind( G, P1, PN, *P, E );
    init( F, LC, K, L, M, Q, pN, w, v );
    init( R, S );

    if( ( pN = set_up_solve_K_q( G, P1, MT, d, n ) ) < 0 )
    {
        /***   System of linear equations K * x = 0 unsolvable ***/
        return( ERROR );
    }
    pN = lred( pN );

    if( ( i = llength( pN ) ) == 1 )
    {
        /***   P1 = Q1^m  with Q1 irreducible    ***/
        /***   Find Q2 such that                ***/
        /***      P1 = Q2^k                      ***/
        /***   with m = 2^l * k and k odd       ***/

        pol T;

        init( T );

        R = P1;
        e = 1;
        
        while( lfirst( R ) )
        {
            T = R;
            R = upgf2nbsqrt( G, T );
        }

        if( lfirst( T ) > 1 )
        {
            /***   T is maybe a power of an  ***/
            /***   irreducible polynomial    ***/

            k = lfirst( T );
            R = pgf2deriv( 1, G, T );
            S = upgf2nbgcd( G, MT, T, R );
            T = upgf2nbquot( G, MT, T, S );
        }

        S = upgf2nbgcd( G, MT, T, *P );
        if( lfirst( S ) )
        {
            R = *P;
            e = -1;
            do
            {
                *P = R;
                R = upgf2nbqrem( G, MT, R, T, &S );
                e++;
            }
            while( !S );

            F = factor_insert( G, E, T, e );
        }
        return( F );
    }

    F = E;
    LC = pN;
    j = 0;
    L = LC;
    while( L != _0 )
    {
        e = d - 1;
        w = lfirst( L );
        L = lred( L );
        if( ( R = make_pol( n, e, w ) ) 
        &&  ( z = lfirst( R ) ) )
        {
            /***   R != constant polynomial             ***/
            /***   P = R * Q1:                          ***/
            /***   First factor R and then factor Q1    ***/
            
            S = upgf2nbgcd ( G, MT, *P, R );

            if( z = lfirst( S )  )
            {
                /***   S = gcd( R, P ) is not a unit:   ***/
                /***   Factor S and add the irreducible ***/
                /***   factors of S to the list F.      ***/
                F = upgf2nbnfacts( G, S, P, MT, PN, F, n, z );
 
                if( ( z = lfirst( *P ) ) < 2 )
                {
                    /***   P either is a unit           ***/
                    /***   or has degree 1              ***/
                    /***       ==> P irreducible        ***/
                    if( z )
                    {
                        /***   deg( P ) = 1             ***/
                        /***   ==> P irreducible        ***/
                        F = factor_insert( G, F, *P, 1 );
                        *P = upgf2nbquot( G, MT, *P, *P );
                    }
                    return( F );
                }
            }
        }
    }

    while( --i )
    {
        M = _0;
        L = LC;
        for( l = 0; l < j; l++ )
        {
            /***   The first j vectors have already been used   ***/
            L = lred( L );
        }
       
        while( L != _0 )
        {
            v = lfirst( L );
            L = lred( L );
            K = pN;
            while( K != _0 )
            {
                w = lfirst( K );
                w = lm2sum( v, w );
                if( !islm2zero( w ) && !isinlcl( w, M ) 
                                    && !isinlcl( w, LC ) )
                {
                    j++;
        
                    if( ( R = make_pol( n, e, w ) ) 
                    &&  ( z = lfirst( R ) ) )
                    {
                        /***   R != constant polynomial             ***/
                        /***   P = R * Q1:                          ***/
                        /***   First factor R and then factor Q1    ***/
            
                        S = upgf2nbgcd ( G, MT, *P, R );
                        if( z = lfirst( S ) )
                        {
                            /***   S = gcd( R, P ) is not a unit:   ***/
                            /***   Factor S and add the irreducible ***/
                            /***   factors of S to the list F.      ***/
                            F = upgf2nbnfacts( G, S, P, MT, PN, F, n, z );
            
                            if( ( z = lfirst( *P ) ) < 2 )
                            {
                                /***   P either is a unit           ***/
                                /***   or has degree 1              ***/
                                /***       ==> P irreducible        ***/
                                if( z )
                                {
                                    /***   deg( P ) = 1             ***/
                                    /***   ==> P irreducible        ***/
                                    F = factor_insert( G, F, *P, 1 );
                                    *P = upgf2nbquot( G, MT, *P, *P );
                                }
                                return( F );
                            }
                        }
                    }
                    M = lcomp( w, M );
                }
                K = lred( K );
            }
        }

        while( LC != _0 )
        {
            v = lfirst( LC );
            M = lcomp( v, M );
            LC = lred( LC );
        }

        LC = M;
    }
    return( F );
}
            

/**********************************************************************/
/***  M  A  I  N    P  A  R  T   O  F   T  H  E   M  O  D  U  L  E  ***/
/**********************************************************************/

list upgf2nbnfact( G, MT, PN, P )
obj    G;
list   *MT;
matrix PN;
pol    P;
{
    if( !P )
    {
        return( ERROR );
    }
    else
    {
        single d, n, k;
        list   F;
        pol    Q;
    
        bind( G, PN, P );

        init( Q );
        init( F );

        n = lfirst( G );
        
        /***   Make P monic                       ***/
        P = upgf2nbmonic( G, MT, P );
         
        /***   Factor x = ( x - 0 ) out of P(x)   ***/

        Q = lcinv( P );
        k = lsecond( Q );
        F = _0;
        if( k )
        {
            /***   x | P(x)   ***/
            single l;
            gf2el  a;
            list   L;

            init( a );
            init( L );

            a = list2( 0, 1 );
            a = gf2elsbbt( G, PN, a );     
            /***   a = 1 in normal basis representation   ***/

            L = list2( 1, a );

            P = _0;

            while( Q != _0 )
            {
                l = lsecond( Q ) - k;
                a = lfirst ( Q );
                P = lcomp2( l, a, P );
                Q = lred2( Q );
            }

            while( k )
            {
                F = lcomp( L, F );
                k--;
            }
        }

        d = lfirst( P );
        while( d )
        {
            Q = P;
            F = upgf2nbnfacts( G, Q, &P, MT, PN, F, n, d );
            d = lfirst( P );
        }
        return( F );
    }
}
