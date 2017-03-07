/*M
.SH NAME
qnfielpifact - quadratic number field integral element prime ideal factorization

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfielpifact(D, b, L)  
int D; 
nfel b; 
list L;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B b
is an element of the ring of integers, say O_K, of K. b is not zero or an unit in O_K (for the representation of number field elements s. fputnfel).
.TP 4
.B L
= ( p_1 e_1 ... p_k e_k )  int p_i; single e_i; i = 1...k, is a list, containing all prime divisors p_i of the norm of b and their belonging exponents e_i, so
.IP
|norm(b)| = p_1^e_1 * ... * p_k^e_k.
.PP 
qnfiepifact computes the factorization of the ideal (b) in prime ideals, say P_j, j = 1...l, in O_K (for representation of ideals s. qnfidprod).
.PP
qnfiepifact returns a list (P_1 f_1 pi_1 z_1 ... P_l f_l pi_l z_l), where the
.PP
P_i's, i = 1...l, are the prime factors of (b),
.PP
f_i's are the exponents of the P_i's in the factorization of (b),
.PP
pi_i's are locally uniformizing parameters of the P_i's, and
.PP
z_i = 0, for p_i inertial, i.e. (p_i) = P_i,
    = 1, for p_i ramified, i.e. (p_i) = P_i^2
    = 2, for p_i split, i.e. (p_i) = P_i * P_j, i != j.

.SH SEE ALSO
 fputnfel
 qnfidprod

M*/
                    
/*H
	Version 1       06.06.1993 	Josef Gebel, Claude Grasser
	Version 1.1	08.11.1994	Z.163 P2. US.
	Version 2       23.10.1995      QNFIELPIFACTS --> QNFIELPIFACT  JG
   DATE qnfielpifact : 931130.941201.951201
H*/

#include <_arith2.h>

static qnfielavalipr2(int,int,nfel);

list qnfielpifact( D, a, L )
int  D;
nfel a;
list L;
{
    single e, f, g;
    list   M, Lram, P;
    int    z, h, p;
    nfel   pi1;

    bind( D, a, L );

    init( M, Lram, P );
    init( z, h, p );
    init( pi1 );

    M = _0;
    g = m4hom( D );
    if( g == 1 )
    {
        f = 1;
    }
    else
    {
        f = 0;
    }

    while( L != _0 )
    {
	p = lfirst( L );
	e = lsecond( L );

	Lram = qnframind( D, p );

	if( llength( Lram ) == 1 )
	{
	    if( lfirst( Lram ) == 1 )
	    {
	        /*   p 'traege' in Q(D^(1/2)): (p) = (pi).            */
		/*   pi  = p                                          */
		/*   (p) = (p)*[1,(1+D^(1/2))/2], falls D = 1 mod 4   */
                /*         Darstellung: ( p, 2, 1, 2 )                */
		/*   (p) = (p)*[1,D^(1/2)], falls D = 2, 3 mod 4      */
                /*         Darstellung: ( p, 1, 0, 1 )                */
	        
		pi1 = list3( 1, 0, p );
		M = lcomp4( list4( p, f + 1, f, f + 1 ), e/2, pi1, 0, M );
	    }
	    else
	    {
	        /*   p 'verzweigt' in Q(D^(1/2)): (p) = (pi)^2        */

		if( ( p == 2 ) && ( g == 3 ) )
		{
		    /*   pi  = 1 + D^(1/2)                            */
		    /*   (2) = [2,1+D^(1/2)]                          */
                    /*         Darstellung: ( 1, 2, 1, 1 )            */
		    pi1 = list4( 1, 1, 1, 1 );
                    P = list4( 1, 2, 1, 1 ); 
		}
		else
		{
		    /*   p != 2 oder p = 2 und g = 2                  */
		    
		    /*   pi  = D^(1/2)                                */
		    /*   (p) = [p,D^(1/2)]                            */
                    /*         Darstellung: ( 1, p, 0, f + 1 )        */
		    pi1 = list4( 1, 1, 1, 0 );
		    if( f )
		    {
                        P = list4( 1, isprod( p, 2), p, 2 ); 
		    }
		    else
		    {
                        P = list4( 1, p, 0, 1 ); 
		    }
		}
	        M = lcomp4( P, e, pi1, 1, M );
	    }
	}
	else
	{
	    /*   p 'zerlegt' in Q(D^(1/2)): (p) = pi1 * pi2   */
	    single d;
	    list P1, P2;
	    nfel b, pi2;

            init( P1, P2 );
            init( b, pi2 );

	    if( p == 2 )
	    {
		/*   D = 1 mod 4 (immer)   */

		h = mshom( 16, D );

		if( h == 1 )
		{
		    /*  pi1 = 1 + [ 1 + D^(1/2) ] / 2                */
		    /*      = [3 + D^(1/2)] / 2                      */
		    /*  P1  = [ p, (3 + D^(1/2))/2 ]                 */
                    /*         Darstellung: ( 1, 4, 3, 2 )           */
                    pi1 = list4( 2, 1, 1, 3 );      
                    P1  = list4( 1, 4, 3, 2 );      
		    
		    /*  pi2  = 2 - [ 1 + D^(1/2) ] / 2               */
		    /*       = [3 - D^(1/2)] / 2                     */
		    /*  pi2* = 2 - pi2 = 1/2 + D^(1/2)/2             */
		    /*  P2   = [ p, (1 + D^(1/2))/2 ]                */
                    /*         Darstellung: ( 1, 4, 1, 2 )           */
                    pi2 = list4( 2, 1, -1, 3 );
                    P2  = list4( 1, 4, 1, 2 );      
	        }
	        else
		{
		    /*  pi1 = [1 + D^(1/2) ] / 2                     */
		    /*  P1  = [ p, (1 + D^(1/2))/2 ]                 */
                    /*         Darstellung: ( 1, 4, 1, 2 )           */
                    pi1 = list4( 2, 1, 1, 1 );      
                    P1  = list4( 1, 4, 1, 2 );      
		    
		    /*  pi2  = 1 - [ 1 + D^(1/2) ] / 2               */
		    /*       = [1 - D^(1/2)] / 2                     */
		    /*  pi2* = 2 - pi2 = 3/2 + D^(1/2)/2             */
		    /*  P2   = [ p, (3 + D^(1/2))/2 ]                */
                    /*         Darstellung: ( 1, 4, 3, 2 )           */
                    pi2 = list4( 2, 1, 1, -1 );
                    P2  = list4( 1, 4, 3, 2 );      
		}
	    }
	    else 
	    {
	        /*   p zerlegt: p = pi1 * pi2                        */
		int x, y, p2, t;

		init( x, y, p2, t );

	        if( f )
	        {
		    /*   D = 1 mod 4   */
		    list Lh;

		    init( Lh );

		    h = idif( D, 1 );
		    h = ineg( isquot( h, 4 ) );
		    h = mihom( p, h );
		    if( h )
		    {
		        /*   P( X ) = X^2 + X - (D-1)/4   */
		        P = list6( 2, 1, 1, 1, 0, h ); 
        	
		        Lh = upmirf( p, P );
          	        z = lfirst( Lh );  
		        if( icomp( z, lsecond( Lh ) ) > 0 )
		        {
			    z = lsecond( Lh );
		        }

		        h = isum( h, z );
		        h = isum( h, iprod( z, z ) );
                    }
		    else
		    {
	                /*  P( X ) = X^2 + X: Die kleinste           */
		        /*  Nullstelle im Restsystem {0, ...,p-1}    */
		        /*  ist immer z = 0: h bleibt unveraendert.  */
			z = 0;
		    }
	    	
		    p2 = iprod( p, p );
		    if( !mihom( p2, h ) )
		    {
		        z = isum( z, p );
		    }
		    
		    p2 = isprod( p, 2 );

		    /*  pi1 = z + [ 1 + D^(1/2) ] / 2   */
		    /*       = [ (2 * z + 1) + D^(1/2) ] / 2         */
		    /*  t    = 2 * z + 1 mod 2 * p, 0 <= t < 2 * p   */
		    /*  P1   = [ p, (t + D^(1/2))/2 ]                */
                    /*         Darstellung: ( 1, 2 * p, t, 2 )       */
                    pi1 = list4( 2, 1, 1, 1 );      
		    pi1 = qnfisum( D, pi1, z );
		    t   = lfourth( pi1 );
		    t   = mihom( p2, t );
		    if( ieven( t ) )
		    {
			t = isum( t, p );
		    }
                    P1  = list4( 1, p2, t, 2 );      
		    
		    /*  pi2  = z + [ 1 - D^(1/2) ] / 2               */
		    /*       = [ (2 * z + 1) - D^(1/2) ] / 2         */
		    /*  t    = -2 * z + 1 mod 2 * p, 0 <= t < 2 * p  */
		    /*  pi2* = [ t + D^(1/2) ] / 2                   */
		    /*  P2   = [ p, (t + D^(1/2))/2 ]                */
                    /*         Darstellung: ( 1, 2 * p, t, 2 )       */
                    pi2 = list4( 2, 1, -1, 1 );
		    pi2 = qnfisum( D, pi2, z );
		    t   = ineg( lfourth( pi2 ) );
		    t   = mihom( p2, t );
		    if( ieven( t ) )
		    {
			t = isum( t, p );
		    }
                    P2  = list4( 1, p2, t, 2 );      
	        }
	        else
	        {
		    /*   D = 2 oder 3 mod 4   */

		    h = mipsqrt( p, mihom( p, D ) );
		    z = idif( p, h );
		    if( icomp( h, z ) > 0 )
		    {
			/*   h > z  */
			h = z;
		    }
		    z  = iprod( h, h );
		    z  = idif ( z, D );
		    p2 = iprod( p, p );
		    z  = mihom( p2, z );    /*    h modulo p^2    */
    
		    if( z == 0 )
		    {
		        h = isum( h, p );
		    }

		    /*  pi1 = h + D^(1/2)                            */
		    /*  P1  = [ p, t + D^(1/2) ] mit t = h mod p     */
                    /*         Darstellung: ( 1, p, t, 2 )           */
                    pi1 = list4( 1, 1,  1, h );
		    t   = mihom( p, h );
                    P1  = list4( 1, p, t, 1 );      
		    
		    /*  pi2  = h - D^(1/2)                           */
		    /*  pi2* = t + D^(1/2) mit t = (-h) mod p        */
		    /*  P2  = [ p, t + D^(1/2) ] mit t = h mod p     */
                    /*         Darstellung: ( 1, p, t, 2 )           */
		    pi2 = list4( 1, 1, -1, h );
		    t   = mihom( p, ineg( h ) );
                    P2  = list4( 1, p, t, 1 );      
	        }
	    }

	    /*   p zerlegt: p = pi1 * pi2                             */
	    /*   a = pi1^d1 * pi2^d2 * b   und   N(a) = p^e * q.      */
	    /*   a = p^d * pi1^d1' * b  oder  a = p^d * pi2^d2' * b   */
	    /*   Dann ist   e = d1 + d2   und   d = min{ d1, d2 }.    */
	    /*   Falls pi1 | (a/p^d), so ist  d = d1, sonst  d = d2   */
	    /*   ==> d1 = e-d und d2 = d  bzw.  d2 = e-d und d1 = d   */

	    d = qnfielavalipr2( p, D, a );
	    e -= d;
	    h = iexp( p, d );
	    b = qnfiquot( D, a, h );   /*  b = a / p^d   */

	    b = qnfquot( D, b, pi1 );

	    if( isqnfiel( D, b ) )
	    {
		/*   pi1 teilt b ==> d1 = d, d2 = e - d   */
		if( e )
		{
	            M = lcomp4( P2, e, pi2, 2, M );
		}
		if( d )
		{
	            M = lcomp4( P1, d, pi1, 2, M );
		}
	    }
	    else
	    {
		/*   pi1 teilt b ==> d2 = d, d1 = e - d   */
	        
		if( e )
		{
	            M = lcomp4( P1, e, pi1, 2, M );
		}
		if( d )
		{
	            M = lcomp4( P2, d, pi2, 2, M );
		}
	    }
	}

	L = lred2( L );
    }

    return( M );
}



/*c
		    qnfielavalipr2( p, D, a )

	"quadratic number field integral element, additive valuation 
	 with respect to integer prime with ramification index 2"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	static single qnfielavalip( p, D, a )  int p, D; nfel a;
	v = qnfielavalip( p, D, a );
	qnfielavalip ist static zu qnfielpifact.
	Dabei muss gelten:
	  - D ist aus Z\{0,1} und quadratfrei.
	  - a ist Element der Hauptordnung von O_D von Q(D^(1/2)), 
	    a ist weder Null noch eine Einheit in O_D.
	  - p ist eine Primzahl (in Z).
	v = max{ w in Z | p^w teilt a } >= 0, sonst.
c*/
/*cS
        qnfielavalipr2 ruft auf: isqnfiel, qnfiquot
Sc*/

static qnfielavalipr2( p, D, a ) 
int  p, D; 
nfel a;
{
    single v;
    int    N;
    nfel   b;

    bind( p, D, a );
    init( N );
    init( b );
       
    b = a;
    v = 0;
       
    while( 1 )
    {
        b = qnfiquot( D, b, p );
        if( !isqnfiel( D, b ) )
        {
            return( v );
        }
        v++;
    }
}
