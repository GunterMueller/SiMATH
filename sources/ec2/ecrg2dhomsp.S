/*M
.SH NAME
ecrg2dhomsp - curve over the rational numbers, general 2-descent, homogeneous spaces

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecrg2dhomsp(E)
list E;

.SH DESCRIPTION
ecrg2dhomsp() returns a list H
containing a complete set of representatives of the non-trivial
elements of the 2-Selmer group Sel[2] of E/Q, i.e. a list
.PP
      H = ( C1  ...  Cs )  list C1, ..., Cs;
.PP
where the lists Ci represent non-trivial equivalence classes of
homogeneous spaces. Each list Ci has the form
.PP
.nf
Ci = ( L[i,1] ...  L[i,k(i)] )  list L[i,1], ..., L[i,k(i)];

with k(i) >0 and L[i,j]= ( L1[i,j] L2[i,j] ) where

L1[i,j]=( a[i,j] b[i,j] c[i,j] d[i,j] e[i,j] )
int a[i,j], b[i,j], c[i,j], d[i,j], e[i,j];

L2[i,j]=( t[i,j] s[i,j] x1[i,j] x2[i,j] x3[i,j] x4[i,j] )
single t[i,j], s[i,j];
floating/complex x1[i,j], x2[i,j], x3[i,j], x4[i,j];

It holds for L1, L2 that


 (*)  y^2 = a[i,j]x^4 + b[i,j]x^3 + c[i,j]x^2+ d[i,j]x+ e[i,j]

is a quartic equation describing the homogeneous space representing
the class Ci.

t[i,j] is the type of the quartic (see Cremona's book).
 
s[i,j] = 0 if the pair (I,J) belonging to the quartic is minimal,
s[i,j] = 1 otherwise.

The values x1[i,j], x2[i,j], x3[i,j], x4[i,j] are the 4 
(complex) roots of the right hand side polynomial of (*). 
There are 3 case to consider.

1) If there are 4 real roots (type t[i,j] = 2),
   then x1[i,j]< x2[i,j]< x3[i,j]< x4[i,j].

2) If there are 2 real and 2 complex roots (type t[i,j] = 3),
   then x1[i,j]< x2[i,j] are real and 0<Im(x3[i,j])= -Im(x4[i,j]).

3) If there are 4 complex roots (type t[i,j] = 1),
   then Re(x1[i,j])=Re(x2[i,j])<Re(x3[i,j])=Re(x4[i,j])
   and 0<Im(x1[i,j])= -Im(x2[i,j]) and 0<Im(x3[i,j])= -Im(x4[i,j]).

.fi
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH REFERENCES
J.E. Cremona, "Algorithms for modular elliptic curves.",
Cambridge University Press (1992)

.SH SEE ALSO
ecrinit
M*/
/*H
        Version 1       01.12.1996      Josef Gebel
        Version 2       15.02.1998      Bug fix (static function 'quartics'). JG
   DATE   ecrg2dhomsp : 961201
H*/


#include <_ec2.h>

#define FF 0.01
#define FSMAX 1073741823.0
#define p12 12
#define p5   5
#define p7   7
#define p11 11
#define p13 13

floating tol, tol3, one;
complex  c_one;

/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                        BEGINNING of the static part                    **/
/**                                                                        **/
/****************************************************************************/
/****************************************************************************/

static get_roots_q( a, b, c, d, e, s, H, K, X )
single a, b, c, d, e, s;
floating H, K, X;
{
    single   type;
    floating f1, f2, l1, l2, p1, p2, q1, q2;
    list     U, V, W;

    init( f1, f2, l1, l2, p1, p2, q1, q2 );
    init( U, V, W );
    bind( H, K, X );

    U = _0;
    W = _0;

    f1 = itofl( a * a );
    f2 = flquot( K, f1 );
    f1 = flprod( f1, itofl( 6 ) );
    f1 = flquot( H, f1 );
    l1 = flprod( f1, f1 );
    l1 = fldif ( l1, f2 );
    l1 = flsqrt( l1 );

    l2 = fldif ( f1, l1 );
    l1 = flsum ( f1, l1 );

    f1 = itofl( b );
    f1 = flsquot( f1, 2 * a );
    f2 = fldif( X, itofl( 2 * c ) );
    f2 = flsquot( f2, 3 * a );
    p1 = flprod( f1, f1 );
    p1 = flsum ( p1, f2 );
    p1 = flsqrt( p1 );

    p2 = fldif ( f1, p1 );
    p1 = flsum ( f1, p1 );

    q1 = flprod( p1, p1 );
    q1 = flsum ( q1, l1 );
    q1 = flsquot( q1, 4 );

    q2 = flprod( p2, p2 );
    q2 = flsum ( q2, l2 );
    q2 = flsquot( q2, 4 );
    f1 = flsquot( p1, -2 );
    f2 = flprod( f1, f1 );
    f2 = fldif ( f2, q1 );

    if( flsign( f2 ) >= 0 )
    {
        /**   real roots  **/
        l1 = flsqrt( f2 );
        f2 = fldif ( f1, l1 );
        f1 = flsum ( f1, l1 );

        U = lcomp2( f1, f2, U );
    }
    else
    {
        /**   (conjugate) complex roots  **/
        complex c1, c2;

        init( c1 );

        l1 = flsqrt( flabs( f2 ) );
        c1 = ccri( f1, l1 );
        l2 = flneg( l1 );
        c2 = ccri( f1, l2 );
        W  = lcomp2( c1, c2, W );
    }

    f1 = flsquot( p2, -2 );
    f2 = flprod( f1, f1 );
    f2 = fldif ( f2, q2 );

    if( flsign( f2 ) >= 0 )
    {
        /**   real roots  **/
        l1 = flsqrt( f2 );
        f2 = fldif ( f1, l1 );
        f1 = flsum ( f1, l1 );

        U = lcomp2( f1, f2, U );
    }
    else
    {
        /**   (conjugate) complex roots  **/
        complex c1, c2;

        init( c1, c2 );

        l1 = flsqrt( flabs( f2 ) );
        c1 = ccri( f1, l1 );
        l2 = flneg( l1 );
        c2 = ccri( f1, l2 );
        W  = lcomp2( c1, c2, W );
    }

    if( U == _0 )
    {
        V = W;
        type = 1;
    }
    else if( W == _0 )
    {
        V = U;
        type = 2;
    }
    else
    {
        V = lconc( U, W );
        type = 3;
    }

    V = lcomp2( type, s, V );

    U = list5( a, b, c, d, e );
    W = list2( U, V );

    return( W );
}

static lift( p, q, a, b, c, d, e, i, j, A )
single p, q, a, b, c, d, e, i, j;
char   *A;
{
    single aq, bq, cq, dq, eq, ad, ae, a12, a27, bd, b3, b27, c2, q27, u, v;
    single qq, qp, z;
    char   *adr1, *adr2, *B;

    qq = q * q;
    adr2 = A + qq * a;
    qq *= p;
    qp  = q * p;
 
    z = p * q;

    q27 = mshom( q, -27 );
    aq = a;
    while( 1 )
    {
        adr1 = adr2 + b * q;
        a27 = msprod( q, aq, q27 );
        a12 = msprod( q, aq,  12 );
	
        bq = b;
        while( 1 )
        {
            B = adr1 + c;

            b27 = mshom( q, bq * bq * q27 ); /** -27 * b^2  **/
            b3  = mshom( q, bq * (-3) ); /** -3 * b  **/
            cq = c;
            while( 1 )
            {
                if( !( *B ) )
                {
                    c2 = msprod( q, cq, cq );

                    dq = d;
                    while( 1 )
                    {
                        ad = mshom( q, j + dq * dq * a27 );
                        bd = msprod( q,  b3, dq );
    
                        eq = e;
                        while( 1 )
                        {
                            ae = msprod( q, a12, eq );
                            u = ae + bd + c2 + i;
                            while( u >= q )
                            {
                                u -= q;
                            }
 
                            if( !u )
                            {
                                u = mshom( q, ae * 6 );
                                v = mshom( q, 3 * bd + 2 * c2 );
                                u -= v;
                                if( u < 0 )
                                {
                                    u += q;
                                }
                                u = msprod( q, cq, u );
                                u += ad;
                                if( u >= q )
                                {
                                    u -= q;
                                }
                                u += msprod( q, eq, b27 );
                                if( u >= q )
                                {
                                    u -= q;
                                }
                                if( !u )
                                {
                                    *B = 1;
                                    z--;
                                }
                            }
                            if( !u || ( ( eq = eq + p ) >= q ) )
                            {
                                break;
                            }
                        }
                        if( !u || ( ( dq = dq + p ) >= q ) )
                        {
                            break;
                        }
                    }
                }
                cq += p;
                if( cq >= q )
                {
                    break;
                }
                B += p;
            }
            bq += p;
            if( bq >= q )
            {
                break;
            }
            adr1 += qp;
        }
        aq += p;
        if( aq >= q )
        {
            return( z );
        }
        adr2 += qq;
    }
}

static make_sieve( p, A, I, J )
single p;
char   *A;
int    I, J;
{
    single a, b, c, d, e, i, j, q, iq, jq;
    single a12, a27, a72, ac72, ace72, ad27, ae12;
    single b3, b9, b27, bb, bc9, bcd9, bd3;
    single c2, c3, dd, q9, q12, q27, q72;
    char *Aa, *Ab, *Ac;

    bind( I, J );

    i = mshom( p, I );
    j = mshom( p, J );
    q = p * p;
    if( iq = mshom( q, I ) )
    {
        iq = q - iq;
    }
    if( jq = mshom( q, J ) )
    {
        jq = q - jq;
    }

    q72 = mshom( p, 72 );
    q27 = mshom( p, -27 );
    q12 = mshom( p, 12 );
    q9  = mshom( p, 9  );
    a72 = 0;
    a27 = 0;
    a12 = 0;

    a = 0;
    Aa = A;
    while( 1 )
    {
        b27 = 0;
        b9  = 0;
        b3  = 0;
        bb  = 0;

        b = 0;
        Ab = Aa;
        while( 1 )
        {
            bc9  = 0;
            ac72 = 0;
            c2   = 0;
            c3   = 0;
            c    = 0;
            Ac = Ab;
            while( 1 )
            {
                bcd9 = c3 + c3 + j;
                while( bcd9 >= p )
                {
                    bcd9 -= p;
                }
                if( bcd9 )
                {
                    bcd9 = p - bcd9;
                }
                /***   bcd9 <--  9 * b * c * d - 2 * c^3 - J  mod p  ***/

                bd3 = c2 - i;
                if( bd3 < 0 )
                {
                    bd3 += p;
                }
                /***   bcd9 <--  -3 * b * d + c^3 - I  mod p  ***/

                ad27 = 0;
                dd   = 0;

                d = 0;
                while( 1 )
                {
                    ae12  = bd3;
                    /***   ae12 <-- 12 * a * e - 3 * b * d + c^3 - I  ***/

                    ace72 = bcd9;
                    ace72 += ad27;
                    if( ace72 >= p )
                    {
                        ace72 -= p;
                    }
                    /***   ace72 <-- 72 * a * c * e + 9 * b * c * d   ***/
                    /***             - 27 * a * d^2 - 27 * b^2 * e    ***/
                    /***             - 2 * c^3 - J  mod p             ***/

                    e = 0;
                    while( 1 )
                    {
                        if( !ae12 && !ace72 )
                        {
                            if( p < 7 )
                            {
                                if( !lift( p, q, a, b, c, d, e, iq, jq, A ) )
                                {
                                    e = p - 1;
                                    d = e;
                                }
                            }
                            else 
                            {
                                e = p - 1;
                                d = e;
                                *Ac = 1;
                            }
                        }
                        if( !( (++e) - p ) )
                        {
                            break;
                        }
                        ae12 += a12;
                        if( ae12 >= p )
                        {
                            ae12 -= p;
                        }
                        ace72 += ac72;
                        ace72 += b27;
                        while( ace72 >= p )
                        {
                            ace72 -= p;
                        }
                    }
                    if( !( (++d) - p ) )
                    {
                        break;
                    }
                    bd3 += b3;
                    if( bd3 >= p )
                    {
                        bd3 -= p;
                    }
                    ad27 += dd;
                    dd   += a27;
                    ad27 += dd;
                    while( ad27 >= p )
                    {
                        ad27 -= p;
                    }
                    if( dd >= p )
                    {
                        dd -= p;
                    }
                    bcd9 += bc9;
                    if( bcd9 >= p )
                    {
                        bcd9 -= p;
                    }
                }
                c3 += c2;
                c3 += c2;
                c3 += c;
                c2 += c;
                if( !( (++c) - p ) )
                {
                    break;
                }
                Ac++;
                c2 += c;
                while( c2 >= p )
                {
                    c2 -= p;
                }
                c3 += c2;
                while( c3 >= p )
                {
                    c3 -= p;
                }
                ac72 += a72;
                if( ac72 >= p )
                {
                    ac72 -= p;
                }
                bc9 += b9;
                if( bc9 >= p )
                {
                    bc9 -= p;
                }
            }
            if( !( (++b) - p ) )
            {
                break;
            }
            Ab += p;
            b9  += q9;
            b3  -= 3;
            b27 += bb;
            bb  += q27;
            b27 += bb;
            if( b9 >= p )
            {
                b9 -= p;
            }
            if( b3 < 0 )
            {
                b3 += p;
            }
            while( b27 >= p )
            {
                b27 -= p;
            }
            if( bb >= p )
            {
                bb -= p;
            }
        }
        if( !( (++a) - p ) )
        {
            break;
        }
        Aa += q;
        a72 += q72;
        a27 += q27;
        a12 += q12;
        if( a72 >= p )
        {
            a72 -= p;
        }
        if( a27 >= p )
        {
            a27 -= p;
        }
        if( a12 >= p )
        {
            a12 -= p;
        }
    }
    return( 0 );
}

/****************************************************************************/
/**   static list get_d_e( a, b, c, x, h, H, K, I, J, s )                  **/
/**           int a, b, c, I, J;   floating x, h, H, K;  single s;         **/
/**   get_d_e computes the values for d and e such that the quartics       **/
/**   ( a  b  c  d  e ) and, if b != 0, ( a  -b  c  d  e ), respectively,  **/
/**   are 2-coverings of E/Q with invariants I and J (cf. Cremona's book). **/
/**   s = 0 if ( I, J ) is minimal, s = 1 otherwise.                       **/
/**   If both values d and e are integral the 4 roots x1, x2, x3, x4 of    **/
/**             g(x) = a x^4 +/- b x^3 + c x^2 + d x + e = 0               **/
/**   are computed and the list L is returned where                        **/
/**      L = _0, ( W ) or ( W1  W2 ) (depending on how many 2-coverings    **/
/**   were found) and W respecively W1, W2 have the form ( U  V )          **/
/**   with U = ( a  +/-b  c  d  e ) and W = ( t  s  x1  x2  x3  x4 ),      **/
/**     x1 < x2 < x3 < x4 if all roots are real (type t = 2, s as above)   **/
/**     x1 < x2, Re(x3) = Re(x4), 0 > Im(x3) = -Im(x4) if there are        **/
/**        2 real roots x1, x2 and 2 complex roots x3, x4 (type t = 3)     **/
/**     Re(x1) = Re(x2) < Re(x3) = Re(x4), 0 > Im(x1) = -Im(x2),           **/
/**        0 > Im(x3) = -Im(x4) if there are 4 complex roots (type t = 1)  **/
/****************************************************************************/

static list get_d_e( a, b, c, I, J, l1, l2, p1, p2, s, X )
single a, b, c, s;
int    I, J;
double l1, l2, p1, p2;
{
    single d, e, i, type;
    double q1, q2, f1, f2;

    static is_q_trivial();

    bind( I, J );

    /**   Look for d and e first with parameters ( a  b  c )  **/
    /**   and the with parameters ( a  -b  c )                **/
    i = 2;
    while( i )
    {
        q1 = ( l1 + p1 * p1 ) / 4.0;
        q2 = ( l2 + p2 * p2 ) / 4.0;
        f1 = ( p1 * q2 + p2 * q1 ) * a;

        e = 0;

        f2 = floor( f1 );
        if( fabs( f2 ) > FSMAX )
        {
            e = 0;
        }
        else if( ( f1 - f2 ) < FF )
        {
            d = ( single ) f2;
        }
        else if( ( 1.0 + f2 - f1 ) < FF )
        {
            d = 1 + ( single ) f2;
        }
        else 
        {
            e = 1;
        }
        if( !e )
        {
            /**  d = [f2] and f2 is close to an integer **/

            f1 = a * q1 * q2;
            f2 = floor( f1 );
            if( fabs( f2 ) > FSMAX )
            {
                f1 = -1.0;
            }
            else if( ( f1 - f2 ) < FF )
            {
                e = ( single ) f2;
                f1 = 1.0;
            }
            else if( ( 1.0 + f2 - f1 ) < FF )
            {
                e = 1 + ( single ) f2;
                f1 = 1.0;
            }
            else 
            {
                f1 = -1.0;
            }
            if( f1 > 0.0 )
            {
                /**  e = [f2] and f2 is close to a non-zero integer **/
                /**  Check conditions on I and J                    **/
   
                int f, g, h, j;

                init( f, g, h, j );

                f = iprod ( c,  c );
                g = iprod ( b,  d );
                g = isprod( g,  3 );
                h = iprod ( a,  e );
                h = isprod( h, 12 );
                j = isum( f, h );
                j = idif( g, j );
                
                if( !isum( I, j ) )
                {
                    /***   I = 12 a e - 3 b d + c^2   ***/
 
                    h = isprod( h, 6 );
                    g = isprod( g, 3 );
                    f = isprod( f, 2 );

                    h = idif( f, h );
                    h = idif( h, g );
                    g = iprod( d, d );
                    h = iprod( h, c );
                    g = iprod( g, a );
                    f = iprod( b, b );
                    f = iprod( f, e );
                    g = isum( f, g );
                    g = isprod( g, 27 );
                    j = isum( g, h );
        
                    if( e && !isum( J, j ) )
                    {
                        /**  J = 72 a c e + 9 b c d                     **/
                        /**      - 27 a d^2 - 27 e b^2 - 2 c^3          **/
                        /**  The quartic y^2 = g(x) where               **/
                        /**   g(x) = a x^4 + b x^3 + c x^2 + d x + e    **/
                        /**  is a 2-covering of E/Q.                    **/
                        /**  Compute the roots of g(x) = 0. Use g(x) =  **/
                        /**  ( x^2 + p1 x + q1 ) * ( x^2 + p2 x + q2 )  **/
 
                        list     W;
                        floating H, K;

                        init( W, H, K );

                        K = itofl( isprod( I, 4 ) );
                        H = flprod( X, X );
                        K = fldif ( K, H );
                        K = flsquot( K, 3 );

                        H = flprod( X, itofl( 2 * a ) );
                        H = flsum ( H, itofl( 8 * a * c - 3 * b * b ) );

                        W = get_roots_q( a, b, c, d, e, s, H, K, X );

                        if( ( type == 1 ) || !is_q_trivial( W ) )
                        {
                            /**   quartic is not trivial                 **/
                            /**   (if type = 1: 4 complex (non-real)     **/
                            /**    i.e. no rational roots: not trivial)  **/
                            return( W );
                        }
                    }
                }
            }
        }
        if( b )
        {
            /**   ( a  b  c ) <-- ( a  -b  c )   **/
            i--;

            b  = -b;
            f2 = -p1;
            p1 = -p2;
            p2 = f2;
        }
        else
        {
            /**   b = 0:  ( a  b  c ) = ( a  0  c  ) = ( a  -b  c )   **/
            i = 0;
        }
    }
    return( _0 );
}

/****************************************************************************/
/**   static int issquare( a )   int a;                                    **/
/**   Return value: b in |N if b * b = a, -1 otherwise.                    **/
/****************************************************************************/

static issquare( a )
single a;
{
    single b, c;

    if( a < 0 )
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
/**   static single ordp( p, a )                                           **/
/**   int p, a;                                                            **/
/**   p is a prime and a is an integer.                                    **/
/**   Return: l such that p^l | a and a != 0 mod p^(l+1) if a != 0         **/
/**           2^28 (as a substitute for infinity) if a = 0.                **/
/****************************************************************************/

static ordp( p, a )
int p, a;
{
    if( a )
    {
        int    q, r;
        single e;

        bind( a, p );
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

/************************************************************************/
/**  static p_adic_sq( a, p, l )                                       **/
/**  int a, p;  single l;                                              **/
/**  a is an integer, p is a prime.                                    **/
/**  Either a = 0 or p^l | a and a != 0 mod p^(l+1).                   **/
/**  Return: 1, if a is a p-adic square, i.e. a = 0 or                 **/
/**             l is even and a/p^l is a quadratic residue mod p.      **/
/**          0  otherwise.                                             **/
/************************************************************************/

static p_adic_sq( a, p, l )
int a, p;
single l;
{
    if( a )
    {
        bind( a, p );

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


/************************************************************************/
/**  static Zp_soluble( a, b, c, d, e, p, x, n )                       **/
/**  int a, b, c, d, e, p, x;  single n;                               **/
/**  Return: 1, if y^2 = g(x) = a x^4 + b x^3 + c x^2 + d x + e        **/
/**             is soluble modulo p^n.                                 **/
/**          0  otherwise.                                             **/
/************************************************************************/

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

/************************************************************************/
/**  static Qp_soluble( a, b, c, d, e, p )                             **/
/**  int a, b, c, d, e, p;                                             **/
/**  Return: 1, if y^2 = g(x) = a x^4 + b x^3 + c x^2 + d x + e        **/
/**             is soluble in the field of p-adic numbers (Q_p.        **/
/**          0  otherwise.                                             **/
/************************************************************************/

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

/************************************************************************/
/**   "is quartic not locally soluble"                                 **/
/**   static isquartnls( L, B )   list L, B;                           **/
/**   L = ( a  b  c  d  e ) int a, b, c, d, e;                         **/
/**   B = ( p_1  ...  p_r ) int p1, ..., p_r; list of `bad' primes.    **/
/**   Return: p, if for some prime p the quartic equation              **/
/**                y^2 = g(x) = a x^4 + b x^3 + c x^2 + d x + e        **/
/**              is not soluble in the field Q_p of p-adic numbers     **/
/**           0, if y^2 = g(x) is locally soluble for all primes in B. **/
/************************************************************************/

static isquartnls( L, B )
list L, B;
{
    int  a, b, c, d, e;
    floating h;
    list M;

    init( M, h, a, b, c, d, e );

    bind( L );
        
    a = lfirst ( L );
    b = lsecond( L );
    c = lthird ( L );
    d = lfourth( L );
    e = lfifth ( L );

    /***   Test if there are any `small' (global) solutions     ***/
    /***   y^2 = g(x) globally ==> everywhere locally soluble   ***/
    h = itofl( 8 );
    M = ecrsolve2c( a, b, c, d, e, 0, h, 0, h );

    if( llength( M ) != 3 ) 
    {
        /***   There are no small solutions   ***/
        int p;

        init( p );

        bind( B );

        while( B != _0 )
        {
            p = lfirst( B );
            B = lred( B );
    
            if( !Qp_soluble( a, b, c, d, e, p ) )
            {
                return( p );
            }
        }
    }
    return( 0 );
}

/****************************************************************************/
/**   static list quartics( M, D, B, QL, s )                               **/
/**          list M, D, B, QL;  single s;                                  **/
/**   M = ( I  J )  int I, J;  Invariants                                  **/
/**   D = ( d_1 ... d_k ) int d_1, ..., d_k;  list of all divisors of      **/
/**               d = 4 I^3 - J^2 whose square also divides d              **/
/**   B = ( p_1  ...  p_k )  single p_1, ..., p_k;       bad primes        **/
/**   QL = _0 or ( L_1 ... L_m ) containing quartics that were already     **/
/**               discovered (for L_j see below (Return))                  **/
/**   s = 0 if ( I  J ) is the 'minimal' pair ( I_0  J_0 )                 **/
/**     = 1 if ( I  J ) = ( 16*I_0  64*J_0 )                               **/
/**   Find all quartics ( a  b  c  d  e ) with invariants I and J,         **/
/**   test them for local solubility in |R and (Q_p for all p in B and     **/
/**   determine the equivalence classes for the (everywhere locally        **/
/**   soluble) quartics that were found.                                   **/
/**   Return: list L = ( L_1  ...  L_k ) list L_1, ..., L_k;               **/
/**        with k = 2^s - 1 where 2^s = #Sel[2]                            **/
/**        (k = 2^s - 1 since the trivial class is missing)                **/
/**      L_i = ( L_i,1  ...   L_i,l(i) )  list L_i,1, ..., L_i,l(i);       **/
/**        with l(i) >= 1 and                                              **/
/**      L_i,j = ( ( a_i,j  b_i,j  c_i,j  d_i,j  e_i,j )                   **/
/**                ( t_i,j  s_i,j  x1_i,j  x2_i,j  x3_i,j  x4_i,j ) )      **/
/**      (see 'get_d_e()' for details).                                    **/
/****************************************************************************/

/****************************************************************************/
static list quartics( M, D, B, QL, s )
list   M, D, B, QL;
single s;
{
    single a, b, c, d, e, A1, B1, C1, aa, a2, b1, b2, i, type;
    int    I, J, N;
    list   P, Q, L;
    floating X, X1, X2;
    double x, x1, x2, x3, x4, x5, x6, x7;
    double a3, f, g, h, k, l1, l2, m, p1, p2; 
    double F, H, K, Id;

    single   P12, PP12, PPP12, bb12;
    char     *Ap12, *a12, *A12, *b12, *B12, *c12, *C12;
    single   P5, PP5, PPP5, bb5;
    char     *Ap5, *a5, *A5, *b5, *B5, *c5, *C5;
    single   P7, PP7, PPP7, bb7;
    char     *Ap7, *a7, *A7, *b7, *B7, *c7, *C7;
    single   P11, PP11, PPP11, bb11;
    char     *Ap11, *a11, *A11, *b11, *B11, *c11, *C11;
    single   P13, PP13, PPP13, bb13;
    char     *Ap13, *a13, *A13, *b13, *B13, *c13, *C13;

    bind( M, D, B, QL );

    init( I, J, N );
    init( P, Q, L );
    init( X, X1, X2 );

    I = lfirst ( M );
    J = lsecond( M );

    P12   =  p12;
    PP12  =  P12 * P12;
    PPP12 = PP12 * P12;

    if( ( Ap12 = ( char * ) calloc( PPP12, sizeof( char ) ) ) == NULL )
    {
        return( ERROR );
    }
    make_sieve( p12, Ap12, I, J );

    P5   =  p5 * p5;
    PP5  =  P5 * P5;
    PPP5 = PP5 * P5;

    if( ( Ap5 = ( char * ) calloc( PPP5, sizeof( char ) ) ) == NULL )
    {
        return( ERROR );
    }
    make_sieve( p5, Ap5, I, J );

    P7   =  p7;
    PP7  =  P7 * P7;
    PPP7 = PP7 * P7;

    if( ( Ap7 = ( char * ) calloc( PPP7, sizeof( char ) ) ) == NULL )
    {
        free( Ap5 );
        return( ERROR );
    }
    make_sieve( p7, Ap7, I, J );

    P11   =  p11;
    PP11  =  P11 * P11;
    PPP11 = PP11 * P11;

    if( ( Ap11 = ( char * ) calloc( PPP11, sizeof( char ) ) ) == NULL )
    {
        free( Ap5 );
        free( Ap7 );
        return( ERROR );
    }
    make_sieve( p11, Ap11, I, J );

    
    P13   =  p13;
    PP13  =  P13 * P13;
    PPP13 = PP13 * P13;

    if( ( Ap13 = ( char * ) calloc( PPP13, sizeof( char ) ) ) == NULL )
    {
        free( Ap5 );
        free( Ap7 );
        free( Ap11 );
        return( ERROR );
    }
    make_sieve( p13, Ap13, I, J );

    /***   Determine the type of the quartics to look for   ***/
    /***   (Either types 1 and 2 or type 3)                 ***/
    N = isprod( I, -3 );

    {
        rat      Ir, Jr;
        double   fltoCfl();

        init( Ir, Jr );
    
        X  = itofl( I );
        Id = fltoCfl( X );

        Ir = itor( N );
        Jr = itor( J );
        L  = ecrsnfrroots( Ir, Jr );

        if( ( i = llength( L ) ) == 3 )
        {
            /**   X^3 - 3 I X + J has 3 real roots (Type 1 and 2) **/
            X1 = lfirst ( L );
            x1 = fltoCfl( X1 );
            X2 = lsecond( L );
            x2 = fltoCfl( X2 );
            X  = lthird ( L );
            x3 = fltoCfl( X );

     
            type = 1;
        }
        else if( i == 1 )
        {
            /**   X^3 - 3 I X + J has 1 real root (Type 3)       **/
            X  = lfirst ( L );
            x1 = fltoCfl( X );
            type = 3;
        }
        else
        {
            /**   There was an ERROR in root computation         **/
            free( Ap5 );
            free( Ap7 );
            free( Ap11 );
            free( Ap13 );
            return( ERROR );
        }
    }
 
    if( s )
    {
        /**   Acceleration: If invariants are not minimal   **/
        /**                 b has to be divisible by 4      **/
        bb12 = 4 * P12;
        bb5  = 4 * P5;
        bb7  = 4 * P7;
        bb11 = 4 * P11;
        bb13 = 4 * P13;
    }
    else
    {
        /**   If invariants are minimal we have to test     **/
        /**   all possible values for b.                    **/
        aa = 1;
        bb12 = P12;
        bb5  = P5;
        bb7  = P7;
        bb11 = P11;
        bb13 = P13;
    }


    /**   Search for quartics depends on the type:         **/
    /**   if type = 1, look for type 1 and then type 2     **/
    /**   if type = 3, look only for type 3.               **/
    do
    {
        x5 = 4.0 * Id;

        /**   Determine the bound on a (depending on type) **/
        /**   Note: if type = 1 then a must be positive    **/
        /**         otherwise a can also be negative       **/
        switch( type )
        {
            case 1: x = x1;
                    X = X1;
                    K = ( x5 - x * x ) / 3.0;

                    x4 = sqrt( K );
                    x5 = K + x * x4;

                    x4 *= 3.0;
                    x4 += x;
                    x4 += ( 2.0 * x2 );
                    x5 /= x4;

                    A1 = ( single ) floor( x5 );
                    a  = 1;

                    break;

            case 2: x  = x2;
                    X  = X2;
                    x4 = x * x;
                    K  = ( x5 - x4 ) / 3.0;
                    x5 = ( Id - x4 ) / 3.0;

                    x4 = x5 / ( x - x3 );
                    x5 /= ( x1 - x );
                    if( x4 > x5 )
                    {
                        x5 = x4;
                    }
                    A1 = ( single ) floor( x5 );

                    a  = -A1;

                    break;

            case 3: x  = x1; 
                    x4 = x * x;
                    K  = ( x5 - x4 ) / 3.0;

                    x4 -= Id;
                    x4 /= 3.0;
                    x4 = sqrt( x4 );
                    x4 *= 2.0;

                    x2 = ( x + x4 ) / 3.0;
                    A1 = ( single ) floor( x2 );

                    x3 = ( x - x4 ) / 3.0;
                    a  = 1 + ( single ) floor( x3 );

                    break;
        } /**  END of `switch( type )' for determining a and A1  **/

        if( !A1 )
        {
            A1 = -1;
        }

        if( !a )
        {
            a = 1;
        }

        if( A1 < a )
        {
            A1 = 0;
        }

        a2 = a * a;          /***   a2 = a^2                  ***/
        a3 = 3.0 * a;        /***   a3 = 3 * a (as a double)  ***/

        b1 = 0;

        if( s )
        {
            aa = mshom( 4, a );
        }

        a12 = Ap12 + PP12 * mshom( P12, a );
        A12 = Ap12 + PPP12;
        a5  = Ap5  + PP5  * mshom( P5 , a );
        A5  = Ap5  + PPP5;
        a7  = Ap7  + PP7  * mshom( P7 , a );
        A7  = Ap7  + PPP7;
        a11 = Ap11 + PP11 * mshom( P11, a );
        A11 = Ap11 + PPP11;
        a13 = Ap13 + PP13 * mshom( P13, a );
        A13 = Ap13 + PPP13;

        while( A1 )
        {
            if( a && aa )
            {
                /**  Choose b >= 0 and carry out the       **/
                /**  steps for b < 0 the same time         **/
                /**  (See 'get_d_e()').                    **/

                k = K / a2;
                g = x / a3;  /***   g = x / ( 3 * a )   ***/

                b = 0;
                B1 = sabs( 2 * a );
                b2 = 0;

                switch( type )
                {
                    case 1: x5 = x2 / 2.0;
                            x6 = x1 / 2.0;
                            x7 = 1.0 / ( 8.0 * a );
                            break;
                    case 2: if( a > 0 )
                            {
                                x5 = ( x2 + ( x2 * x2 - Id ) / a3 ) / 2.0;
                                x6 = x3 / 2.0;
                            }
                            else
                            {
                                x6 = ( x2 + ( Id - x2 * x2 ) / a3 ) / 2.0;
                                x5 = x1 / 2.0;
                            }
                            x7 = 3.0 / ( 8.0 * a );
                            break;
                    case 3: x5 = 2.25 * a;
                            x6 = x / 2.0;
                            x5 -= x6;
                            x4 = x6 * x6;
                            x4 = ( Id - x4 ) / a3;
                            x5 += x4;
                            x5 /= 2.0;

                            if( a < 0 )
                            {
                                x4 = x5;
                                x5 = x6;
                                x6 = x4;
                            }

                            x7 = 3.0 / ( 8.0 * a );

                            break;
                }
                /***   END of `switch( type )' for determining c and C1   ***/

                b12 = a12;
                B12 = a12 + PP12;
                b5  = a5;
                B5  = a5 + PP5;
                b7  = a7;
                B7  = a7 + PP7;
                b11 = a11;
                B11 = a11 + PP11;
                b13 = a13;
                B13 = a13 + PP13;
                if( b )
                {
                    b12 += P12;
                    b5  += P5;
                    b7  += P7;
                    b11 += P11;
                    b13 += P13;
                }

                while( 1 )
                {
                    x4 = x7 * b2;
                    /***   f = b^2 / ( 2 * a^2 )                 ***/
                    c  = ( single ) floor( x4 + x5 );
                    C1 = 1 + ( single ) floor( x4 + x6 );

                    if( c <= C1 )
                    {
                        h = 4.0 / a3;
                        /***   h = ( 8 * a ) / ( 6 * a^2 ) = 4 / ( 3 * a ) ***/
    
                        m = 4.0 * c / a3;
                        /***    m = 4 * c / ( 3 * a )                  ***/
    
                        f = b2 / ( 2.0 * a2 );  
                        H = m + g - f;  
                        /***        8 * a * c - 3 * b^2 + 2 * a * x    ***/
                        /***   H = ---------------------------------   ***/
                        /***                    6 * a^2                ***/
                        /***                                           ***/
                        /***   For each time that c is increased       ***/
                        /***   by 1, H will be increased by            ***/
                        /***     h = 4 / ( 3 * a )                     ***/
    
                        F = ( f - m ) / 2.0 + g;  
                        /***        9 * b^2 + 12 * a * x - 24 * a * c  ***/
                        /***   F = ----------------------------------- ***/
                        /***                   36 * a^2                ***/
                        /***                                           ***/
                        /***   For each time that c is increased       ***/
                        /***   by 1, F will be increased by            ***/
                        /***     f = ( -24 * a ) / ( 36 * a^2 )        ***/
                        /***       = -2 / ( 3 * a ) = -h / 2           ***/
                        f = h / -2.0;  
    
                        m = b / ( double ) B1;
                        if( isign( a ) < 0 )
                        {
                            m = -m;  
                        }
                        /***   m = 3 * b / ( 6 * a )                 ***/
  
                        c12  = b12 + mshom( P12, c );
                        C12  = b12 + P12;
                        c5   = b5  + mshom( P5, c );
                        C5   = b5  + P5;
                        c7   = b7  + mshom( P7, c );
                        C7   = b7  + P7;
                        c11  = b11 + mshom( P11, c );
                        C11  = b11 + P11;
                        c13  = b13 + mshom( P13, c );
                        C13  = b13 + P13;
    
                        while( 1 )
                        {
                            if( *c12 && *c5 && *c7 && *c11 && *c13 
                            && ( F > -0.01 ) )
                            /***   We want to test F >= 0.0. We test     ***/
                            /***   F > -0.01 instead in order to         ***/
                            /***   avoid error caused by low precision   ***/
                            {
                                if( ( l2 = H * H - k ) > -0.01 )
                                {
                                    l1 = sqrt( fabs( F ) );
                                    p1 = m + l1;
                                    p2 = m - l1;
 
                                    l1 = sqrt( fabs( l2 ) );
                                    l2 = H - l1;
                                    l1 += H;
                                    Q = get_d_e( a, b, c, I, J, l1, l2, p1, p2, s, X );
                                    if( Q != _0 )
                                    {
                                        /**   Q = ( ( a  +/-b  c  d  e ) **/
                                        /**     ( t  x1  x2  x3  x4 ) )  **/
                                        L = lfirst( Q );
                                        if( !isquartnls( L, B ) )
                                        {
                                            /**  Quartic L is everywhere **/
                                            /**  locally soluble: Insert **/
                                            /**  L into the list QL      **/

                                            static list insert_quartic();
                                            
                                            QL = insert_quartic( Q, D, QL );
                                        }    
                                    }    
                                }
                            }
  
                            if( (++c) > C1 )
                            {
                                break;
                            }
    
                            H += h;
                            F += f;
    
                            if( !( (++c12) - C12 ) )
                            {
                                c12 = b12;
                            }
                            if( !( (++c5) - C5 ) )
                            {
                                c5 = b5;
                            }
                            if( !( (++c7) - C7 ) )
                            {
                                c7 = b7;
                            }
                            if( !( (++c11) - C11 ) )
                            {
                                c11 = b11;
                            }
                            if( !( (++c13) - C13 ) )
                            {
                                c13 = b13;
                            }
                        }
                        /***   Loop on c   ***/
                    }
                    /***   if( icomp( c, C1 ) <= 0 )   ***/

                    if( s )
                    {
                        b  += 2;
                        b2 += ( 8 * b );
                        b  += 2;
                    }
                    else
                    {
                        b2 += b;
                        b++;
                        b2 += b;
                    }

                    if( b > B1 )
                    {
                        break;
                    }

                    b12 += bb12;
                    if( b12 >= B12 )
                    {
                        b12 -= PP12;
                    }
                    b5 += bb5;
                    if( b5 >= B5 )
                    {
                        b5 -= PP5;
                    }
                    b7 += bb7;
                    if( b7 >= B7 )
                    {
                        b7 -= PP7;
                    }
                    b11 += bb11;
                    if( b11 >= B11 )
                    {
                        b11 -= PP11;
                    }
                    b13 += bb13;
                    if( b13 >= B13 )
                    {
                        b13 -= PP13;
                    }
                }
                /***   Loop on b   ***/
            }
            else if( !a )
            {
                b1 = 2;
            }
            /***   if( a && aa )   ***/


            a2 += a;
            if( (++a) > A1 )
            {
                break;
            }
            a2 += a;

            a3 += 3.0;

            B1 += b1;

            if( s && ( ++aa == 4 ) )
            {
                aa = 0;
            }

            a12 += PP12;
            if( a12 >= A12 )
            {
                a12 -= PPP12;
            }
            a5 += PP5;
            if( a5 >= A5 )
            {
                a5 -= PPP5;
            }
            a7 += PP7;
            if( a7 >= A7 )
            {
                a7 -= PPP7;
            }
            a11 += PP11;
            if( a11 >= A11 )
            {
                a11 -= PPP11;
            }
            a13 += PP13;
            if( a13 >= A13 )
            {
                a13 -= PPP13;
            }
        }
        /***   Loop on a   ***/

        type++;
    }
    while( type < 3 );

    free( Ap12 );
    free( Ap5  );
    free( Ap7  );
    free( Ap11 );
    free( Ap13 );

    return( QL );
}
/**   static list reduce2( I, J )   int I, J;                              **/
/**   2 - reduction of the pair ( I, J ) as described in Cremona's book    **/
/****************************************************************************/

static list reduce2( I, J )
int I, J;
{
    bind( I, J );

    if( !mshom( 64, I )  &&  !mshom( 512, J ) )
    {
        int H;

        init( H );

        H = isprod( I, 8 );
        H = isum( H, J );
        if( !mshom( 1024, H ) ) 
        {
            I = isquot( I, 16 );
            J = isquot( J, 64 );
        }
    }

    return( list2( I, J ) );
}
        
/****************************************************************************/
/**   static list reduce3( I, J, D )   int I, J, D;                        **/
/**   3 - reduction of the pair ( I, J ) as described in Cremona's book    **/
/****************************************************************************/

static list reduce3( I, J, D )
int I, J, D;
{
    bind( I, J, D );

    if( !mshom( 81, I )  &&  !mshom( 729, J ) )
    {
        if( !mshom( 243, I ) )
        {
            if( !mshom( 19683, J ) ) 
            {
                /**   3^5 | I  and  3^9 | J   **/
                I = isquot( I,  81 );
                J = isquot( I, 729 );
            }
        }
        else 
        {
            if( mshom( 2187, J )  &&  !mshom( 14348907, D ) )
            {
                /**   3^4 || I  and  3^6 || J  and  3^15 | D = 4 I^3 - J^2  **/
                I = isquot( I,  81 );
                J = isquot( I, 729 );
            }
        }
    }

    return( reduce2( I, J ) );
}
        
/***************************************************************/
/**  static isintegral( f, i ) floating f;  int *i;           **/
/**  *i <-- [f] rounded value of the floating point number f  **/
/**  Return: 1, if f is close to an integer,                  **/
/**          0  otherwise                                     **/
/***************************************************************/

static isintegral( f, i )
floating f;
int *i;
{
    floating g;

    init( g );
    bind( f );

    *i = flround( f );
    g = itofl( *i );
    g = flabs( fldif( f, g ) );
    if( flcomp( g, tol ) < 0 )
    {
        return( 1 );
    }
    return( 0 );
}

static list sq_divisors1( L )
list L;
{
    list M;
    int  d, a;

    init( M, d, a );
    bind( L );

    M = _0;

    d = lfirst( L );
    while( L != _0 )
    {
        a = lfirst( L );       /**   a        **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2    **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2^2  **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2^3  **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2^4  **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2^5  **/
        M = lcomp( a, M );
        a = isprod( a, 2 );    /**   a * 2^6  **/
        M = lcomp( a, M );
        L = lred( L );
    }
    M = linv( M );
    d = isprod( d, 64 );
    M = lcomp( d, M );
    return( M );
}

/*************************************************************/
/**   static list sq_divisors( D ) int D;                   **/
/**   Return: list L = ( d1  d2 ...  dk ) of all positive   **/
/**           divisors d of D whose square also divides D.  **/
/*************************************************************/

static list sq_divisors( D )
int D;
{
    single e, f;
    int    p, q, d, dd;
    list   L, M, P;
    
    bind( D );
    init( p, q, d, dd );
    init( L, M, P );

    L = ifel( ifact( iabs( D ) ) );

    M = list1( 1 );
    dd = 1;

    while( L != _0 )
    {
        if( e = lsecond( L ) / 2 )
        {
            p = lfirst( L );

            P = M;
            while( P != _0 )
            {
                d = lfirst( P );
                for( f = 0; f < e; f++ )
                {
                    d = iprod( d, p );
                    M = lcomp( d, M );
                }
                P = lred( P );
                if( icomp( dd, d ) < 0 )
                {
                    dd = d;
                }
            }
        }
        L = lred2( L );
    }
    lsbsort( M );
    M = lcomp( dd, M );
    return( M );
}

/*************************************************************/
/**   static is_q_trivial( Q ) list Q;                      **/
/**   Q = ( ( a  b  c  d  e )  ( t  s  x1  x2  x3  x4 ) )   **/
/**   Test whether quartic                                  **/
/**     g( x ) = a x^4 + b x^3 + c x^2 + d x + e            **/
/**   is trivial or not, i.e. (at least) one of the roots   **/
/**   x1, x2, x3, x4 is rational or not.                    **/
/**   If x_i is rational then y = a * x_i is integral and   **/
/**      0 = a^4 * g( x_i )                                 **/
/**        = a y^4 + a b y^3 + a^2 c y^2 + a^3 d y + a^4 e  **/
/*************************************************************/

static is_q_trivial( Q )
list Q;
{
    single type;
    list   M;
    init( M );

    bind( Q );
    M = lsecond( Q );

    if( ( type = lfirst( M ) ) != 1 )
    {
        single   i;
        int      a, b, c, d, e, h, y, z;
        floating x;
        list     L;

        init( a, b, c, d, e, h, y, z );
        init( x );
        init( L );

        L = lfirst( Q );
        a = lfirst ( L );
        b = lsecond( L );
        c = lthird ( L );
        d = lfourth( L );
        e = lfifth ( L );

        if( type == 2 )
        {
            i = 4;
        }
        else
        {
            i = 2;
        }

        M = lred2( M );

        while( i-- )
        {
            x = lfirst( M );
            M = lred( M );
            x = flprod( x, itofl( a ) );
            y = flround( x );
            z = isum ( y, b );
            z = iprod( z, a );
            z = iprod( z, y );
            h = iprod( a, a );
            z = isum ( z, iprod( h, c ) );
            z = iprod( z, y );
            h = iprod( h, a );
            z = isum ( z, iprod( h, d ) );
            z = iprod( z, y );
            h = iprod( h, a );
            z = isum ( z, iprod( h, e ) );
            if( !z )
            {
                return( 1 );
            }
        }
    }
    return( 0 );
}

/****************************************************************************/
/**   static real_lft( al, be, ga, de, L1, L2, L )                         **/
/**   floating al, be, ga, de;   list  L1, L2, L;                          **/
/**   L1, L2 contain the coefficients of two quartics Q1 and Q2.           **/
/**   L is a list of all divisors d > 0 whose square divides the           **/
/**   discriminant D (with respect to the invariants I and J) of Q1, Q2.   **/
/**   The four real numbers al, be, ga, de are coefficients of a linear    **/
/**   fractional transformation between two quartics.                      **/
/**   Return: 1, if ( al  be  ga  de ) is a l. f. t. between Q1 and Q2     **/
/**           0  otherwise.                                                **/
/****************************************************************************/

static real_lft( al, be, ga, de, L1, L2, L )
floating al, be, ga, de;
list     L1, L2, L;
{
    int      d;
    floating s, t, x;

    bind( al, be, ga, de, L  );
    init( d );
    init( s, t, x );

    x = flprod( al, de );
    s = flprod( be, ga );
    x = fldif ( x , s  );
    x = flabs ( x );
    
    d = lfirst( L );
    t = itofl( d );
    s = flquot( t, x );

    t = flprod( al, s );
    t = flprod( al, t );
    if( !isintegral( t, &d ) )
    {
        return( 0 );
    }

    t = flprod( be, s );
    t = flprod( be, t );
    if( !isintegral( t, &d ) )
    {
        return( 0 );
    }
    t = flprod( ga, s );
    t = flprod( ga, t );
    if( !isintegral( t, &d ) )
    {
        return( 0 );
    }
    t = flprod( de, s );
    t = flprod( de, t );
    if( isintegral( t, &d ) )
    {

        int      a1, a2, a3, b1, b2, b3, c1, c2, c3, d1, d2, d3, e1, e2, e3;
        int      ui, ti, vi, wi, u2, t2, v2, w2, u3, t3, v3, w3, i, h;
        floating u, v, w;

        init( a1, a2, a3, b1, b2, b3, c1, c2, c3, d1, d2, d3, e1, e2, e3 );
        init( ti, ui, vi, wi, u2, t2, v2, w2, u3, t3, v3, w3, i, h );
        init( u, v, w );
        
        bind( L1, L2 );

        L = lred( L );

        a1 = lfirst( L1 );
        L1 = lred  ( L1 );
        b1 = lfirst( L1 );
        L1 = lred  ( L1 );
        c1 = lfirst( L1 );
        L1 = lred  ( L1 );
        d1 = lfirst( L1 );
        L1 = lred  ( L1 );
        e1 = lfirst( L1 );

        a2 = lfirst( L2 );
        L2 = lred  ( L2 );
        b2 = lfirst( L2 );
        L2 = lred  ( L2 );
        c2 = lfirst( L2 );
        L2 = lred  ( L2 );
        d2 = lfirst( L2 );
        L2 = lred  ( L2 );
        e2 = lfirst( L2 );

        while( L != _0 )
        {
            d = lfirst( L );
            s = flsqrt( flquot( itofl( d ), x ) );

            t = flprod( al, s );
            if( isintegral( t, &ti ) )
            {
                u = flprod( be, s );
                if( isintegral( u, &ui ) )
                {
                    v = flprod( ga, s );
                    if( isintegral( v, &vi ) )
                    {
                        w = flprod( de, s );
                        if( isintegral( w, &wi ) )
                        {
/******************************************************************/
/**     a3 = v^4 e2 + t v^3 d2 + t^2 v^2 c2 + t^3 v b2 + t^4 a2  **/
/**     b3 = 4 v^3 w e2 + ( 3 t v^2 w + u v^3 ) d2               **/
/**          + 2 ( t^2 v w + t u v^2 ) c2                        **/
/**          + ( t^3 w + 3 t^2 u v ) b2 + 4 t^3 u a2             **/
/**     c3 = 6 v^2 w^2 e2 + 3 ( u v^2 w + t v w^2 ) d2           **/
/**          + ( u^2 v^2 + 4 t u v w + t^2 w^2 ) c2              **/
/**          + 3 ( t u^2 v + t^2 u w ) b2 + 6 t^2 u^2 a2         **/
/**     d3 = 4 t w^3 e2 + ( 3 u v w^2 + t w^3 ) d2               **/
/**          + 2 ( u^2 v w + t u w^2 ) c2                        **/
/**          + ( u^3 v + 3 t u^2 w ) b2 + 4 t u^3 a2             **/
/**     e3 = w^4 e2 + u w^3 d2 + u^2 w^2 c2 + u^3 w b2 + u^4 a2  **/
/******************************************************************/

                            t2 = iprod( ti, ti );
                            t3 = iprod( t2, ti );
                            d  = iprod(  d,  d );

                            a3 = iprod( e2, vi );
                            h  = iprod( d2, ti );
                            a3 = isum ( a3,  h );
                            a3 = iprod( a3, vi );
                            h  = iprod( c2, t2 );
                            a3 = isum ( a3,  h );
                            a3 = iprod( a3, vi );
                            h  = iprod( b2, t3 );
                            a3 = isum ( a3,  h );
                            a3 = iprod( a3, vi );
                            i  = iprod( t3, ti );
                            h  = iprod( a2,  i );
                            a3 = isum ( a3,  h );

                            h = iprod( a1, d );

                            if( !idif( a3, h ) )
                            {
                                u2 = iprod( ui, ui );
                                u3 = iprod( u2, ui );
                                v2 = iprod( vi, vi );
                                v3 = iprod( v2, vi );

                                b3 = isprod( v3, 4 );
                                b3 = iprod( b3, wi );
                                b3 = iprod( b3, e2 );
                                h  = isprod( v2, 3 );
                                h  = iprod(  h, ti );
                                h  = iprod(  h, wi );
                                i  = iprod( ui, v3 );
                                h  = isum (  h,  i );
                                h  = iprod(  h, d2 );
                                b3 = isum ( b3,  h );
                                h  = iprod( vi, t2 );
                                h  = iprod(  h, wi );
                                i  = iprod( ti, v2 );
                                i  = iprod(  i, ui );
                                h  = isum (  h,  i );
                                h  = iprod(  h, c2 );
                                h  = isprod( h,  2 );
                                b3 = isum ( b3,  h );
                                h  = isprod( t2, 3 );
                                h  = iprod(  h, ui );
                                h  = iprod(  h, vi );
                                i  = iprod( t3, wi );
                                h  = isum (  h,  i );
                                h  = iprod(  h, b2 );
                                b3 = isum ( b3,  h );
                                h  = isprod( t3, 4 );
                                h  = iprod(  h, ui );
                                h  = iprod(  h, a2 );
                                b3 = isum ( b3,  h );
                            
                                h = iprod( b1, d );

                                if( !idif( b3, h ) )
                                {
                                    w2 = iprod( wi, wi );

                                    c3 = isprod( v2, 6 );
                                    c3 = iprod( c3, w2 );
                                    c3 = iprod( c3, e2 );
                                    h  = iprod( ui, v2 );
                                    h  = iprod(  h, wi );
                                    i  = iprod( ti, vi );
                                    i  = iprod(  i, w2 );
                                    h  = isum (  h,  i );
                                    h  = isprod( h,  3 );
                                    h  = iprod(  h, d2 );
                                    c3 = isum ( c3,  h );
                                    h  = iprod( u2, v2 );
                                    i  = iprod( ti, ui );
                                    i  = iprod(  i, vi );
                                    i  = iprod(  i, wi );
                                    i  = isprod( i,  4 );
                                    h  = isum (  h,  i );
                                    i  = iprod( t2, w2 );
                                    h  = isum (  h,  i );
                                    h  = iprod(  h, c2 );
                                    c3 = isum ( c3,  h );
                                    h  = iprod( ti, u2 );
                                    h  = iprod(  h, vi );
                                    i  = iprod( t2, ui );
                                    i  = iprod(  i, wi );
                                    h  = isum (  h,  i );
                                    h  = isprod( h,  3 );
                                    h  = iprod(  h, b2 );
                                    c3 = isum ( c3,  h );
                                    h  = isprod( t2, 6 );
                                    h  = iprod(  h, u2 );
                                    h  = iprod(  h, a2 );
                                    c3 = isum ( c3,  h );
                                    
                                    h = iprod( c1, d );

                                    if( !idif( c3, h ) )
                                    {
                                        w3 = iprod( w2, wi );

                                        d3 = isprod( w3, 4 );
                                        d3 = iprod( d3, vi );
                                        d3 = iprod( d3, e2 );
                                        h  = isprod( w2, 3 );
                                        h  = iprod(  h, ui );
                                        h  = iprod(  h, vi );
                                        i  = iprod( ti, w3 );
                                        h  = isum (  h,  i );
                                        h  = iprod(  h, d2 );
                                        d3 = isum ( d3,  h );
                                        h  = iprod( vi, u2 );
                                        h  = iprod(  h, wi );
                                        i  = iprod( ti, w2 );
                                        i  = iprod(  i, ui );
                                        h  = isum (  h,  i );
                                        h  = iprod(  h, c2 );
                                        h  = isprod( h,  2 );
                                        d3 = isum ( d3,  h );
                                        h  = isprod( u2, 3 );
                                        h  = iprod(  h, ti );
                                        h  = iprod(  h, wi );
                                        i  = iprod( u3, vi );
                                        h  = isum (  h,  i );
                                        h  = iprod(  h, b2 );
                                        d3 = isum ( d3,  h );
                                        h  = isprod( u3, 4 );
                                        h  = iprod(  h, ti );
                                        h  = iprod(  h, a2 );
                                        d3 = isum ( d3,  h );
            
                                        h = iprod( d1, d );

                                        if( !idif( d3, h ) )
                                        {
                                            e3 = iprod( e2, wi );
                                            h  = iprod( d2, ui );
                                            e3 = isum ( e3,  h );
                                            e3 = iprod( e3, wi );
                                            h  = iprod( c2, u2 );
                                            e3 = isum ( e3,  h );
                                            e3 = iprod( e3, wi );
                                            h  = iprod( b2, u3 );
                                            e3 = isum ( e3,  h );
                                            e3 = iprod( e3, wi );
                                            i  = iprod( u3, ui );
                                            h  = iprod( a2,  i );
                                            e3 = isum ( e3,  h );
                
                                            h = iprod( e1, d );

                                            if( !idif( e3, h ) )
                                            {
                                                return( 1 );
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            L = lred( L );
        }
    }
    return( 0 );
}


/**  Return: 1 if Im(a) < FF and Re( a ) > FF^3   **/
/**          0 otherwise                          **/
static is_real( a )
complex a;
{
    static f_similar();

    if( !a )
    {
        return( 1 );
    }

    bind( a );

    return( f_similar( cimag( a ), 0 ) );
}

static f_similar( a, b )
floating a, b;
{
    floating g;

    init( g );
    bind( a, b );

    g = flabs( fldif( a, b ) );
    if( flcomp( g, tol ) < 0 ) 
    {
        return( 1 );
    }
    return( 0 );
}

static c_similar( a, b )
complex a, b;
{
    floating g, h;

    static f_similar();

    init( g, h );
    bind( a, b );

    g = creal( a );
 
    h = creal( b );

    if( f_similar( g, h ) )
    {
        g = cimag( a );
        h = cimag( b );
        if( f_similar( g, h ) )
        {
            return( 1 );
        }
    }
    return( 0 );  
}

static floating f_root_ratio( x, p1, p2, p3, p4 )
floating *x;
single  p1, p2, p3, p4;
{
    floating xr, hh;

    init( xr, hh );

    xr = fldif( x[p1], x[p3] );
    hh = fldif( x[p2], x[p4] );
    xr = flprod( xr, hh );
    hh = fldif( x[p1], x[p4] );
    xr = flquot( xr, hh );
    hh = fldif( x[p2], x[p3] );
    xr = flquot( xr, hh );

    return( xr );
}

static complex c_root_ratio( x, p1, p2, p3, p4 )
complex *x;
single  p1, p2, p3, p4;
{
    complex xr, hh;

    init( xr, hh );

    xr = cdif( x[p1], x[p3] );
    hh = cdif( x[p2], x[p4] );
    xr = cprod( xr, hh );
    hh = cdif( x[p1], x[p4] );
    xr = cquot( xr, hh );
    hh = cdif( x[p2], x[p3] );
    xr = cquot( xr, hh );

    return( xr );
}

static f_subroutine( x, y, q2, q3, q4, L1, L2, L )
floating *x, *y;
single   q2, q3, q4;
list     L1, L2, L; 
{
    floating al, be, ga, de, h1, h2;
    single   p1, p2, p3, i;

    init( al, be, ga, de, h1, h2 );
    bind( L, L1, L2 );

    /**   We have to test all permutations    **/
    /**   which lead to the same ratio:       **/
    /**    /  1  2  3  4 \  /  1  2  3  4 \   **/
    /**    \  1 q2 q3 q4 /  \ q2  1 q4 q3 /   **/
    /**                                       **/
    /**    /  1  2  3  4 \  /  1  2  3  4 \   **/
    /**    \ q3 q4  1 q2 /  \ q4 q3 q2  1 /   **/

    p1 =  0;
    p2 = q2;
    p3 = q3;

    for( i = 0; i < 4; i++ )
    {
        al = fldif ( y[p2], y[p3] );
        al = flprod( al   , y[p1] );
        al = flprod( al   , x[0]  );
        h1 = fldif ( y[p3], y[p1] );
        h1 = flprod( h1   , y[p2] );
        h1 = flprod( h1   , x[1]  );
        al = flsum ( al   , h1    );
        h1 = fldif ( y[p1], y[p2] );
        h1 = flprod( h1   , y[p3] );
        h1 = flprod( h1   , x[2]  );
        al = flsum ( al   , h1    );
        if( flcomp( flabs( al ), tol3 ) < 0 )
        {
            al = 0;
        }
    
        be = flprod( x[1] , y[p3] );
        h2 = flprod( y[p2], x[2]  );
        be = fldif ( be   , h2    );
        be = flprod( be   , x[0]  );
        be = flprod( be   , y[p1] );
        h1 = flprod( x[2] , y[p1] );
        h2 = flprod( y[p3], x[0]  );
        h1 = fldif ( h1   , h2    );
        h1 = flprod( h1   , x[1]  );
        h1 = flprod( h1   , y[p2] );
        be = flsum ( be   , h1    );
        h1 = flprod( x[0] , y[p2] );
        h2 = flprod( y[p1], x[1]  );
        h1 = fldif ( h1   , h2    );
        h1 = flprod( h1   , x[2]  );
        h1 = flprod( h1   , y[p3] );
        be = flsum ( be   , h1    );
        if( flcomp( flabs( be ), tol3 ) < 0 )
        {
            be = 0;
        }

        ga = flprod( x[2] , y[p1] );
        h2 = flprod( y[p3], x[0]  );
        ga = fldif ( ga   , h2    );
        h1 = flprod( x[0] , y[p2] );
        h2 = flprod( y[p1], x[1]  );
        h1 = fldif ( h1   , h2    );
        ga = flsum ( ga   , h1    );
        h1 = flprod( x[1] , y[p3] );
        h2 = flprod( y[p2], x[2]  );
        h1 = fldif ( h1   , h2    );
        ga = flsum ( ga   , h1    );
        if( flcomp( flabs( ga ), tol3 ) < 0 )
        {
            ga = 0;
        }
    
        de = fldif ( x[1] , x[2]  );
        de = flprod( de   , y[p1] );
        de = flprod( de   , x[0]  );
        h1 = fldif ( x[2] , x[0]  );
        h1 = flprod( h1   , y[p2] );
        h1 = flprod( h1   , x[1]  );
        de = flsum ( de   , h1    );
        h1 = fldif ( x[0] , x[1]  );
        h1 = flprod( h1   , y[p3] );
        h1 = flprod( h1   , x[2]  );
        de = flsum ( de   , h1    );
        if( flcomp( flabs( de ), tol3 ) < 0 )
        {
            de = 0;
        }

        if( al )
        {
            h1 = al;
            al = one;
            be = flquot( be, h1 );
            ga = flquot( ga, h1 );
            de = flquot( de, h1 );
        }
        else if( be )
        {
            h1 = be;
            be = one;
            ga = flquot( ga, h1 );
            de = flquot( de, h1 );
        }
        else if( ga )
        {
            h1 = ga;
            ga = one;
            de = flquot( de, h1 );
        }
        else
        {
            h1 = de;
            de = one;
        }

        /**  al, be, ga, de is the     **/
        /**  REAL l.f. transformation  **/
        /**  Test equivalence with     **/
        /**  REAL l.f. transformation  **/
    
        if( h1 && real_lft( al, be, ga, de, L1, L2, L ) )
        {
            return( 1 );
        }
  
        switch( i )
        {
            case  0: p1 = q2;
                     p2 =  0;
                     p3 = q4;
                     break;  
            case  1: p1 = q3;
                     p2 = q4;
                     p3 =  0;
                     break;  
            case  2: p1 = q4;
                     p2 = q3;
                     p3 = q2;
                     break;  
            default: break;  
        }
    }
    return( 0 );
}

static c_subroutine( x, y, type, q2, q3, q4, L1, L2, L )
complex *x, *y;
single  type, q2, q3, q4;
list    L1, L2, L; 
{
    complex  al, be, ga, de, h1, h2;
    floating af;
    single   p1, p2, p3, i, flag;

    init( al, be, ga, de, h1, h2 );
    init( af );
    bind( L1, L2, L );

    /**   We have to test all permutations    **/
    /**   which lead to the same ratio:       **/
    /**    /  1  2  3  4 \  /  1  2  3  4 \   **/
    /**    \  1 q2 q3 q4 /  \ q2  1 q4 q3 /   **/
    /**   If type = 1 we also have to test    **/
    /**    /  1  2  3  4 \  /  1  2  3  4 \   **/
    /**    \ q3 q4  1 q2 /  \ q4 q3 q2  1 /   **/

    p1 = 0;
    p2 = q2;
    p3 = q3;

    for( i = 0; i < 4; i++ )
    {
        al = cdif ( y[p2], y[p3] );
        al = cprod( al   , y[p1] );
        al = cprod( al   , x[0]  );
        h1 = cdif ( y[p3], y[p1] );
        h1 = cprod( h1   , y[p2] );
        h1 = cprod( h1   , x[1]  );
        al = csum ( al   , h1    );
        h1 = cdif ( y[p1], y[p2] );
        h1 = cprod( h1   , y[p3] );
        h1 = cprod( h1   , x[2]  );
        al = csum ( al   , h1    );
    
        be = cprod( x[1] , y[p3] );
        h2 = cprod( y[p2], x[2]  );
        be = cdif ( be   , h2    );
        be = cprod( be   , x[0]  );
        be = cprod( be   , y[p1] );
        h1 = cprod( x[2] , y[p1] );
        h2 = cprod( y[p3], x[0]  );
        h1 = cdif ( h1   , h2    );
        h1 = cprod( h1   , x[1]  );
        h1 = cprod( h1   , y[p2] );
        be = csum ( be   , h1    );
        h1 = cprod( x[0] , y[p2] );
        h2 = cprod( y[p1], x[1]  );
        h1 = cdif ( h1   , h2    );
        h1 = cprod( h1   , x[2]  );
        h1 = cprod( h1   , y[p3] );
        be = csum ( be   , h1    );
    
        flag = 1;

        if( ( flcomp( flabs( creal( al ) ), tol3 ) > 0 )
        ||  ( flcomp( flabs( cimag( al ) ), tol3 ) > 0 ) )
        {
            be = cquot( be, al );
            if( !is_real( be ) )
            {
                flag = 0;
            }
        }
        else if( ( flcomp( flabs( creal( be ) ), tol3 ) > 0 )
        ||  ( flcomp( flabs( cimag( be ) ), tol3 ) > 0 ) )
        {
            al = 0;
        }
        else
        {
            be = 0;
        }
        if( flag )
        {
            ga = cprod( x[2] , y[p1] );
            h2 = cprod( y[p3], x[0]  );
            ga = cdif ( ga   , h2    );
            h1 = cprod( x[0] , y[p2] );
            h2 = cprod( y[p1], x[1]  );
            h1 = cdif ( h1   , h2    );
            ga = csum ( ga   , h1    );
            h1 = cprod( x[1] , y[p3] );
            h2 = cprod( y[p2], x[2]  );
            h1 = cdif ( h1   , h2    );
            ga = csum ( ga   , h1    );
            if( al )
            {
                ga = cquot( ga, al );
            }
            else if( be )
            {
                ga = cquot( ga, be );
            }
            else if( ( flcomp( flabs( creal( ga ) ), tol3 ) < 0 )
            &&  ( flcomp( flabs( cimag( ga ) ), tol3 ) < 0 ) )
            {
                ga = 0;
            }
            if( !is_real( ga ) )
            {
                flag = 0;
            }
            if( flag )
            {
                de = cdif ( x[1] , x[2]  );
                de = cprod( de   , y[p1] );
                de = cprod( de   , x[0]  );
                h1 = cdif ( x[2] , x[0]  );
                h1 = cprod( h1   , y[p2] );
                h1 = cprod( h1   , x[1]  );
                de = csum ( de   , h1    );
                h1 = cdif ( x[0] , x[1]  );
                h1 = cprod( h1   , y[p3] );
                h1 = cprod( h1   , x[2]  );
                de = csum ( de   , h1    );

                if( al )
                {
                    de = cquot( de, al );
                    al = c_one;
                }
                else if( be )
                {
                    de = cquot( de, be );
                    be = c_one;
                }
                else if( ga )
                {
                    de = cquot( de, ga );
                    ga = c_one;
                }
                else if( ( flcomp( flabs( creal( de ) ), tol3 ) < 0 )
                &&  ( flcomp( flabs( cimag( de ) ), tol3 ) < 0 ) )
                {
                    de = c_one;
                }
                else
                {
                    flag = 0;
                }
                if( !is_real( de ) )
                {
                    flag = 0;
                }
                if( flag )
                {
                    /**  al, be, ga, de is the     **/
                    /**  REAL l.f. transformation  **/
                    /**  (still represented as     **/
                    /**  complex numbers)          **/

                    floating bf, gf, df;

                    init( bf, gf, df );

                    af = creal( al );
                    bf = creal( be );
                    gf = creal( ga );
                    df = creal( de );

                    /**  Test equivalence with     **/
                    /**  REAL l.f. transformation  **/

                    if( real_lft( af, bf, gf, df, L1, L2, L ) )
                    {
                        return( 1 );
                    }
                }
            }
        }

        switch( i )
        {
            case  0: p1 = q2;
                     p2 =  0;
                     p3 = q4;
                     break;  
            case  1: p1 = q3;
                     p2 = q4;
                     p3 =  0;
                     break;  
            case  2: p1 = q4;
                     p2 = q3;
                     p3 = q2;
                     break;  
            default: break;  
        }
        if( ( type == 3 ) && ( p1 > 1 ) )
        {
            i = 4;
        }
    }
    return( 0 );
}

/****************************************************************************/
/**   static equivalence( Q1, Q2, I, J, s1, s2 )                           **/
/**     list Q1, Q2;  int I, J;                                            **/
/**   Q1 and Q2 are lists that represent quartics (2-coverings) of E/Q.    **/
/**   Each Qi contains the coefficients, the type and the roots of the     **/
/**   quartic it repesents (see 'get_d_e()' for details).                  **/
/**   L is a list of all positive divisors of D whose square also divides  **/
/**   where D = 4 I^3 - J, ( I, J ) invariants of Q1, Q2.                  **/
/**   minimal or not, respectively.                                        **/
/**   Return: 1, if Q1 and Q2 are equivalent (in the same class as         **/
/**              of the 2-Selmer group of E/Q                              **/
/**           0  otherwise.                                                **/
/****************************************************************************/

static equivalence( Q1, Q2, L )
list   Q1, Q2, L;
{
    single type;
    list M1, M2;
    
    static f_similar();

    init( M1, M2 );
    bind( Q1, Q2, L );

    M1 = lsecond( Q1 );
    M2 = lsecond( Q2 );
    type = lfirst( M1 );
    if( !( lfirst( M2 ) - type ) )
    {
        /***   type of Q1 = type of Q2 = type  ***/
        single   s1, s2, flag;
        list     K, L1, L2;
        int      d, e;
        floating f;

        init( d, e );
        init( K, L1, L2 );
        init( f );

        s1 = lsecond( M1 );
        s2 = lsecond( M2 );

        M1 = lred2( M1 );
        M2 = lred2( M2 );

        L1 = lfirst( Q1 );
        L2 = lfirst( Q2 );

        if( s1 - s2 )
        {
            /**   Invariants of the two quartics are different   **/
            /**   We have to 'blow up' the coefficinets of the   **/
            /**   quartic with the smaller invariants.           **/
            int   a, b, c, d, e;
            init( a, b, c, d, e );

            if( s2 )
            {
                /**   Q1 has the smaller invariants  **/
                a = lfirst ( L1 );
                b = lsecond( L1 );
                c = lthird ( L1 );
                d = lfourth( L1 );
                e = lfifth ( L1 );
                b = isprod( b,  2 );
                c = isprod( c,  4 );
                d = isprod( d,  8 );
                e = isprod( e, 16 );
                L1 = list5( a, b, c, d, e );
            }
            else
            {
                /**   Q2 has the smaller invariants  **/
                a = lfirst ( L2 );
                b = lsecond( L2 );
                c = lthird ( L2 );
                d = lfourth( L2 );
                e = lfifth ( L2 );
                b = isprod( b,  2 );
                c = isprod( c,  4 );
                d = isprod( d,  8 );
                e = isprod( e, 16 );
                L2 = list5( a, b, c, d, e );
            }
        }

        /**                           ( x1 - x3 ) ( x2 - x4 )      **/
        /**   Compute the ratio xr = -------------------------     **/
        /**                           ( x1 - x4 ) ( x2 - x3 )      **/
        /**   of the roots x1, ..., x4 of the quartic Q1.          **/
        /**   Compute the ratio yr = ...                           **/
        /**   of all permutations ( y_i1  y_i2  y_i3  y_i4 )       **/
        /**   of the roots y1, ..., y4 of the quartic Q2.          **/
        /**   If xr = yr for some permutation then there is a      **/
        /**   linear fractional transformation                     **/
        /**              A x + B                                   **/
        /**       x --> ---------, A, B, C, D complex numbers      **/
        /**              C x + D                                   **/
        /**   between the two quartics. Try to find out whether    **/
        /**   A, B, C, D can be chosen in Z. If yes, then Q1 and   **/
        /**   Q2 are equivalent.                                   **/

        if( type == 2 )
        {
            /***   All roots of the quartics are real ==>   ***/
            /***   we can use the SIMATH TYPE floating      ***/
            single    p1, p2, p3, p4;
            floating xr, yr, hh, x[4], y[4];
 
            init( xr, yr, hh, x[0..3], y[0..3] );

            x[0] = lfirst ( M1 );
            x[1] = lsecond( M1 );
            x[2] = lthird ( M1 );
            x[3] = lfourth( M1 );

            y[0] = lfirst ( M2 );
            y[1] = lsecond( M2 );
            y[2] = lthird ( M2 );
            y[3] = lfourth( M2 );
            if( s1 - s2 )
            {
                if( s2 )
                {
                    x[0] = flsum( x[0], x[0] );
                    x[1] = flsum( x[1], x[1] );
                    x[2] = flsum( x[2], x[2] );
                    x[3] = flsum( x[3], x[3] );
                }
                else
                {
                    y[0] = flsum( y[0], y[0] );
                    y[1] = flsum( y[1], y[1] );
                    y[2] = flsum( y[2], y[2] );
                    y[3] = flsum( y[3], y[3] );
                }
            }

            xr = f_root_ratio( y, 0, 1, 2, 3 );

            /**   We only have to check the ratios yr            **/
            /**   coming from the permutations                   **/
            /**   / 1 2 3 4 \   / 1 2 3 4 \   / 1 2 3 4 \        **/
            /**   \ 1 2 3 4 /   \ 1 3 2 4 /   \ 1 4 3 2 /        **/
            /**   together with the inverse of these ratios      **/
            /**   (which come from the permutations              **/
            /**   / 1 2 3 4 \   / 1 2 3 4 \   / 1 2 3 4 \        **/
            /**   \ 1 2 4 3 /   \ 1 4 2 3 /   \ 1 3 4 2 /        **/
            /**   by switching one pair x3 <--> x4 of roots)     **/
            /**   Any other permutation leads to one of the      **/
            /**   above 6 ratios.                                **/
            

            for( p2 = 1; p2 < 4; p2++ )
            {
                switch( p2 )
                {
                    case 1: p3 = 2;
                            p4 = 3;
                            break; 
                    case 2: p3 = 1;
                            p4 = 3;
                            break; 
                    case 3: p3 = 2;
                            p4 = 1;
                            break; 
                }
          
                yr = f_root_ratio( y, 0, p2, p3, p4 );
           
                flag = 1;
                if( f_similar( xr, yr ) )
                {
                    if( f_subroutine( x, y, p2, p3, p4, L1, L2, L ) )
                    {
                        return( 1 );
                    }
                    if( !f_similar( one, yr ) )
                    {
                        flag = 1;
                    }
                    else
                    {
                        flag = 0;
                    }
                }

                if( flag )
                {
                    hh = flquot( one, yr );

                    if( f_similar( xr, hh ) )
                    {
                        single q2, q3, q4;
    
                        /**   Interchange one pair of roots: xi <--> x_j  **/
                        switch( p2 )
                        {
                            case 1: q2 = 1;
                                    q3 = 3;
                                    q4 = 2;
                                    break;
                            case 2: q2 = 3;
                                    q3 = 1;
                                    q4 = 2;
                                    break;
                            case 3: q2 = 2;
                                    q3 = 3;
                                    q4 = 1;
                                    break;
                        }
                        if( f_subroutine( x, y, q2, q3, q4, L1, L2, L ) )
                        {
                            return( 1 );
                        }
                    }
                }
            }
        }
        else
        {
            /***   There are complex roots            ==>   ***/
            /***   we have to use the SIMATH TYPE complex   ***/
            complex xr, yr, hh, x[4], y[4];

            init( xr, yr, hh, x[0..3], y[0..3] );

            if( type == 3 )
            {
                /***   there are two real roots which have   ***/
                /***   to be transformed to the TYPE complex ***/

                f = lfirst ( M1 );
                x[0] = ccri( f, 0 );
                f = lsecond( M1 );
                x[1] = ccri( f, 0 );
                f = lfirst ( M2 );
                y[0] = ccri( f, 0 );
                f = lsecond( M2 );
                y[1] = ccri( f, 0 );
            }
            else
            {
                /***   all four roots are complex            ***/
                x[0] = lfirst ( M1 );
                x[1] = lsecond( M1 );
                y[0] = lfirst ( M2 );
                y[1] = lsecond( M2 );
            }
            x[2] = lthird ( M1 );
            x[3] = lfourth( M1 );
            y[2] = lthird ( M2 );
            y[3] = lfourth( M2 );

            if( s1 - s2 )
            {
                if( s2 )
                {
                    x[0] = csum( x[0], x[0] );
                    x[1] = csum( x[1], x[1] );
                    x[2] = csum( x[2], x[2] );
                    x[3] = csum( x[3], x[3] );
                }
                else
                {
                    y[0] = csum( y[0], y[0] );
                    y[1] = csum( y[1], y[1] );
                    y[2] = csum( y[2], y[2] );
                    y[3] = csum( y[3], y[3] );
                }
            }

            xr = c_root_ratio( x, 0, 1, 2, 3 );

            /**   We only have to check the ratio yr         **/
            /**   coming from the permutation                **/
            /**                 / 1 2 3 4 \                  **/
            /**                 \ 1 2 3 4 /                  **/
            /**   together with the inverse (type 1) or the  **/
            /**   conjugate complex (type 3) of this ratio   **/
            /**   (which come from the permutations          **/
            /**                 / 1 2 3 4 \                  **/
            /**                 \ 1 2 4 3 /                  **/
            /**   by switching the complex pair of roots)    **/
            /**   Any other permutation with a different     **/
            /**   ratio from the 2 ratios above maps a real  **/
            /**   to a complex root (which is impossible).   **/
        
            yr = c_root_ratio( y, 0, 1, 2, 3 );
       
            flag = 1;
            if( c_similar( xr, yr ) )
            {
                if( c_subroutine( x, y, type, 1, 2, 3, L1, L2, L ) )
                {
                    return( 1 );
                }
                flag = 0;
            }
            
            if( type == 1 )
            {
                if( flag || c_similar( yr, c_one ) )
                {
                    hh = cquot( c_one, yr );
                    flag = 1;
                }
            }
            else
            {
                if( flag || is_real( yr ) )
                {
                    hh = cconjug( yr );
                    flag = 1;
                }
            }

            if( flag )
            {
                if( c_similar( xr, hh ) )
                {
                    if( c_subroutine( x, y, type, 1, 3, 2, L1, L2, L ) )
                    {
                        return( 1 );
                    }
                }
            }
        }
    }
   
    /***    Q1 and Q2 are  N O T  equivalent   ***/
    return( 0 );
}

static list insert_q( M, Q )
list M, Q;
{
    bind( Q, M );

    if( M != _0 )
    {
        int aP, bP, cP, dP, eP, pP, aQ, bQ, cQ, dQ, eQ, pQ;
        list N, P, QQ, PP;

        init( aP, bP, cP, dP, eP, pP, aQ, bQ, cQ, dQ, eQ, pQ );
        init( N, P, QQ, PP );
        bind( M, Q );

        QQ = lfirst( Q );
        aQ = lfirst( QQ );
        eQ = lfifth( QQ );

        if( issquare( aQ ) < 0 )
        {
            if( issquare( eQ ) < 0 )
            {
                pQ = iprod( aQ, eQ );
                if( bQ = lsecond( QQ ) )
                {
                    pQ = iprod( pQ, bQ );
                }
                if( cQ = lthird ( QQ ) )
                {
                    pQ = iprod( pQ, cQ );
                }
                if( dQ = lfourth( QQ ) )
                {
                    pQ = iprod( pQ, dQ );
                }
                pQ = iabs( pQ );
            }
            else
            {
                aQ = eQ;
            }
        }
        else
        {
            if( ( issquare( eQ ) > 0 ) && ( icomp( eQ, aQ ) < 0 ) )
            {
                aQ = eQ;
            }
        }

        N = _0;
        while( M != _0 )
        {
            P = lfirst( M );
            PP = lfirst( P );
            aP = lfirst( PP );
            eP = lfifth( PP );

            if( pQ )
            {
                if( ( issquare( aP ) > 0 ) || ( issquare( eP ) > 0 ) )
                {
                    pP = 0;
                }
                else
                {
                    pP = iprod( aP, eP );
                    if( bP = lsecond( PP ) )
                    {
                        pP = iprod( pP, bP );
                    }
                    if( cP = lthird ( PP ) )
                    {
                        pP = iprod( pP, cP );
                    }
                    if( dP = lfourth( PP ) )
                    {
                        pP = iprod( pP, dP );
                    }
                    pP = iabs( pP );
                }
            }
            else
            {
                pP = 1;
                if( issquare( aP ) > 0 )
                {
                    if( ( issquare( eP ) > 0 ) && ( icomp( eP, aP ) < 0 ) )
                    {
                        aP = eP;
                    }
                    if( icomp( aQ, aP ) > 0 )
                    {
                        pP = -1;
                    }
                }
                else if( issquare( eP ) > 0 )
                {
                    if( icomp( aQ, eP ) > 0 )
                    {
                        pP = -1;
                    }
                }
            }
            if( icomp( pQ, pP ) < 0 )
            {
                break;
            }
            M = lred( M );
            N = lcomp( P, N );
        }
        N = lcomp( Q, N );
        while( M != _0 )
        {
            P = lfirst( M );
            M = lred( M );
            N = lcomp( P, N );
        }
        return( linv( N ) );
    }
    return( list1( Q ) );
}
                                    
/****************************************************************************/
/**   static list insert_quartic( Q, D, QL )   list Q, D, QL;              **/
/**   Q is a list with all important data of a quartic (see 'get_d_e()')   **/
/**   D is a list with divisors (see `quartics()')                         **/
/**   QL is a list containing classes of quartics (see also `quartics()')  **/
/**   The quartic Q is inserted into the list QL.                          **/
/**   Let QL = ( C1 ...  Ck ), where C1, ..., Ck are different classes.    **/
/**   Case 1: Q is equivalent to one of the quartics in QL:                **/
/**           Let Ci = ( Q1 ... Ql ) be the equivalence class of Q in QL   **/
/**           then we set C <-- ( Q1  ...  Ql  Q ).                        **/
/**           Return: ( C1 ... C(i-1)  C  C(i+1) ...  Ck ).                **/
/**   Case 2: Q is not equivalent to any of the quartics in QL             **/
/**           then we set C <-- ( Q ).                                     **/
/**           Return: ( C1 ...  Ck  C ).                                   **/
/****************************************************************************/

static list insert_quartic( Q, D, QL )
list Q, D, QL;
{
    list L, M, P;

    static list insert_q();

    bind( Q, D, QL );

    init( L, M, P );

    L = _0;

    while( QL != _0 )
    {
        M = lfirst( QL );
        P = lfirst( M );
        if( equivalence( P, Q, D ) )
        {
            M = insert_q( M, Q );
            break;
        }
        L = lcomp( M, L );
        QL = lred( QL );
    }

    if( QL == _0 )
    {
        /**   Q is not equivalent to any quartic in QL  **/
        M = list1( Q );
    }
    else
    {
        QL = lred( QL );
    }

    L = lcomp( M, L );
    
    while( QL != _0 )
    {
        M = lfirst( QL );
        L = lcomp( M, L );
        QL = lred( QL );
    }

    return( linv( L ) );
}

/****************************************************************************/
/****************************************************************************/
/**                                                                        **/
/**                        END of the static part                          **/
/**                                                                        **/
/****************************************************************************/
/****************************************************************************/

list ecrg2dhomsp( E )
list E;
{
    single   n, m, r;
    int      I, J, D, D1;
    list     B, L, M, P, Q;

    bind( E );

    init( I, J, D, D1 );
    init( B, L, M, P, Q );
    init( tol, tol3, one, c_one );

    one  = itofl( 1 );
    tol  = Cfltofl( FF );
    tol3 = flsexp ( tol, 3 );
    c_one = ccri( one, 0 );  /**  one = 1 = 1.0 + 0 * i  **/

    /**   Determination of all "bad primes":  p bad  <==>  p | (2*N)     **/
    L = ecrfcond( E );
    r = lfirst( L );
    if( r != 2 )
    {
        /**   2 does not divide N and has to be added to the list L      **/
        M = list2( r, 2 );
    }
    else
    { 
        /**   2 divides N and thus is already contained in the list L    **/
        M = list1( r );
    }
    L = lred2( L );

    while( L != _0 )
    {
        r = lfirst( L );
        M = lcomp( r, M );
        L = lred2( L );
    }
    B = linv( M );
    /**********************************************************************/
    /**   B = list of bad primes: a quartic (2-covering of E/Q) is       **/
    /**   automatically locally soluble for all primes p outside of B.   **/
    /**   Thus local solubility for the quartics has only to be tested   **/
    /**   for the local fields |R and (Q_p with p in B.                  **/
    /**********************************************************************/

    /**********************************************************************/
    /**   Get the pair(s) of invariants ( I, J )                         **/
    /**   L = ( ( I  J ) )   or   L = ( ( I  J )  ( I'  J' ) )           **/
    /**   For each pair ( I  J ) in L find all quartics                  **/
    /**      g:  y^2  =  a * x^4  +  b * x^3  + c * x^2  + d * x  +  e   **/
    /**   such that                                                      **/
    /**      I  =  12 a e  -  3 b d  +  c^3                              **/
    /**      J  =  72 a c e  +  9 b c d  -  27 a d^2                     **/
    /**            -  27 b^2 e  -  2 c^3                                 **/
    /**********************************************************************/
    Q = _0;

    I = eciminc4( E );
    J = eciminc6( E );
    J = isprod( J, 2 );
    if( !mshom( 16, I ) && !mshom( 64, J ) )
    {
        I = iquot( I, 16 );
        J = iquot( J, 64 );
    }
    D = isprod( I, 4 );
    D = iprod ( D, I );
    D = iprod ( D, I );
    D = idif( D, iprod ( J, J ) );

    P = reduce3( I, J, D );
    if( idif( I, lfirst( P ) ) || idif( J, lsecond( P ) ) )
    {
        I = lfirst ( P );
        J = lsecond( P );
        D = isprod( I, 4 );
        D = iprod ( D, I );
        D = iprod ( D, I );
        D = idif( D, iprod ( J, J ) );
    }
        
    L = sq_divisors( D );
    Q = quartics( P, L, B, Q, 0 );

    if( mshom( 8, I )  ||  mshom( 32, J ) )
    {
        D1 = isum(  I, I );
        D1 = isum( D1, J );
        if( mshom( 16, D1 ) )
        {
            I = isprod( I, 16 );
            J = isprod( J, 64 );
            D = isprod( D, 4096 );

            P = reduce2( I, J, D );
            I = lfirst ( P );
            J = lsecond( P );
            if( idif( I, lfirst( P ) ) || idif( J, lsecond( P ) ) )
            {
                I = lfirst ( P );
                J = lsecond( P );
                D = isprod( I, 4 );
                D = iprod ( D, I );
                D = iprod ( D, I );
                D = idif( D, iprod ( J, J ) );
            }
            L = sq_divisors1( L );

            Q = quartics( P, L, B, Q, 1 );
        }
    }
    return( Q );
}
