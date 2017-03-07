/*M
.SH NAME
eciminlhnaav - elliptic curve with integer coefficients, minimal model, local heights at all non archimedean absolute values

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecminlhnaav(E1, P1)  
list E1, P1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B P1
= ( x y z )    int x, y, z;
 defines  the point P on the minimal model ( of
 restricted typ; i.e. a1', a3' = 0 or 1, 
 a2' = -1, 0, 1.) of the elliptic curve E/Q.
.PP
eciminlhnaav computes the local Neron-Tate height of P at all non archimedean absolute values of Q.
  
.SH SEE ALSO
ecrinit

Literatur: J.H. Silverman: Math. of Comp., 51, 1988, p.351-358.

M*/

/*H
	Version 1       19.02.1992      Joachim Stein
	Version 2	05.10.1992	lambda := lambda + 1/12 log(D).
					verbessertes Abfragekonzept. J.St.
	Version 3	05.01.1993	Anpassung an neues Konzept.
					Summand log(D)/12 auskommentiert.
					ECRLHNAAV -> ECIMINLHNAAV  JG
   DATE eciminlhnaav  : 920331.921130.930531
H*/

#include <_ec1.h>

floating eciminlhnaav( E, P )
list E, P;
{
    single   a, b, c, n;
    int      a1, a2, a3, a4, b2, b4, b6, b8, c4, z, p;
    rat      x, y, aa, bb, cc, h1, h2;
    list     FD, Fz;
    floating erg, hfl;

    bind( E, P );
	
    if( ispecrpai( P ) )
    {
	/*   P = O = ( 0 : 1 : 0 )   */
	return( 0 );
    }

    init( a1, a2, a3, a4, b2, b4, b6, b8, c4, z, p );
    init( x, y, aa, bb, cc, h1, h2 );
    init( FD, Fz );
    init( erg, hfl );

    a1 = ecimina1( E );
    a2 = ecimina2( E );
    a3 = ecimina3( E );
    a4 = ecimina4( E );

    b2 = eciminb2( E );
    b4 = eciminb4( E );
    b6 = eciminb6( E );
    b8 = eciminb8( E );

    c4 = eciminc4( E );

    FD = eciminfdisc( E );

    z = lthird( P );

    if( z == 1 )
    {
	Fz = _0;
    }
    else
    {
        Fz = ifact(  z );
        Fz = linv ( Fz );
        Fz = ifel ( Fz );
    }

    p = iprod ( z, z );

    if( lfirst( P ) )
    {
        x = itor ( lfirst( P ) );
        x = rquot( x, itor( p ) );
    }
    else
    {
	x = 0;
    }
    
    if( lsecond( P ) )
    {
        p = iprod( p,  z );
        y = itor ( lsecond( P ) );
        y = rquot( y, itor( p ) );
    }
    else
    {
	y = 0;
    }
    
    /*   Berechnung von aa = 3*x^2 + 2*a2*x + a4 - a1*y             */
    aa =  rprod(  x, itor(  3 ) );
    aa =  rsum ( aa, itor( a2 ) );
    aa =  rsum ( aa, itor( a2 ) );
    aa =  rprod(  x, aa );
    aa =  rsum ( aa, itor( a4 ) );
    h1 =  rprod(  y, itor( a1 ) );
    aa =  rdif ( aa, h1 );
    
                          
    /*   Berechnung von bb = 2*y + a1*x + a3                        */
    bb = rprod(  x, itor( a1 ) );
    bb = rsum ( bb, itor( a3 ) );
    bb = rsum ( bb, y );
    bb = rsum ( bb, y );

    /*   Berechnung von                                             */
    /*      cc = 3*x^4 + b2*x^3 + 3*b4*x^2 + 3*b6*x + b8            */
    cc = rprod(  x, itor(  3 ) );
    cc = rsum ( cc, itor( b2 ) );
    cc = rprod( cc, x );
     z = isprod( b4, 3 );
    cc = rsum ( cc, itor( z ) );
    cc = rprod( cc, x );
     z = isprod( b6,  3 );
    cc = rsum ( cc, itor( z ) );
    cc = rprod( cc, x );
    cc = rsum ( cc, itor( b8 ) );

    erg = 0;

    while( ( FD != _0 ) || ( Fz != _0 ) )
    {
        /*   Da h_p( P ) = 0 fuer Primzahlen p, die D * z   */
        /*   nicht teilen (D = Diskriminante des miniamlen  */
        /*   Modells), wird nur ueber solche Primzahlen p   */
	/*   summiert, die D * z teilen.                    */
        if( FD == _0 ) 
	{
            p  = lfirst( Fz );
            n  = 0;
	    Fz = lred2( Fz );
        }
	else if( Fz == _0 ) 
	{
            p  = lfirst ( FD );
            n  = lsecond( FD );
	    FD = lred2  ( FD );
        }
	else
	{
            p  = lfirst ( FD );
            z  = lfirst ( Fz );
	    n  = icomp( z, p );
	    if( n > 0 )
	    {
		/*   z > p   */
                n  = lsecond( FD );
	        FD = lred2  ( FD );
	    }
	    else if( n )
	    {
		/*   z < p   */
                n  = 0;
		p  = z;
	        Fz = lred2  ( Fz );
	    }
	    else
	    {
		/*   z = p   */
                n  = lsecond( FD );
	        FD = lred2  ( FD );
	        Fz = lred2  ( Fz );
	    }
        }

        if( aa )  
	{
	    a = ravalint( p, aa );
	}
        else
	{
	    /*   aa = 0 ==> a = Unendlich  */
	    a = ERROR;
	}
        
	if( bb )  
	{
	    b = ravalint( p, bb );
	}
        else
	{
	    /*   bb = 0 ==> b = Unendlich  */
	    b = ERROR;
	}

        if( ( ( a != ERROR ) && ( a <= 0 ) ) 
	||  ( ( b != ERROR ) && ( b <= 0 ) ) )
        {
	    /*   P hat gute Reduktion modulo p    */
            h1 = 0;
            if( x )          /*  x != 0  */
            {
                a  = ravalint( p, x );
                if( a < 0 )  
                {
                    h1 = itor ( a );   
                    h1 = rquot( h1, itor( 2 ) );
                }
	    }
        }      
        else
        {
	    if( c4 )
	    {
		a = iavalint( p, c4 );
	    }
	    else
	    {
	        /*   c4 = 0 ==> a = Unendlich  */
	        a = ERROR;
	    }

            if( a == 0 )
            { 
		/*   P hat multiplikative Reduktion mod p     */
		/*   h1 = h2 * ( h2 - n ) / ( 2 * n )         */
		/*   mit h2 = min{ b, n/2 }             */
                if( b == ERROR )
                { 
		    /*   b = Unendlich > n/2 ==> h2 = n/2   */
                    h2 = itor ( n );   
                    h2 = rquot( h2, itor( 2 ) );
                }
                else
                {
		    /*   h2 = min{ b, n/2 }    */
		    a = 2 * b;
		    if( a > n )
		    {
			/* b > n/2 ==> h2 = n/2   */
                        h2 = itor ( n );   
                        h2 = rquot( h2, itor( 2 ) );
		    }
		    else
		    {
			/* b < n/2 ==> h2 = b     */
                        h2  = itor ( b );   
		    }
                }
		
		a  = 2 * n;
		h1 = rdif ( itor( n ), h2 );
		h1 = rprod( h1, h2 );
		h1 = rquot( h1, itor( a ) );
            }
            else 
            {
		/*    P hat additive Reduktion modulo p    */
	        if( cc )  
	        {
	            c = ravalint( p, cc );
	        }
                else
	        {
	            /*   cc = 0 ==> c = Unendlich  */
	            c = ERROR;
	        }

		/*   Test:  if( c >= 3 b )    */
 	        if( ( c == ERROR ) || ( b == ERROR ) )
		{
 	            if( c == ERROR ) 
                    {
		        /*   c = Unendlich ==> c >= 3 * b   */
                        h1 = itor (  b );
                        h1 = rquot( h1, itor( 3 ) );
 	            }
                    else 
                    {
		        /*   b = Unendlich ==> c < 3 * b   */
                        h1 = itor (  c );
                        h1 = rquot( h1, itor( 8 ) );
 	            }
 	        }
                else 
		{
	            /*   b, c != Unendlich   */
	            if( c >= 3 * b ) 
                    {
                        h1 = itor (  b );
                        h1 = rquot( h1, itor( 3 ) );
 	            }
                    else 
                    {
                        h1 = itor (  c );
                        h1 = rquot( h1, itor( 8 ) );
 	            }  
                }  
            }   /*   ENDE: P hat additive Reduktion modulo p    */
        }   /*  ENDE: P hat multiplikative Reduktion modulo p   */
        
	/*   Um das Programm zu beschleunigen, werden die       */
	/*   Terme, die nur von der Diskriminante abhaengig     */
	/*   sind, weggelassen (siehe 'eciminlhaav').           */

	/*   if( n )                                            */
	/*   {                                                  */
	/*       h2 = itor ( n );                               */
        /*       h2 = rquot( h2, itor( 12 ) );                  */
	/*       h1 = rdif ( h1, h2 );                          */
	/*   }                                                  */
	
	hfl = itofl ( p );
        hfl = fllog ( hfl );
	hfl = flprod( hfl, rtofl( h1 ) );
        hfl = flneg ( hfl );


	erg = flsum( erg, hfl );
    }   /*  ENDE: while( ( FD != _0 ) || ( Fz != _0 ) )         */
    
    return( erg );
}
