/*M
.SH NAME
ecisnfpbwh - elliptic curve with integer coefficients, short normal form, points of bounded Weil height

.SH SYNOPSIS
.nf
#include<_ec2.h>

ecisnfpbwh(E, PL, lb, ub, modus, hmin, BL)
list E, *PL, *BL; 
floating *lb, ub, hmin; 
single modus;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B *PL
is a list in the shape
.IP
PL = ( P1 h1 P2 h2 ... Pr hr ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a point on the minimal model of E/Q,
.IP
hi
is the Neron-Tate height of Pi, and
.IP
h1 <= h2 <= ... .       
.TP 4
.B lb
lb is a pointer on a floating point number. *lb is the lower bound of the area where the search takes place.
.TP 4
.B ub
is the upper bound of this area.
.TP 4
.B hmin
is a lower bound for h( P ), where P on E/Q is no torsion point, hmin > 0.
.TP 4
.B BL
is a pointer on a list of linearily independent points on E/Q. As in *PL, the points are stored with their canonical heights. 
.PP
ecisnfpbwh computes a list of all points on (the minimal model of) E/Q whose Weil-height is bounded from below by *lb and from above by ub. The points that were found are stored - together with their canonical height - in the list *PL (as descripted above).
.PP
If modus < 0, then all points (modulo negatives) with    *lb <= d(P) <= ub will be stored in *PL, i.e. all points P = ( x, y ) with different x-coordinates.
.TP 4
Special case: 
 modus = -9: only integer points, i.e. x in Z, will be 
             stored.
.PP
If modus >= 0, then all points modulo negatives and torsion with *lb <= d(P) <= ub will be stored in *PL, i.e. all points P with different Neron-Tate heights: If P is in *PL, then none of the points -P, P + T, -P + T (T torsion point) will be in *PL. Neither there will be any torsion points in *PL. 
.TP 4
Special cases: 
 modus = 0: The computation will be finished as soon 
            as r linearily independent points on E/Q 
            are found. Here r deonotes the rank ofE/Q. 
            These r points will also be stored in the 
            basis list *BL.
 modus = 1: The computation will be finished as soon 
            as the first non-torsion point on E/Q is 
            found. 
.PP
ecisnfpbwh returns
.IP
 0, if *lb >= ub (sieving area is empty),
 1, if the entire sieving area has been checked for 
    points,
 2, if the computation has been finished before the 
    entire sieving area has been checked for points 
    (modus = 0 or 1), and
 ERROR, else.  
 
.SH SEE ALSO
ecrinit

M*/
   
/*H
					
	Version 1       12.11.1992      Josef Gebel
        Version 2       21.01.1993      Auslagerung aus 'ecrmaninalg' und
					Anpassung an neues Konzept. JG.
        Version 3       13.07.1993      Beschleunigung. JG.
        Version 4       13.09.1993      Fall 'modus < 0' eingefuehrt. 
					Im Fall 'modus = 0' 'R_test'
					eingefuehrt. JG.
        Version 5       21.05.1994      Endabfrage verbessert. JG.
        Version 6       11.10.1995      Siebverfahren beschleunigt. JG.
   DATE ecisnfpbwh    : 930531.931130.941201.951201
H*/

#include <_ec2.h> 

/**************************************************************************/
/***                                                                    ***/
/***   C o n s t a n t s   a n d   g l o b a l   v a r i a b l e s      ***/
/***                                                                    ***/
/**************************************************************************/

#define MAXL 240000    /***   maximal length of the sieve array     ***/
#define N1 3           /***   number of 'large' sieve modules       ***/
#define N2 6           /***   number of 'small' sieve modules       ***/

single *M1,            /***   array containing the 'large' modules  ***/
       *M2,            /***   array containing the 'small' modules  ***/
                       /***     where M1[i] = M2[2*i] * M2[2*i+1]   ***/
       *adr,           /***   auxiliary variable to find the right  ***/
                       /***     address in the array Q2             ***/
       lb,             /***   length of the array B1                ***/
       zc;             /***   if zc != 0: B1 has to be computed     ***/
                       /***   if zc == 0: 'old' B1 is still valid   ***/
char   *B1,            /***   sieve array for the 'large' modules   ***/
       *S,             /***   sieve array                           ***/
       *Q2;            /***   array indicating wether a residue     ***/
                       /***     mod M2[i] is a square or not.       ***/

/**************************************************************************/
/***                                                                    ***/
/***                  B e g i n n i n g  o f   t h e                    ***/
/***                                                                    ***/
/***                     s t a t i c  -  b l o c k                      ***/
/***                                                                    ***/
/**************************************************************************/


static get_squares( Q, p )
char *Q;
single p;
{
    single j, k, l;

    l = p >> 1;
    j = 1;
    k = 1;

    *Q = *( Q + 1 ) = 1;

    while( k < l )
    {
        j += k;
        k++;
        j += k;
        if( j >= p )
        {
            j -= p;
        }

        *( Q + j ) = 1;
    }
    return( 0 );
}

/*c
                   is_point( P )

	"is point?"
        static is_point( P ) list P;
	static-module of ecisnfpbwh.S
	Return: 1, if P = ( x  y  z ) int x, y, z;
                0  otherwise.
c*/

static single is_point( P )
list P;
{
    bind( P );

    if( llength( P ) != 3 )
    {
        return( 0 );
    }
    if( !isint( lfirst( P ) ) )
    {
        return( 0 );
    }
    if( !isint( lsecond( P ) ) )
    {
        return( 0 );
    }
    if( !isint( lthird( P ) ) )
    {
        return( 0 );
    }
    return( 1 );
}

/*c
                   eciminset( E, L, P, h, R, s )

	"elliptic curve with integer coefficients, minimal model, 
	 set matrix"
        static eciminset( E, L, P, h, R, s )
               list E, L, P; floating h; matrix R; single s;
	static-Modul zu ecisnfpbwh. 
        eciminset setzt die die s-te Zeile und die s-te Spalte der
	symmetrischen (r x r)-Matrix R (r = rank(E/Q)) auf
	   (  h( P_1, P )  h( P_2, P ) ...  h( P_s, P )  h ),
        wobei 1 <= s <= r, L = ( P_1  h1  P2  h2  ...  P_s-1  h_s-1 ),
	      h_i = h( P_i) und h = h( P ) = h( P, P ) sind.
	Alle Eintraege R_ij mit i != s und j != s bleiben unveraendert.
	R wird veraendert.
	Rueckgabe: Matrtix R. 
c*/

static single eciminset( E, L, P, h, R, s )
list E, L, P;
floating h;
matrix R;
single s;
{
    single j, inv;
    list W, L1;
    floating fl;

    init( W, L1 );
    init( fl );
    bind( E, L, P, h, R );

    if( L != _0 )
    {
        L1 = L;
        j = 0;
        W  = lfirst( L1 );
        inv = 0;
        if( ( llength( W ) != 3 ) || !isponecimin( E, W ) )
        {
            inv = 1;
        }

        while( L1 != _0 )
        {
            /*   Enter the values into the matrix R     */
	    j++;

            if( inv )
            {
                W = lsecond( L1 );
            }
            else
            {
                W = lfirst( L1 );
            }

            if( ( llength( W ) != 3 ) || !isponecimin( E, W ) )
            {
                return( 0 );
            }
	    fl = eciminnetapa( E, P, W );

	    masetel( R, j, s, fl );
	    masetel( R, s, j, fl );
	    L1 = lred2( L1 );
        }
    }

    masetel( R, s, s, h );

    return( R );
}
/*********************   End of  e c i m i n s e t   ***********************/

/*c
               R_test( E, s, BL, R, P, h, rlb )

	"regulator test"
        static R_test( E, s, BL, R, P, h, rlb )
                list E, BL, P; single s; matrix R; floating h, rlb;
	static-Modul zu ecisnfpbwh. 
	Dabei muss gelten:
	 - 1 <= s <= r = rank( E/Q )
	 - BL = ( P1  h1  P2  h2  ...  P(s-1)  h(s-1) )
	   mit hi = h( Pi ) und Pi linear unabhaengig
         - R = [R(i,j)]i,j ist eine (r x r)-Matrix von der Gestalt:
	               / h( Pi, Pj ), falls 1 <= i, j <= s-1
	      R(i,j) =<      1      , falls i = j >= s
	               \     0        sonst
         - rlb ist eine untere Abschaetzung fuer den Regulator von E/Q
	R_test setzt m(i,s) = m(s,i) = h( Pi, P ) fuer 1 <= i <= s,
	laesst alle anderen Eintraege von R unveraendert und
	berechnet die Determinante der neuen Matrix R.
	Falls R < rlb, so wird det( 2 * R ) berechnet, um zu erkennen, 
	ob det(R) = 0 ist.
	Rueckgabe: det( R ).
c*/


static R_test( E, s, BL, R, P, h, rlb )
list E, BL, P;
single s;
matrix R;
floating h, rlb;
{
    floating fl, epsilon;

    init( fl, epsilon );
    bind( E, BL, P );
    bind( R );
    bind( h, rlb );
   
    epsilon = flsquot( rlb, 2 );

    eciminset( E, BL, P, h, R, s + 1 );

    fl = mafldet( R );

    if( flcomp( fl, epsilon ) > 0 )
    {
	return( fl );
    }
    else
    {
        return( 0 );
    }
}
/**************************   End of  R _ t e s t   ************************/

/*c
         sieve( l, x, az, bz )

        "sieve"
        static sieve( l, x, az, bz ) single l; int x, az, bz;
	static-Modul zu ecisnfpbwh. 
	n = sieve( l, x, az, bz )
        sieve siebt im Intervall [ x, x + l - 1 ] alle k aus, fuer die
           y^2 = k^3 + az * k + bz  mod m  (m = M[1],..., M[M])
        keine Loesung y in Z/mZ (und damit auch in Z) hat.
	Rueckgabe: 0
c*/

static single sieve( l, x, az, bz )
single l;
int x, az, bz;
{
    single i, j, j1, m1, x0;
    char   *b1, *s1, *k, *s;

    extern single *M1, *M2, *adr, zc;
    extern char   *B, *S;
  
    bind( x, az, bz );

    if( ( S = ( char * ) memset( S, 0, l ) ) == NULL )
    {
        /***  ERROR  # 1 ***/
        return( 1 );
    }

    if( ( zc && ( B1 = ( char * ) memset( B1, 0, lb ) ) == NULL ) )
    {
        /***  ERROR  # 10  ***/
        return( 10 );
    }
 
    b1 = B1;

    for( j1 = 0; j1 < N1; j1++ )
    {
        m1 = M1[j1];

        if( zc )
        {
            single m2, m21, j2, v;
            single a0, b0;
            single X1, X2;
            char   *q2;

            extern char *Q2;

            /**bind( az, bz ); **/

            s1 = b1 + m1;

            for( j2 = 0; j2 < 2; j2++ )
            {
                /***   We compute                                   ***/
                /***     f( x+1 ) = (x+1)^3 + A*(x+1) + B           ***/
                /***              = x^3 + A*x + B + 3x^2 + 3x + A+1 ***/
                /***              = f( x ) + 3x^2 + 3x + A+1        ***/
                /***   starting with                                ***/
                /***     f( 0 )   = B                               ***/

                zc--;

                v  = ( j1 << 1 ) + j2;
                m2 = M2[ v ];
                m21 = m2 - 1;

                q2 = Q2 + adr[ v ];

                b0 = mshom( m2, bz );

                a0 = mshom( m2, az );
                a0++;
                if( !( a0 - m2 ) )
                {
                    a0 = 0;
                }

                v = 0;

                X1 = 0;
                X2 = 0;

                if( *( q2 + b0 ) )
                {
                    for( k = b1 + v; k < s1; k += m2 )
                    {
                        *k = 1;
                    }
                }

                while( 1 )
                {
                    v++;
                    m21--;
                    b0 += a0;
                    b0 += X1;
                    b0 += X2;
                    while( b0 >= m2 )
                    {
                        b0 -= m2;
                    }

                    if( *( q2 + b0 ) )
                    {
                        for( k = b1 + v; k < s1; k += m2 )
                        {
                            *k = 1;
                        }
                    }

                    if( !m21 )
                    {
                        break;
                    }

                    X2 += X1;
                    X1 += 3;
                    if( X1 >= m2 )
                    {
                        X1 -= m2;
                    }
                    X2 += X1;
                    while( X2 >= m2 )
                    {
                        X2 -= m2;
                    }
                }
            }
        }

        s = S + l;
        x0 = mshom( m1, x );
        s1 = b1 + x0;
        i  = m1 - x0;

        for( j = 0; j < m1; j++ )
        {
            if( !( i - j ) )
            {
                s1 = b1;
            }

            if( *( s1++ ) )
            {
                /***   x0^3 + a0 * x0 + b0 = y^2 hat keine    ***/
                /***   Loesung mod m1 ==> keine Loesung in Z   ***/

                for( k = S + j; k < s; k += m1 )
                {
                    *k = 1;
                }
            }
        }
        b1 += m1;
    }
    return( 0 );
}

/**************************   End of  s i e v e   **************************/

/*c
                    sieve_init( )

	"sieve initialization"
        static single sieve_init( )
	static-Modul zu ecisnfpbwh. 
	n = sieve_init( );
        sieve_init initialisiert das (externe) Array M vom Typ
        single mit den N Moduln, bzgl. derer gesiebt wird.
	Rueckgabe: M[0] + ... + M[N-1] bei Erfolg, 0 sonst.
c*/

static single sieve_init( )
{
    char   *q2;
    single i, j, k, l, m, n, p;

    extern single *M1, *M2, *adr, lb;
    extern char   *B1, *S, *Q2;

    k = sizeof( single );

    if( ( M1 = ( single * ) malloc( N1 * k ) ) == NULL )
    {
        /***  ERROR # 2  ***/
        return( 2 );
    }

    if( ( M2 = ( single * ) malloc( N2 * k ) ) == NULL )
    {
        /***  ERROR # 3  ***/
        return( 3 );
    }

    if( ( adr = ( single * ) malloc( N2 * k ) ) == NULL )
    {
        /***  ERROR # 4  ***/
        return( 4 );
    }

    m = 0;

    for( i = 0; i < N2; i++ )
    {
        switch( i )
        {
/*
            case  0: M2[ i ] =  16;
                     break;
            case  1: M2[ i ] =  17;
                     break;
            case  2: M2[ i ] =  33;
                     break;
            case  3: M2[ i ] =  35;
                     break;
            case  4: M2[ i ] =  13;
                     break;
            case  5: M2[ i ] =  19;
                     break;
            case  6: M2[ i ] =  17;
                     break;
            case  7: M2[ i ] =  19;
                     break;
            default: break;
*/
            case  0: M2[ i ] =  64;
                     break;
            case  1: M2[ i ] =  63;
                     break;
            case  2: M2[ i ] =  55;
                     break;
            case  3: M2[ i ] =  47;
                     break;
            case  4: M2[ i ] =  41;
                     break;
            case  5: M2[ i ] =  43;
                     break;
            default: break;
/*
            case  0: M2[ i ] =  32;
                     break;
            case  1: M2[ i ] =  25;
                     break;
            case  2: M2[ i ] =  63;
                     break;
            case  3: M2[ i ] = 143;
                     break;
            case  4: M2[ i ] =  17;
                     break;
            case  5: M2[ i ] =  19;
                     break;
            default: break;
*/
        }
        adr[ i ] = m;
        m += M2[ i ];
    }

    k =  m * sizeof( char );
    if( ( Q2 = ( char * ) malloc( k ) ) == NULL )
    {
        /***  ERROR # 5   ***/
        return( 5 );
    }
    if( ( Q2 = ( char * ) memset( Q2, 1, k ) ) == NULL )
    {
        /***  ERROR  # 6  ***/
        return( 6 );
    }

    q2 = Q2;

    for( i = 0; i < N2; i++ )
    {
        m = M2[ i ];
        l = m >> 1;
        j = 1;
        k = 1;

        /***  Q2[i] = 0 <==> i ist quadratischer Rest      mod m   ***/
        /***  Q2[i] = 1 <==> i ist quadratischer Nichtrest mod m   ***/

        *q2 = *( q2 + 1 ) = 0;
        /***   0 und 1 sind quadratische Reste mod m   ***/

        while( k < l )
        {
            j += k;
            k++;
            j += k;
            if( j >= m )
            {
                j -= m;
            }

            *( q2 + j ) = 0;
        }
        q2 += m;
    }

    lb = 0;

    for( i = 0; i < N1; i++ )
    {
        M1[ i ] = M2[ 2 * i ] * M2[ 2 * i + 1 ];
        lb += M1[ i ];
    }

    k = lb * sizeof( char );

    if( ( B1 = ( char * ) malloc( k ) ) == NULL )
    {
        /***  ERROR # 7   ***/
        return( 7 );
    }

    return( 0 );
}

/*******************   End of  q u a d r a t _ i n i t   *******************/

/*c

        static enoughpoints( E, PL, hmin, BL ) list E, *PL, *BL; floating hmin;
        Rueckgabe 0, falls bereits genuegend viele Punkte gefunden wurden,
                  r = Rang( E/Q ) sonst.
c*/

static enoughpoints( E, PL, hmin, s, BL, R )
list     E, *PL, *BL;
floating hmin;
single   *s;
matrix   *R;
{
    single   r;
    list     P, HL;
    floating rlb, f1;

    bind( E, *PL, *BL, *R, hmin );
    init( P, HL, rlb, f1 );

    if( !( r = ecrrank( E ) ) )
    {
        return( 0 );
    }

    *R = maconsdiag( r, itofl( 1 ) );
    /***   R ist(r x r)-Einheitsmatrix  ***/

    HL  = *PL;
    *BL = _0;
    rlb = hmin;

    while( HL != _0 )
    {
	P  = lfirst ( HL );
	f1 = lsecond( HL );
        f1 = R_test( E, *s, *BL, *R, P, f1, rlb );
        if( f1 )
        {
	    f1 = lsecond( HL );
            *BL = lcomp2( f1, P, *BL );
            rlb = f1;
            (*s)++;
            if( *s == r ) 
            {
		*BL = linv( *BL );
                return( 0 );
            }
        }
	HL = lred2( HL );
    }
    *BL = linv( *BL );

    return( r );
}

/*********************   End of  e c i m i n s e t   ***********************/

/*c
        static free_global()
        free_global gibt den Speicherplatz der globalen Arrays, der in
        ecisnfpbwh allokiert wurde, wieder frei.
        Rueckgabe 0.
c*/

free_global()
{
    extern single *M1, *M2, *adr;
    extern char   *B1, *S;

    free( M1 );
    free( M2 );
    free( adr );
    free( B1 );
    free( Q2 );
    free( S );

    return( 0 );
}
/*********************   End of  f r e e _ g l o b a l    ******************/

/**************************************************************************/
/***                                                                    ***/
/***                       E n d   o f   t h e                          ***/
/***                                                                    ***/
/***                     s t a t i c  -  b l o c k                      ***/
/***                                                                    ***/
/**************************************************************************/

/*****************   Beginning of  e c i s n f p b w h   ******************/

ecisnfpbwh( E, PL, lb, ub, modus, hmin, BL )
list     E, *PL, *BL;
floating *lb, ub, hmin;
single   modus;
{
    char     *T, *Qp1, *Qp2, *Qp3;
    single   flag, sl, i, k, l, r, s, maxl, con;
    single   p1, p2, p3, zmin, zmax;
    int      x0, x1, x2, w0, w1, w2, z1, z2;
    int      x, y, z, zz, p, a, b, az, bz, xx, Z;
    list     Fz, P, BT;
    floating f1, f2, rlb;
    matrix   R;

    extern single *M, zc;

    bind( *lb, ub, hmin );
    bind( E, *PL, *BL ); 

    if( flsign( *lb ) < 0 )
    {
	*lb = 0;
    }

    init( x0, x1, x2, w0, w1, w2, z1, z2 );
    init( x, y, z, zz, p, a, b, az, bz, xx, Z );
    init( Fz, P, BT );
    init( f1, f2, rlb );
    init( R );

    s = 0;
    r = -1;
    rlb = hmin;

    if( !modus && ( !( r = enoughpoints( E, PL, hmin, &s, BL, &R ) ) ) )
    {
         return( 2 );
    }
    
    if( ( flcomp( *lb, ub ) > 0 )  ||  ( flsign( ub ) < 0 ) )
    { 
	/*   Siebintervall ist leeres Intervall   */

	return( 0 );
    }

    if( k = sieve_init( ) )
    {
        return( ERROR );
    }

    p1 = 4199;
    p2 = 765049;

    if( ( Qp1 = ( char * ) malloc( p1 ) ) == NULL )
    {
        return( 5 );
    }
    get_squares( Qp1, p1 );

    if( ( Qp2 = ( char * ) malloc( p2 ) ) == NULL )
    {
        return( 5 );
    }
    get_squares( Qp2, p2 );

/*
    if( ( Qp3 = ( char * ) malloc( p3 ) ) == NULL )
    {
        return( 5 );
    }
    get_squares( Qp3, p3 );
*/


    /*   Y^2 = X^3 + a X + b kurze WNF fuer E                     */
    a = ecisnfa4( E );
    b = ecisnfa6( E );

    /************************************************************************/
    /*                                                                      */
    /*   Sei u1 = log( max{ 1, *lb } ),    w1 = max{ 1, sqrt( u1 ) }        */
    /*       u2 = log( max{ 1,  ub } ),    w2 = max{ 1, sqrt( u2 ) }.       */
    /*   Dann wird in den Intervallen I1, I2, I3 gesiebt.                   */
    /*   Falls lb = 0 ( ==> w1 = 1 ), so sind die Intervalle                */
    /*   I1, I2 und I4 leer.                                                */
    /*                                                                      */
    /*                                                                      */
    /*   w2 ----|---------------------------------------------------|       */
    /*          |                                                   |       */
    /*          |                                                   |       */
    /*          |                   Intervall I3                    |       */
    /*          |                                                   |       */
    /*          |                                                   |       */
    /*   w1 ----|------------|-------------------------|------------|       */
    /*          |            |                         |            |       */
    /*          |            |                         |            |       */
    /*          | Intervall  |                         |  Intervall |       */
    /*          |            |      Intervall I4       |            |       */
    /*          |     I2     |                         |      I1    |       */
    /*          |            |                         |            |       */
    /*   1  ----|------------|------------|------------|------------|--> u  */
    /*         -u2          -u1           0            u1           u2      */
    /*                                                                      */
    /************************************************************************/
 
    if( *lb != 0 ) 
    {
        flag = 1;

        f1 = flsquot( *lb, 2 );
        f1 = flexp( f1 );
        z1 = flfloor( f1 ); 
        x1 = iprod( z1, z1 );
    }
    else
    {
        flag = 3;

	z1 = 1;
	x1 = 0;
    }
    zmin = 0;
    
    f1 = flsquot( ub, 2 );
    f1 = flexp( f1 );
    z2 = flfloor( f1 );
    z2 = isum ( z2, 1 );
    x2 = iprod( z2, z2 );

    x0 = isum( isprod( x2, 2 ), 1 );

    /**   Allokieren des Siebarrays                             **/
    maxl = 270000;
    if( icomp( maxl, x0 ) > 0 )
    {
	sl = x0;
    }
    else 
    {
	sl = maxl;
    }

    if( ( S = ( char * ) malloc( sl * sizeof( char ) ) ) == NULL )
    {
        free_global();
        return( ERROR );
    }
    /**   Allokieren des Siebarrays               ( E N D E )   **/

    /**   Beginn des Siebens                                    **/

    /**   Es wird in den drei Teilintervallen                   **/
    /**      I1 = [-x2, -x1] X [1, z1],                         **/
    /**      I2 = [ x1,  x2] X [1, z1]                          **/
    /**   und                                                   **/
    /**      I3 = [-x2, x2] X [z1, z2]                          **/
    /**   gesiebt, wobei xi = exp(hi), zi = exp(hi/2), i = 1,2. **/
    /**   Im Teilintervall                                      **/
    /**      I4 = [-x1, x1] X [1, z1]                           **/
    /**   wird nicht gesiebt.                                   **/
    /**   Zuerst wird in den beiden Intervallen I1 und I2       **/
    /**   gesiebt, danach in I3. Falls x1 = 0 und z1 = 1 sind,  **/
    /**   wird nur in I3 = I gesiebt.                           **/
    
    /**   Wenn x0 die kleinste reelle Nullstelle des Polynoms   **/
    /**              f(X) = X^3 + a X + b                       **/
    /**   ist, dann gilt fuer alle x < x0: f(x) < 0, also ins-  **/
    /**   sondere ist f(x) kein Quadrat, d.h. es gibt keinen    **/
    /**   Punkt P = (x, y) auf E mit x < x0. Mit x0 ist dann    **/
    /**   x0(Z) = x0 * Z^2   die kleinste reelle Nullstelle     **/
    /**   des Polynoms  X^3 + (a Z^4) X + (b Z^6).              **/
    {
        rat  ar, br;
        list L;
 
        init( ar, br, L );
 
        ar = itor( a );
        br = itor( b );
        L = ecrsnfrroots( ar, br );

        if( llength( L ) == 1 )
        {
            f2 = lfirst( L );
        }
        else
        {
            f2 = lthird( L );
        }
        x0 = flfloor( f2 );
    }

    while( flag )
    {
        w0 = x0;

	switch( flag )
	{

	    case 1:   /** Sieb in I2 = [x1, x2] X [1, z1]   **/

                  con = 0;

	          w1 = x1;
	          w2 = x2;
	          z  = 1;
                  if( isign( x0 ) > 0 )
                  {
                      f1 = itofl( x2 );
                      f1 = flquot( f1, f2 );
                      f1 = flsqrt( f1 );
                      zz = isum( 1, flround( f1 ) );
                  }
                  else
                  {
		      zz  = z1;
                  }
		  flag = 2;

		  break;

	    case 2: /** Sieb in I1 = [-x2, -x1] X [1, z1]   **/

                  con = 1;

	          w1 = ineg( x2 );
	          w2 = ineg( x1 );
	          z  = 1;
	          zz = z1;
	          flag = 3;

	          break;

	    case 3:  /** Sieb in I3 = [-x2, x2] X [z1, z2]  **/

                  con = 0;
 
                  w1 = ineg( x2 );
	          w2 = x2;
                  z  = z1;
                  if( isign( x0 ) > 0 )
                  {
                      f1 = itofl( x2 );
                      f1 = flquot( f1, f2 );
                      f1 = flsqrt( f1 );
                      zz = isum( 1, flround( f1 ) );
                  }
                  else
                  {
		      zz = z2;
                  }
	          flag = 0;

	          break;

        }                     /** switch( flag ) ** (Ende)  **/

	BT = ecisnfbtmin( E );
    
        if( modus == -9 )
        { 
            zz = 2;
        }

        while( icomp( zz, z ) > 0 ) 
	{
            p = isprod( z, z );
            y = iprod(  p, p );
            az = iprod( y, a );
            bz = iprod( iprod( y, p ), b );

            f1 = flprod( f2, itofl( p ) );
            w0 = flfloor( f1 );
            y = x;

	    if( icomp( w1, w0 ) < 0 ) 
	    {
		x = w0;
	    }
	    else 
	    { 
		x = w1; 
            }

            if( con  &&  icomp( w2, x1 ) < 0 ) 
            { 
                if( ( con > 1 )  &&  ( icomp( x, y ) > 0 ) )
                {
                      break;
                }
                con = 2;
            }

            zc = N2;

            while( icomp( w2, x ) > 0 )
	    {
                /*   Initialisieren des Sieb-Arrays mit Nullen       */

		xx = idif( w2, x );
		if( icomp( xx, sl ) < 0 ) 
		{
		    l = xx;
		    l++;
	        }
		else 
		{
		    l = sl;
                }

                if( sieve( l, x, az, bz ) )
                {
                    free_global();
                    return( ERROR );
                } 
                /*   Auswerten des Siebintervalls                    */
		k = 0;
                T = S;
                
                while( k < l ) 
		{
		    if( !*( T++ ) ) 
		    { 
                        /*   f(x + k) ist moegliches Quadrat in Z    */

		        xx = isum( x, k );
 
                        if( igcd( xx, z ) == 1 )
			{
		            p = iprod( xx, xx );
		            p = isum( bz, iprod( xx, isum( az, p ) ) );
                            /***    p = f( xx ) = f( x + k )       ***/

                            if( ( isign( p ) >= 0 )
                            &&  ( *( Qp1 + mshom( p1, p ) ) )
                            &&  ( *( Qp2 + mshom( p2, p ) ) ) )
                            {
                                y = isqrt( p );

			        if( !idif( iprod( y, y ), p ) )
			        {
		                    /*   y^2 = f(x + k)              */
                                    /*          / x+k   y  \         */
                                    /*   Punkt  | ---, --- |         */
                                    /*          \ z^2  z^3 /         */
                                    /*   gefunden                    */
        
                                    P  = ecrbtp( list3( xx, y, z ), BT );
				    f1 = eciminnetahe( E, P );
			            p = isineciminpl( E, P, f1, *PL );

                                    if( modus < 0 )
                                    {
                                        switch( p )
                                        {
                                            case -3:
                                            case -1:
                                            case  1: p = 1;
                                                     break;
                                            default: p = 0;
                                                     break;
                                        }
                                    }

			            if( !p )
			            {
				        eciminplinsp( P, f1, PL );
				        if( !modus )
				        {
                                            if( f1 = R_test( E, s, *BL, R, P, f1, rlb ) )
					    {
		                                *BL = lcomp2( P, f1, *BL );
		                                rlb = f1;
                            		        s++;
					    }
	                                }
                                        if( ( s == r ) 
                                        || !( ( modus % 4 ) - 1 ) )
		                        {
                                            free_global();
		                            return( 2 );
	                                }
		                    }
		                }
		            }
		        } /*   if( igcd( ...             ( ENDE )   */
                    } /*   if( ! *( T++ ) )              ( ENDE )   */

		    k++;

                } /*   while( k < l )                    ( ENDE )   */

                x = isum( x, l );

            }   /*   while( icomp( w2, x ) > 0 )        ( ENDE )   */

	    z++;

        }   /*   while( icomp( zz, z ) > 0 )             ( ENDE )   */
        
    }   /*   while( flag )                               ( ENDE )   */
        
    free_global();
    *lb = ub;
}

/********************   End of  e c i s n f p b w h   ***********************/
