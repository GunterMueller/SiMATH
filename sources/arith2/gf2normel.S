/*M
.SH NAME
gf2normel - Galois-field of characteristic 2 element in normal basis representation inversion

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2normel( G )
obj G;

a = gf2normel( G );

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B a  
is a normal element of F over F2 given in special bit notation,
i.e. an element a in F for which the set
   B = {a, a^2, a^(2^2), ..., a^(2^(n-1))}
forms a basis of F over F2.
 a != 0, in case of success
 a =  0, otherwise.

.SH LIERATURE
Joachim von zur Gathen, Mark Giesbrecht: 
"Constructing normal bases in finite fields",
J. Symbolic Computation (1990) 10, pp 547-570.

.SH SEE ALSO
.BR gf2nbcons()
.BR udpm2tosb()
M*/

/*H
	Version 1	08.09.1994	 Josef Gebel
	Version 2       25.10.1995       New arithmetic for matrices
                                         over GF(2). JG.
	Version 3	09.10.96	error corrected. Andreas Stein.
   DATE gf2normel	: 941201.951201.961201
H*/


#include<_arith2.h>

static insert( S, b, i, n )
matrix S;
gf2el  b;
single i, n;
{
    gf2el  a;
    single j, k, m;

    bind( S, b );
    init( a );

    a = lcopy( lred( b ) );
    a = linv( a );
    k = 0;

    while( a != _0 )
    {
        m = lfirst( a );
        j = k;
        while( m )
        {
            j++;
            mam2setel( S, j, i, m & 1 );
            m >>= 1;
        }
        k += 30;
        a = lred( a );
    }
}

/*c
        static matrix get_sigma( G ) pol G;
        S = get_sigma( G );
        G is an irreducible polynomial over GF(2) with degree n > 0.
        G is regarded as the defining polynomial of the field 
        GF(2^n). Let X be a formal zero of the polynomial G.
        S = ( s_{i,j} ) 0 <= i, j <= n - 1 where
          X^(2 * i) = s_{i,0} + s_{i_1} * X + s_{i,2} * X^2 + ... 
                      ... + s_{i,n-1} * X^(n-1)
        for i = 0, ..., n - 1.
c*/

static matrix get_sigma( G )
pol   G;
{
    single i, j, k, n;
    gf2el  a, b;
    matrix S;

    bind( G );
    init( a, b, S );

    n = lfirst( G );

    S = mam2conszero( n, n );

    b = list2( 0, 1 ); /***   b = 1                          ***/
    a = list2( 1, 2 ); /***   a = X = formal zero of G(x)    ***/
    a = gf2squ( G, a );
    i = 1;

    while( 1 )
    {
/*
printf(" b = ");putbits( lred(b) ); printf("\n");
*/
        insert( S, b, i, n );
        i++;
        if( i > n )
        {
            return( S );
        }
        b = gf2prod( G, a, b );
    }
}

static isinkernel( v, M )
list   v;
matrix M;
{
    list a, b;

    bind( v, M );
    init( a, b );

    M = lred( M );

    while( M != _0 )
    {
        a = lfirst( M );
        if( lm2sprod( a, v ) )
        {
            return( 0 );
        }
        M = lred( M );
    }
    return( 1 );
}

/*c
        static islm2inlist( v, L ) list v, L;

        v is a list of elements from GF(2) and 
        L is a list of lists of elements from GF(2)
        s = islm2inlist( v, L );
        s = 1, if v is in L
            0  otherwise.
c*/

static islm2inlist( v, L )
list v, L;
{
    single a;
    list   M, u, w;

    bind( v, L );
    init( u, w, M );

    M = lred( L );
   
/*
printf(" M = %l\n", M );
*/
    while( M != _0 )
    {
        u = v;
        w = lfirst( M );
/*
printf(" u = %obj\n", u );
printf(" w = %obj\n", w );
*/
        while( w != _0 )
        {
            a  = lfirst( u );
            a -= lfirst( w );
            if( a )
            { 
                break;
            }
            u = lred( u );
            w = lred( w );
        }
     
        if( !a )
        {
            /***   v = w   ***/
/*
printf(" islm2: 1\n" );
*/
            return( 1 );
        }

        M = lred( M );
/*
printf(" M = %l\n", M );
*/
    }
    
/*
printf(" islm2: 0\n" );
*/
    return( 0 );
}

/*c
        static gf2el lm2togf2el( G, v ); pol  G; list  v;
        b = lm2togf2el( G, v );
        G is a polynomial over GF(2) with degree n > 1,
        v = ( v_0, ..., v_n-1 ) is a list of elements from GF(2) with 
        length n.
        b = v_0 + v_1 * X + ... + v_n-1 * X^(n-1)
        is an element of GF(2^n) in special bit notation, 
        where X is a formal zero of G(x).
c*/

static gf2el lm2togf2el( G, v )
pol  G;
list v;
{
    single i, j, k, m, n;
    gf2el  a;

    init( a );
    bind( G, v );

    a = _0;
    n = lfirst( G ) % 30;
    if( !n )
    {
        n = 30;
    }
    n--;
   
    k = ( 1 << n );
    i = 1;
    j = 0;
    n = 0;
    m = lfirst( v );

/*
printf(" v = %obj\n", v );
printf("0: i = %d  j = %d  k = %d  m = %d  n = %d\n", i, j, k, m, n );
*/

    while( 1 )
    {
        if( m & k )
        {
            j ^= i;
        }
        i <<= 1;
        k >>= 1;
/*
printf("1: i = %d  j = %d  k = %d  m = %d  n = %d\n", i, j, k, m, n );
*/
        if( !k )
        {
            v = lred( v );
            if( v == _0 )
            {
                a = lcomp( j, a );
                break;
            }
            k = ( 1 << 29 );
            m = lfirst( v );
        }
/*
printf("2: i = %d  j = %d  k = %d  m = %d  n = %d\n", i, j, k, m, n );
*/
        if( !( i - ( 1 << 30 ) ) )
        {
            n += 30;
            a = lcomp( j, a );
            j = 0;
            i = 1;
        }
/*
printf("3: i = %d  j = %d  k = %d  m = %d  n = %d\n", i, j, k, m, n );
*/
    }

/* The following loop inserted for correctness */

    while ( !(j = lfirst( a ) ) ) {
	a = lred( a );
	n -= 30;
    }

/* The last loop inserted for correctness */

    while( j )
    {
        j >>= 1;
        n++;
    }
    n--;
     
    a = lcomp( n, a );
    return( a );
}


/*c
       static matrix evalpol( Q, S, n ) pol Q; matrix S; single n;
       M = evalpol( Q, S, n );
       Q = x^m + a_(m-1) * x^(m-1) + ... + a_0 is a polynomial 
       with coefficients in GF(2), S is the (n x n) matrix Sigma 
       defined in 'get_sigma' above.
       M = Q(S) = S^m + a_(m-1) S^(m-1) + ... + a_0 * E_n,
       where E_n is the (n x n) unit matrix.
       Evaluation of the polynomial is done by Horner schema.
c*/

static matrix evalpol( Q, S, n )
pol    Q;
matrix S;
single n;
{
    matrix A, E, T;
    pol    P;

    init( A, E, T, P );

    P = ptodp( 1, Q );
    P = lred2( P );

    A = S;
    T = mam2transp( S );
    E = mam2um( n );

    while( 1 )
    {
        if( lfirst( P ) )
        {
            A = mam2sum( A, E );
        }
        P = lred( P );
        if( P == _0 )
        {
            return( A );
        }
        A = mam2tprod( A, T );
    }
}

gf2el gf2normel( G )
pol   G;
{
    single   n,   /***   degree of the field / polynomial  ***/
             k,   /***   maximal number of choices         ***/
             i;
    gf2el    a, b;
    list     L, K1, K2, v, w;
    matrix   S, M1, M2, N1;
    pol      P, Q;
matrix   N2;init(N2);

    init( a, b );
    init( L, K1, K2 );
    init( S, M1, M2, N1 );
    init( v, w );
    init( P, Q );

    bind( G );
    n = lfirst( G );

    P = list4( n, 1, 0, 1 );
    L = upm2cfact( P );
    S = get_sigma( G );
/*
printf(" S = \n");N2 = mam2tomams( S );printmat(N2);getchar();
*/
    w = 0;

    while( L != _0 )
    {
        Q = lfirst( L );
        k = lsecond( L );
/*
printf(" Q = %obj    k = %d\n", Q, k ); 
printf("I  VOR EVA\n");stoptime( 0 );
*/
        M2 = evalpol( Q, S, n );
/*
printf("M2 = \n");N2 = mam2tomams( M2 );printmat(N2);getchar();
*/

/*
printf("I NACH EVA\n");stoptime( 1 );
*/

        if( k > 1 )
        {
            M1 = mam2exp( M2, k - 1 );
/*
printf("II: M1 = \n");N2 = mam2tomams( M1 );printmat(N2);
*/
            M2 = mam2prod( M1, M2 );
/*
printf("II: M2 = \n");N2 = mam2tomams( M2 );printmat(N2);
*/
            N1 = lcopy( M1 );
/*
printf("I  VOR NSB  M1 = %obj\n", M1);stoptime( 0 );
*/
            K1 = mam2nsb( M1 );
/*
printf("I NACH NSB\n");stoptime( 1 );
*/
        }
        else
        {
            K1 = _0;
        }

/*
printf("II  VOR NSB\n");stoptime( 0 );
*/
        K2 = mam2nsb( M2 );
/*
printf("II NACH NSB\n");stoptime( 2 );
printf(" K2 = %obj\n  =", K2 );
printf(" K2 = \n");N2 = mam2tomams( K2 );printmat(N2);getchar();
*/
        K2 = lred( K2 );
/*
printf(" K2 = %obj\n  =", K2 );getchar();
*/

        while( K2 != _0 )
        {
            v = lfirst( K2 );
/*
printf(" v = %obj\n  =", v );
putbits( v );printf("\n");
printf(" w = %obj\n   = ", w );
if( w ) putbits( w );printf("\n");
if( K1 != _0 ) { printf(" K1 = \n");N2 = mam2tomams( K1 );printmat(N2);getchar(); }
*/
            if( ( K1 == _0 )
             || ( !islm2inlist( v, K1 ) && !isinkernel( v, N1 ) ) )
            {
                if( w )
                {
                    w = lm2sum( w, v );
                } 
                else
                {
                    w = v;
                } 
                break;
            }
            K2 = lred( K2 );
        }

        L = lred2( L );
    }


printf("\ngf2normel:\n w(object) == %obj\n", w );printf("\n");
printf(" w(gf2) == ");putgf2elb(lcomp(n,w));printf("\n");
printf("\nn = %i",n);

    a = lm2togf2el( G, w );


printf(" a(object) == %obj\n", a );printf("\n");
printf(" a(gf2) == ");putgf2elb( a);printf("\n");


    return( a );
}
