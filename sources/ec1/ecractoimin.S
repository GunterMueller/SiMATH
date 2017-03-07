/*M
.SH NAME
ecractoimin - elliptic curve over rational numbers, actual curve to global minimal model ( Laska's algorithm )

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecractoimin(E1)  
list E1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
ecractoimin computes a global minimal model E', which is bi-rational isomorphic to E. E' is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1, 0, 1 ), with integral coefficients a1', a2', a3', a4', a6'.
.PP
The transformation is given by :
.IP
 x = u^2 * x' + r ;
 y = u^3 * y' + u^2 * s * x' + t.
.PP
ecractoimin returns a list L:
.IP
L = ( ( a1' a2' a3' a4' a6' ) ( r s t u ) ).
   
.SH SEE ALSO
ecrinit
.PP
Michael Laska,
 An Algorithm for Finding a Minimal Equation for an 
 Elliptic Curve.
 Mathematics of Computation 38 (1982), 257-260.

M*/
	
/*H
	Version 1	05.06.1990	Michael Pfeifer
	Version 2       03.07.1991      ueberfl. Zuw. f2 = 0 und 
					f3 = 0 beseitigt, ausserdem 
					von 'arith2 nach 'arith1.  PS
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 4      	02.04.1992	ECRMINIMOD --> ECIMINIMOD.
					Dokumentation asgepasst. MP 
	Version 5	15.01.1993	Anpassung an neues Konzept.
	                          	ECIMINIMOD --> ECRACTOECIMIN. JG
	Version 6	17.10.1995	ECRACTOECIMIN --> ECRACTOIMIN. JG
   DATE ecractoimin    : 901120.910715.910915.920331.930531.951201
H*/

#include<_ec1.h>

static list trans123(int,int);
static list trans46(int,int,int,int,int);
static list findrst(int,int,int,int,int,int,int);
static single testrst(int,int,int,int,int,int,int,int,int,int,int);

list ecractoimin( E )
list E;
{
    single e, e2, f2, e3, f3, e4, e6, p, min, flag1, flag2, flag3, n;
    list L, L1, L2;
    int s1, s2, s3, s4, s6, a1, a2, a3, a4, a6;
    int r, s, t, u, u1, v, c4, c6, c, h, xu, yu, h2, h3;
    rat a1r, a2r, a3r, a4r, a6r;

    bind(E);    
    
    init( a1, a2, a3, a4, a6 );
    init( L, L1, L2 );
    init( s1, s2, s3, s4, s6, a1, a2, a3, a4, a6 );
    init( r, s, t, u, u1, v, c4, c6, c, h, xu, yu, h2, h3 );
    init( a1r, a2r, a3r, a4r, a6r );
    
    /*   Urspruengliche Gleichung fuer E/Q   */
    /*   wird ganzzahlig gemacht             */

    a1r = ecraca1( E );
    a2r = ecraca2( E );
    a3r = ecraca3( E );
    a4r = ecraca4( E );
    a6r = ecraca6( E );

    s1 = rden( a1r );
    s2 = rden( a2r );
    s3 = rden( a3r );
    s4 = rden( a4r );
    s6 = rden( a6r );

    u1 = ilcm( s1, s2 );
    u1 = ilcm( u1, s3 );
    u1 = ilcm( u1, s4 );
    u1 = ilcm( u1, s6 );

    a1r = rprod( a1r, itor( u1 ) );
    h   = iprod(  u1, u1 );
    a2r = rprod( a2r, itor( h ) );
    h   = iprod(   h, u1 );
    a3r = rprod( a3r, itor( h ) );
    h   = iprod(   h, u1 );
    a4r = rprod( a4r, itor( h ) );
    h   = iprod(   h, u1 );
    h   = iprod(   h, u1 );
    a6r = rprod( a6r, itor( h ) );

    a1 = rnum( a1r );
    a2 = rnum( a2r );
    a3 = rnum( a3r );
    a4 = rnum( a4r );
    a6 = rnum( a6r );

    /* Berechnung von c4 und c6 (Schritt (1)) 		*/
    
    s1 = iprod( a2,  4 );
    s2 = iprod( a1, a1 );
    s2 = isum ( s2, s1 );
    
    s1 = iprod( a4,  2 );
    s4 = iprod( a1, a3 );
    s4 = isum ( s4, s1 );
    
    s1 = iprod( a6,  4 );
    s6 = iprod( a3, a3 );
    s6 = isum ( s6, s1 );
    
    s1 = iprod( s4, 24 );
    c4 = iprod( s2, s2 );
    c4 = idif ( c4, s1 );
    
    s1 = iprod( s6, 216 );
    c6 = iprod( s2, 36 );
    c6 = iprod( s4, c6 );
    c6 = idif ( c6, s1 );
    s1 = iprod( s2, s2 );
    s1 = iprod( s2, s1 );
    c6 = idif ( c6, s1 );
    
	/*   Bestimmung des maximalen u und Zerlegung gemaess	*/
	/*   u = 2^e2*3^e3*v mit (6,v) = 1 (Schritt(2)).	*/

	u  = 1;
	c  = iabs( igcd( c4, c6 ) );
	L1 = ifact( c );
	L2 = ifel( L1 );

	while ( L2 != _0 )
	{
		p  = lfirst( L2 );
		e  = lsecond( L2 );
		L2 = lred( L2 );
		L2 = lred( L2 );
		if ( e >= 4 )
		{
			if ( ( c4 != 0 ) && ( c6 != 0 ) )
			{
			        e4 = iaval( p, c4 );
			        e6 = iaval( p, c6 );
			        min = smin( e4/4, e6/6 );
			        h  = iexp( p, min );
			        u  = iprod( u, h );
			}
			else
			{
			        if ( c4 == 0 )
			        {
				        e6 = iaval( p, c6 );
				        min = e6/6;
				        h  = iexp( p, min );
				        u  = iprod( u, h );
			        }
			        if ( c6 == 0 )
			        {
				        e4 = iaval( p, c4 );
				        min = e4/4;
				        h  = iexp( p, min );
				        u  = iprod( u, h );
			        }
			}
		}
	}

	e2 = iaval( 2, u );
	e3 = iaval( 3, u );
	v  = iquot( u, iexp( 2, e2 ) );
	v  = iquot( v, iexp( 3, e3 ) );

	/*   Berechnung von f2. f2 ist der maximale Exponent	*/
	/*   von 2, so dass Schritt (6) im Algorithmus von      */
	/*   Laska erfolgreich durchlaufen wird.		*/
	/*   Die for-Schleife realisiert Schritt (3').          */

	if ( e2 == 0 ) flag2 = 1;
	else flag2 = 0;
	for( f2 = e2; ( f2 >= 0 ) && ( flag2 == 0 ); f2-- )
	{
		u  = iexp( 2, f2 );
		xu = iquot( c4, iexp( u, 4 ) );
		yu = iquot( c6, iexp( u, 6 ) );
		
		L  = trans123( xu, yu );

		if ( llength( L ) != 1 )
		{ 
			s1 = lfirst( L );
			s2 = lsecond( L );
			s3 = lthird( L );

			L  = trans46( s1, s2, s3, xu, yu );

			if ( llength( L ) != 1 )
			{
				s4 = lfirst( L );
				s6 = lsecond( L );

				L  = findrst( u, a1, a2, a3, s1, s2, s3 );

				if ( llength( L ) != 1 )
				{
					r  = lfirst( L );
					s  = lsecond( L );
					t  = lthird( L );

			n  = testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );

					if ( n == 1 )
					{
					        flag2 = 1;
						f2++;
					}
				}
			}
		}
	}

	/*   Berechnung von f3. f3 ist der maximale Exponent	*/
	/*   von 3,  so dass Schritt (6) im Algorithmus von     */
        /*   Laska erfolgreich durchlaufen wird.		*/
	/*   Die for-Schleife realisiert Schritt (3'').         */

	if ( e3 == 0 ) flag3 = 1;
	else flag3 = 0;
	for( f3 = e3; ( f3 >= 0 ) && ( flag3 == 0 ); f3-- )
	{
		u  = iexp( 3, f3 );
		xu = iquot( c4, iexp( u, 4 ) );
		yu = iquot( c6, iexp( u, 6 ) );
		
		L  = trans123( xu, yu );

		if ( llength( L ) != 1 )
		{ 
			s1 = lfirst( L );
			s2 = lsecond( L );
			s3 = lthird( L );

			L  = trans46( s1, s2, s3, xu, yu );

			if ( llength( L ) != 1 )
			{
				s4 = lfirst( L );
				s6 = lsecond( L );

				L  = findrst( u, a1, a2, a3, s1, s2, s3 );

				if ( llength( L ) != 1 )
				{
					r  = lfirst( L );
					s  = lsecond( L );
					t  = lthird( L );

			n = testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );

					if ( n == 1 )
					{
						flag3 = 1;
						f3++;
					}
				}
			}
		}
	}

	/*   Realisation von Schritt (3''') bei Laska.		*/

	h2 = iexp( 2, f2 );
	h3 = iexp( 3, f3 );
	u  = iprod( h2, h3 );
	u  = iprod( u, v );
	xu = iquot( c4, iexp( u, 4 ) );
	yu = iquot( c6, iexp( u, 6 ) );
	
	flag1 = 0; 

	L  = trans123( xu, yu );

	if ( llength( L ) != 1 )
	{
		s1 = lfirst( L );
		s2 = lsecond( L );
		s3 = lthird( L );

		L  = trans46( s1, s2, s3, xu, yu );
	
		if( llength( L ) != 1 )
		{
			s4 = lfirst( L );
			s6 = lsecond( L );

			L  = findrst( u, a1, a2, a3, s1, s2, s3 );
			
			if ( llength( L ) != 1 )
			{
				r  = lfirst( L );
				s  = lsecond( L );
				t  = lthird( L );
			
			n  = testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );

				if ( n == 1 )
				{ 
					flag1 = 1;
				}
			}
		}
	}


    if ( ( flag1 == 0 ) || ( flag2 == 0 ) || ( flag3 == 0 ) )
    { 
        L  = list1( -1 );
    }
    else
    {
        L1 = list5( s1, s2, s3, s4, s6 );

        L2 = list4( itor( r ), itor( s ), itor( t ), itor( u ) );
	if( u1 != 1 )
	{
	    L  = list4( 0, 0, 0, list2( 1, u1 ) );
	    L2 = ecrbtconc( L, L2 );
	}
        L  = list2( L1, L2 );
    }

    return( L );

}

/**************   Ende von  e c r a c t o e c i m i n   ************/

/*c
			trans123( xu, yu )

	"transformation of s1, s2 and s3"
	list trans123( xu, yu );
		int xu, yu;
	L = trans123( xu, yu );
	trans123 berechnet die Groessen s1, s2 und s3 aus xu und yu 
	gemaess den bei Laska angegebenen Kongruenzen.
	trans123 liefert eine 3-elementige Liste L = ( s1  s2  s3 ),
	falls die Kongruenzen erfuellbar sind mit s1, s3 = 0, 1 und
	s2 = -1, 0, 1. trans123 liefert eine Liste L = ( -1 ), falls
	falls die Kongruenzen nicht erfuellbar sind.
	trans123 realisiert Schritt (4) im Algorithmus von Laska.
	Literatur: s.o.
	trans123 ist ein static-modul zu ecractoimin.
c*/
/*H
	Version 1	18.06.1990	Michael Pfeifer
H*/


static list trans123( xu, yu )
int xu, yu;
{
    single flag;
    list L;
    int s1, s2, s3, hx, hy;
	
    bind( xu, yu );
    init( L );
    init( s1, s2, s3, hx, hy );
    
    flag = 0;
    s1 = mshom( 8, xu );
    if ( ( s1 == 0 ) || ( s1 == 1 ) )
    {
        s2 = ineg( s1 );
        s2 = idif( s2, yu );
        s2 = mshom( 3, s2 );
        if ( s2 == 2 )
        {
            s2 = -1;
        }				
        if ( s1 == 0 )
        {
            hy = mshom( 8, yu );
            if ( hy == 0 ) 
            {
                hy = iquot( yu, 8 );
                hy = mshom( 4, hy );
                if ( hy == 0 )
                {
                    s3 = 0;
                    flag = 1;
                }
                if ( hy == 1 )
                {
                    s3 = 1;
                    flag = 1;
                }
            }
        }
        if ( s1 == 1 )
        {
            s3 = idif( xu, 1);
            hx = mshom( 8, s3 );
            if ( hx == 0 )
            {
                s3 = iquot( s3, 8 );
                s3 = isum( s2, s3 );
                s3 = mshom( 2, s3 );
                flag = 1;
            }
        }
    }

    if ( flag == 1 )
    {
        L  = list3( s1, s2, s3 );
    }
    else 
    {
        L  = list1( -1 );
    }
    
    return( L );
}

/****************   Ende von  t r a n s 1 2 3   ********************/

/*c
			trans46( s1, s2, s3, xu, yu )

	"transformation of s4 and s6"
	list trans46( s1, s2, s3, xu, yu );
		int s1, s2, s3, xu, yu;
	L = trans46( s1, s2, s3, xu, yu );
	trans46 berechnet die Groessen s4 und s6 aus s1, s2, s3, xu, yu 
        aus den Formeln:
		xu = (s1^2 + 4s2)^2 - 24(s1s3 + 2s4),
		yu = -(s1^2 + 4s2)^3 + 36(s1^2 + 4s2)(s1s3 + 2s4) -
		     216(s3^2 + 4a6).	
	trans46 liefert eine 2-elementige Liste L = ( s4  s6 ),
	falls s4 und s6 ganz sind und die Liste L = ( -1 ), falls
	s4 oder s6 nicht ganz ist.
	trans46 realisiert Schritt (5) im Algorithmus von Laska.
	Literatur: s.o.
	trans46 ist ein static-modul zu ecractoimin.
c*/
/*H
	Version 1	18.06.1990	Michael Pfeifer
H*/

static list trans46( s1, s2, s3, xu, yu )

int s1, s2, s3, xu, yu;

{
    list L;
    int s4, s6, h4, h6;
    rat s1r, s2r, s3r, xur, yur;
    rat s4r, s6r, h1r, h2r, h3r;
    	
    bind( s1, s2, s3, xu, yu );
    
    init( L );
    init( s4, s6, h4, h6 );
    init( s1r, s2r, s3r, xur, yur );
    init( s4r, s6r, h1r, h2r, h3r );
    
    s1r = itor( s1 );
    s2r = itor( s2 );
    s3r = itor( s3 );
    xur = itor( xu );
    yur = itor( yu );
    
    s4r = rprod( s1r, s1r );
    h1r =  itor( 4 );
    h1r = rprod( h1r, s2r );
    s4r =  rsum( s4r, h1r );
    s4r = rprod( s4r, s4r );
    s4r =  rdif( s4r, xur );
    h1r =  itor( 48 );
    s4r = rquot( s4r, h1r);
    h1r = rprod( s1r, s3r );
    h2r =  itor( 2 );
    h1r = rquot( h1r, h2r );
    s4r =  rdif( s4r, h1r );
    
    s6r = rprod( s1r, s1r ); 
    h1r =  itor( 4 );
    h1r = rprod( s2r, h1r );
    s6r =  rsum( s6r, h1r );	
    h2r = rprod( s6r, s6r );
    s6r = rprod( s6r, h2r );
    s6r =  rneg( s6r );
    h1r = rprod( s1r, s1r );
    h2r =  itor( 4 );
    h2r = rprod( h2r, s2r );
    h1r =  rsum( h1r, h2r );
    h2r = rprod( s1r, s3r );
    h3r =  itor( 2 );
    h3r = rprod( h3r, s4r );
    h2r =  rsum( h2r, h3r );
    h1r = rprod( h1r, h2r );
    h2r =  itor( 36 );
    h1r = rprod( h1r, h2r );
    s6r =  rsum( s6r, h1r );
    s6r =  rdif( s6r, yur );
    h1r =  itor( 864 );
    s6r = rquot( s6r, h1r );		
    h1r = rprod( s3r, s3r );
    h2r =  itor( 4 );
    h1r = rquot( h1r, h2r );
    s6r =  rdif( s6r, h1r );
    
    h4 = 0;
    h6 = 0;
    if ( s4r != 0 )
    {
        h4 = lsecond( s4r );
    }			
    if ( s6r != 0 )
    {
        h6 = lsecond( s6r );
    }			
    if ( ( !s4r  ||  ( h4 == 1 ) ) && ( !s6r  ||  ( h6 == 1 ) ) )
    {
        if( s4r ) 
	{
	    s4 = lfirst( s4r );
	}
        else
	{
	    s4 = 0;
	}

        if( s6r ) 
	{
	    s6 = lfirst( s6r );
	}
        else 
	{
	    s6 = 0;
	}

        L  = list2( s4, s6 );
    }
    else
    {
        L  = list1( -1 );
    }

    return ( L );
}

/*****************   Ende von  t r a n s 4 6   *********************/


/*c
			findrst( u, a1, a2, a3, s1, s2, s3 )

        "find r, s, t"
	list findrst( u, a1, a2, a3, s1, s2, s3 );
		int u, a1, a2, a3, s1, s2, s3;
	L = findrst( u, a1, a2, a3, s1, s2, s3 );
	findrst berechnet die Parameter r, s und t der birationalen 
	Transformation, die a1 in s1, a2 in s2 und a3 in s3 ueberfuehrt
	gemaess den Formeln
		us1 = a1 + 2s,
		u^2s2 = a2 - sa1 + 3r - s^2,
		u^3a3 = a3 + ra1 +2t.
	findrst liefert eine 3-elementige Liste L = ( r  s  t ), falls
	r, s und t ganz sind und die Liste L = ( -1 ), falls r, s oder t
	nicht ganz ist.
	findrst realisiert den ersten Teil von Schritt (6) im 
        Algorithmus von Laska.
	Literatur: s.o.
	findrst ist ein static modul zu ecractoimin.
c*/
/*H
	Version1 	19.06.1990	Michael Pfeifer
H*/

static list findrst( u, a1, a2, a3, s1, s2, s3 )
int u, a1, a2, a3, s1, s2, s3;
{
    single rh, sh, th, flag;
    list L;
    int r, s, t, h;
    
    bind( u, a1, a2, a3, s1, s2, s3 );
    
    init( L );
    init( r, s, t, h );
    
    flag = 0;
    
    s  = iprod( u, s1 );
    s  =  idif( s, a1 );
    sh = mshom( 2,  s );
    if ( sh == 0 )
    {
        s  = iquot( s,  2 );
        r  = iprod( u,  u );
        r  = iprod( r, s2 );
        r  =  idif( r, a2 );
        h  = iprod( s, a1 );
        r  =  isum( r,  h );
        h  = iprod( s,  s );
        r  =  isum( r,  h );
        rh = mshom( 3,  r );
        if ( rh == 0 )
        {
            r  = iquot( r,  3 ); 
            t  = iprod( u,  u );
            t  = iprod( t,  u );
            t  = iprod( t, s3 );
            t  =  idif( t, a3 );
            h  = iprod( r, a1 );
            t  =  idif( t,  h );
            th = mshom( 2,  t );	
            if ( th == 0 )
            {
                t  = iquot( t,  2 );

                flag = 1; 
                
            }
        }
    }
    if ( flag == 1 )
    {
        L  = list3( r, s, t );
    }
    else 
    {
        L  = list1( -1 );
    }
    
    return( L );
}	

/*****************   Ende von  f i n d r s t   *********************/

/*c
			testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 )

	"test of r, s, t"
	single testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );
		int r, s, t, u, a1, a2, a3, a4, a6, s4, s6;
	n = testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );
	testrst prueft nach, ob die durch die Transformation von a1, a2 und a3
	nach s1, s2 und s3 berechneten Parameter r, s und t auch a4 und a6
	korrekt nach s4 und s6 transformieren, d.h. ob die folgenden
	Gleichungen erfuellt sind:
	        (1) u^4s4 = a4 - sa3 + 2ra2 - (t + rs)a1 + 3r^2 - 2st,
	        (2) u^6s6 = a6 + ra4 + r^2a2 + r^3 - ta3 - t^2 - rta1.
	testrst liefert 1, falls (1) und (2) erfuellt sind und -1 sonst.
	testrst realisiert den zweiten Teil von Schritt (6) im 
	Algorithmus von laska.
	Literatur: s.o.
	testrst ist ein static-Modul zu ecractoimin.
c*/
/*H
	Version 1	19.06.1990	Michael Pfeifer
H*/

static single testrst( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 )
int r, s, t, u, a1, a2, a3, a4, a6, s4, s6;
{
    int d1, d2, h1;
				
    bind( r, s, t, u, a1, a2, a3, a4, a6, s4, s6 );

    init( d1, d2, h1 );
    
    d1 = a4;
    h1 = iprod(  s, a3 );
    d1 =  idif( d1, h1 );
    h1 = iprod(  2,  r );
    h1 = iprod( h1, a2 );
    d1 =  isum( d1, h1 );
    h1 = iprod(  r,  s );
    h1 =  isum( h1,  t );
    h1 = iprod( h1, a1 );
    d1 =  idif( d1, h1 );
    h1 = iprod(  3,  r );
    h1 = iprod( h1,  r );
    d1 =  isum( d1, h1 );
    h1 = iprod(  2,  s );
    h1 = iprod( h1,  t );
    d1 =  idif( d1, h1 );
    h1 = iprod(  u,  u );
    h1 = iprod( h1, h1 );
    h1 = iprod( h1, s4 );
    d1 =  idif( d1, h1 );

    d2 = a6;
    h1 = iprod(  r, a4 );
    d2 =  isum( d2, h1 );
    h1 = iprod(  r,  r );
    h1 = iprod( h1, a2 );
    d2 =  isum( d2, h1 );
    h1 = iprod(  r,  r );
    h1 = iprod( h1,  r );
    d2 =  isum( d2, h1 );
    h1 = iprod(  t, a3 );
    d2 =  idif( d2, h1 );
    h1 = iprod(  t,  t );
    d2 =  idif( d2, h1 );
    h1 = iprod(  r,  t );
    h1 = iprod( h1, a1 );
    d2 =  idif( d2, h1 );
    h1 = iprod(  u,  u );
    h1 = iprod( h1,  u );
    h1 = iprod( h1, h1 );
    h1 = iprod( h1, s6 );
    d2 =  idif( d2, h1 );

    if ( ( d1 == 0 ) && ( d2 == 0 ) )
    {
        return( 1 );
    }
    else
    {
        return( -1 );
    }
}

/*****************   Ende von  t e s t r s t   *********************/
