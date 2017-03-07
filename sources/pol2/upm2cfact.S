/*M
.SH NAME
upm2cfact - univariate polynomial over modular 2, complete factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upm2fact( P )  
pol P;
.SH DESCRIPTION
.TP 4
.B P
is a polynomial of positiv degree in one variable over GF(2).
.PP
upm2fact computes a list of all irreducible factors P_i of P
over GF(2):
.IP
L = ( P_1 e_1 ...  P_t e_t ) pol P_1, ..., P_t;
    single e_1, ..., e_t;
.PP
where
.IP
P = P_1^e_1 * ... * P_t^e_t, e_i > 0.
.PP
The list L is ordered by the following rules:
 1. deg( P_i ) > deg( P_(i+1) ) > 0 or
 2. deg( P_i ) = deg( P_(i+1) ) > 0 and:
    Let d = deg( P_i - P_(i+1) ). Then:
    The term x^d appears in P_i and not in P_(i+1)
.SH EXAMPLES
 P_i = x^3 + x^2 + 1, P_(i+1) = x^3 + x + 1
 P_i - P_(i+1) = x^2 + x ==> d = 2 and
 x^2 appears in P_i(x) but not in P_(i+1)(x).
.SH SEE ALSO
Literature: Harald Niederreiter: 
            "Factorization of Polynomials and Some Linear 
             Algebra Over Finite Fields",
            Linear Algebra Appl. 192 (1993).

M*/

/*H
	Version 1       09.09.1994      Josef Gebel
   DATE upm2cfact     : 951201
H*/

#include <_pol2.h>

/*c
                  f_insert_2( L, P, e )
          "factor insertion"
          static list f_insert_2( L, P, e ) list L; pol P; single e;
          M = f_insert_2( L, P, e );
          L = ( P_1  ...  P_t ) (see documentation of 'upm2fact' above)
          P is an irreducible polynomial in GF(2), e > 0.
          M = ( P_1  ...  P_s  P  ...  P  P_(s+1)  ...  P_t )
                               e times
          such that M is ordered by the rules at the end of the
          documentation of 'upm2fact' above.
c*/

static list f_insert_2( L, P, e )
list   L;
pol    P;
single e;
{
    single p, q, f;
    list   K, M;
    pol    Q, R;

    init( K, M );
    init( Q, R );
    bind( L, P );

    K = L;
    M = _0;
    f = 0;
    
    while( K != _0 )
    {
        Q = lfirst( K );
        f = lsecond( K );
        R = P;
 
        while( 1 ) 
        {
            p = lfirst( Q );
            q = lfirst( R );

            if( p - q )
            {
                if( p > q )
                {
                    p = -1;
                }
                break;
            }
            if( ( Q == _0 ) && ( R == _0 ) )
            {
                /***   P = Q ***/
                p = -1;
                q = -1;
                break;
            }
            Q = lred2( Q );
            R = lred2( R );
        }

        if( p < 0 )
        {  
            break;
        }

        Q = lfirst( K );
        M = lcomp2( f, Q, M );
        K = lred2( K );
    }

    if( q < 0 )
    {
        f += e;
        K = lred2( K );
    }
    else 
    {
        f = e;
    }

    M = lcomp2( f, P, M );

    while( K != _0 )
    {
        /***   Enter the rest of K into M   ***/
        Q = lfirst( K );
        f = lsecond( K );
        M = lcomp2( f, Q, M );
        K = lred2( K );
    }
    L = linv( M );
    return( L );
}

/*c
                set_up_solve_M_2( f, d, pX, pN )
          "set up and solve matrix M_2"
          static set_up_solve_M_2( f, d, pX, pN ) 
                  pol f; list *pN; single d; vec *pX;
          s = set_up_solve_M_2( f, d, pX, pN )
          f is a polynomial in GF(2) of degree d.
          d > 0 is the degrees of f.
          *pX will be a special solution of M_2 * x = 0, 
          *pN will be a set of basis vectors of the null space of M_2.
          set_up_solve_M_2( f, d, pX, pN ) sets up the 
          matrix M_2 as descibed in the paper of Niederreiter.
          s = dim( null space of M_2 .
c*/

static set_up_solve_M_2( f, d, pX, pN )
pol    f;   /***   f in GF(2)[x], polynomial to factor              ***/
list   *pN; /***   list of basis vectors of the null space of M2    ***/
vec    *pX; /***   special solution of M2 * x = 0                   ***/
single d;   /***   degree of the polynomial f                       ***/
{
    single i, j, k, *c;
    matrix M2; 
    vec    v, w; 

    bind( f );

    init( M2, v, w );

    c = ( single * ) calloc( d + 1, sizeof( single ) );
    while( f != _0 )
    {
        i    = lfirst ( f );
        c[i] = lsecond( f );
        f    = lred2  ( f );
    }

    M2 = _0;
    v  = _0;

    /*****************************************************************/
    /***                                                           ***/
    /***      S e t u p   o f   t h e   m a t r i x   M _ 2        ***/
    /***                                                           ***/
    /*****************************************************************/

    for( i = d; i; i-- )
    {
        k = 2 * i - d;
        w = _0;
        for( j = d; j; j-- )
        {
            if( ( k > d ) || ( k < 0 ) )
            {
                w = lcomp( 0, w );
            }
            else
            {
                if( i - j )
                {
                    w = lcomp( c[k], w );
                }
                else
                {
                    w = lcomp( 1 ^ c[k], w );
                }
            }
            k++;
        }
        M2 = lcomp( w, M2 );    
        v  = lcomp( 0,  v );    
        /***    Construction of the d-dimensional zero vector   ***/
    }
    
    free( c );

    /*****************************************************************/
    /***                                                           ***/
    /***      S o l u t i o n   o f    M _ 2   *   x   =   0       ***/
    /***                                                           ***/
    /*****************************************************************/

    k = mamsssle( 2, M2, v, pX, pN );

    return( k );
}

/*c
                     isvzero( w )
          "is vector zero vector?"
          static single isvzero( w ) vec w;
          s = isvzero( w );
          w is a vector over GF(2) of length > 0.
          s = 0, if w has at least one entry different from 0,
              1, if w = ( 0  0  ...  0 ).
c*/

static single isvzero( w )
vec w;
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
                  static vlinsert( L, v )
          "vector list insert"
          static vlinsert( L, v ) list L; vec v;
          M =  vlinsert( L, v )
          L is a list of vectors in lexicographical order.
          If the vector v is the zero vector or if v is already in L, 
          then L remains unchanged.
          If v != 0  is not yet in L, then v is inserted in L such 
          that L stays in lexicographical order.
*/

static list vlinsert( L, v )
list L;
vec v;
{
    if( isvzero( v ) )
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
        list M;
        vec w, x;
    
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
                        /***   v = w: v must not be inserted in M   ***/
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

/*c
                     lin_comb( N, S )
          "linear combinations" (recursive)
          static list lin_comb( N, S ) list N, S;
          L = lin_comb( N, S );
          S and N are lists of vectors of length m over GF(2),
          S is not empty.
          S = ( s1  s2  ...  sl  ), N = ( n1  n2  ...  nk ).
          L = list of all vectors 
              s1 + a1 * n1 + ... + ak nk,
                         :
                         :
              sl + a1 * n1 + ... + ak nk,
              where ai runs through { 0, 1 }.
c*/

static list lin_comb( L, N )
list L, N;
{
    if( N == _0 )
    {
        return( L );
    }
    else
    {
        single i, j;
        vec    v, w;
        list   K, M;
        
        init( v, w );
        init( K, M );
        bind( L, N );

        M = L;
        K = N;
       
        while( K != _0 )
        {
            v = lfirst( K );
            M = vlinsert( M, v );
            while( L != _0 )
            {
                w = lfirst( L );
                w = vecmssum( 2, v, w );
                M = vlinsert( M, w );
                L = lred( L );
            }
            K = lred( K );
        }
        return( lin_comb( M, lred( N ) ) );
    }
}
    
/*c
                     vectopol( d, v )
          "vector to polynomial"
          static pol vectopol( d, v ) single d; vec v;
          P = vectopol( d, v );
          d is the length of the vector v.
          v = ( v_(d-1) ... v_0 ) with v_i in GF(2).
          vectopol builds up the polynomial 
              P = v_(d-1) * x^(d-1) + ... + v_1 * x + v_0,
          Return: P.
c*/

static pol vectopol( d, v )
single d;
vec v;
{
    single e;
    pol    P;

    init( P );

    P = _0;
    e = 0;

    while( v != _0 )
    {
        if( lfirst( v ) )
        {
            P = lcomp2( e, lfirst( v ), P );
        }
        e++;
        v = lred( v );
    }
    
    return( P );
}

/*c
                upm2facts( P1, P, E, d, l )
          "univariate polynomial over modular 2,
           factoization (special verison)" (recursive)
          static list upm2facts1( P1, P, E, d, l )
                  pol P1, *P; list E; single d, l;
          L = upm2facts1( P1, P, E, d, l );
          P is a polynomial in GF(2)[x],
          d is the degree of P,
          E = ( ( e1  Q1 )  ...  ( er  Qr ) )  
                      single e1, ..., er; pol Q1, ..., Qr;
          with irreducible polynomials Qi over GF(2^n) and exponents
          ei > 0.  Let Q = Q1^(e1) * ... * Qr^(er).
          upm2facts1( P1, P, E, d, l ) is part of the 
          factorization of the polynomial R = P * Q over GF(2).
          Q is the part of R that has already been factored, 
          P is the part of R that is not yet factored.
          Return: list L = ( ( e'1 Q'1 )  ... ( e'r' Q'r' ) ) 
                  (Q'i and e'i as in the list above), where 
                  P * Q = Q'1^(e'1) * ... * Q'r'^(e'r').
          The list L is ordered as the list F at the end of the 
          documentation of 'upm2fact'.
c*/

static list upm2sqrt( P )
pol P;
{
    list  Q;
    single a, n; 
 
    init( Q );
    bind( P );

    if( !P )
    {
        return( list1( 0 ) );
    }
   
    Q = _0;
    while( P != _0 )
    {
        n = lfirst ( P );
        if( n % 2 )
        {
            return( list1( 0 ) );
        }
        n >>= 1;
        a = lsecond( P );
        Q = lcomp2( a, n, Q );
        P = lred2( P );
    }
    return( linv( Q ) );
}

static list upm2facts( P1, P, E, d, l )
pol    P1, *P;
list   E;
single d, l;
{
    single e, k, z;
    list   F, LC, pN;
    vec    w, v, pX;
    pol    R, S;
    
    bind( *P, P1, E );
    init( F, LC, pN );
    init( w, v, pX );
    init( R, S );

    if( ( z = set_up_solve_M_2( P1, d, &pX, &pN ) ) < 0 )
    {
        /***   System of linear equations K * x = 0 unsolvable ***/
        return( ERROR );
    }

    if( z == 1 )
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
            R = upm2sqrt( T );
        }

        if( lfirst( T ) > 1 )
        {
            /***   T is maybe a power of an  ***/
            /***   irreducible polynomial    ***/

            k = lfirst( T );
            R = pmsderiv( 1, 2, T );
            S = upmsgcd( 2, T, R );
            T = pmsquot( 1, 2, T, S );
        }

        S = upmsgcd( 2, T, *P );
        if( lfirst( S ) )
        {
            R = *P;
            e = -1;
            do
            {
                *P = R;
                R = pmsqrem( 1, 2, R, T, &S );
                e++;
            }
            while( !S );

            e *= l;
            F = f_insert_2( E, T, e );
        }
    
        return( F );
    }

    F = E;
    LC = lin_comb( _0, pN );

    if( !isvzero( pX ) )
    {
        pN = _0;
        while( LC != _0 )
        {
            w = lfirst( LC );
            w = vecmssum( 2, pX, w );
            pN = lcomp( w, pN );
        }
        LC = pN;
    }

    while( LC != _0 )
    {
        w  = lfirst( LC );
        
        LC = lred( LC );

        e = d - 1;

        if( ( R = vectopol( e, w ) ) && ( z = lfirst( R ) ) )
        {
            /***   R != constant polynomial                 ***/
            /***   Q = R * Q1: First factor R and then Q1   ***/

            S = upmsgcd( 2, R, *P );
            if( z = lfirst( S ) )
            {
                /***   S = gcd( R, P ) is not a unit:       ***/
                /***   Factor S and add the irreducible     ***/
                /***   factors of S to the list F.          ***/
                F = upm2facts( S, P, F, z, l );

                if( ( z = lfirst( *P ) ) < 2 )
                {
                    /***   P either is a unit                     ***/
                    /***   or has degree 1 (==> P  irreducible)   ***/
                    if( z )
                    {
                        /***   deg( P ) = 1 ==> P irreducible    ***/
                        F = f_insert_2( F, *P, l );
                        *P = list2( 0, 1 );
                    }
                    return( F );
                }
            }
        }
    }

    return( F );
}
            
list upm2cfact( P )
pol  P;
{
    if( !P )
    {
        return( ERROR );
    }
    else
    {
        single d, l;
        list   F;
        pol    Q, R;
    
        bind( P );

        init( F, Q, R );

        /***   Split of the maximal power d of x that divides P(x)  ***/

        R = list2( 1, 1 );
        d = 0;

        while( 1 )
        {
            Q = pmsqrem( 1, 2, P, R, &F );
            if( F )
            {
                break;
            }
            d++;
            P = Q;
        }

        if( d )
        {
            /***   Q represents the polynomial x = 1 * x^1  ***/
            F = list2( R, d );
        }
        else
        {
            F = _0;
        }

        /***   Now: gcd( x, P(x) ) = 1   ***/

        l = 1;
        Q = P;
                   
        do
        {
            l <<= 1;
            P = Q;
            Q = upm2sqrt( P );
        }
        while( lfirst( Q ) );
        l >>= 1;

        while( d = lfirst( P ) )
        {
            Q = P;
            F = upm2facts( Q, &P, F, d, l );
        }

        return( F );
    }
}


