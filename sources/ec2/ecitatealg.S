/*M
.SH NAME
ecitatealg - elliptic curve with integer coefficients Tate's algorithm 

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecitatealg( a1, a2, a3, a4, a6, p, n )
int a1, a2, a3, a4, a6, p;  
single n;

.SH DESCRIPTION
.TP 4
.B a1, a2, a3, a4, a6
are integer numbers, and the coefficients of an elliptic curve E/Q.
.TP 4
.B p
is a prime number.
.TP 4
.B n
is the largest integer number, for which p^n divides the discriminant of the elliptic curve E/Q, n < BASIS.
.PP 
ecitatealg computes with help of  Tate's algorithm
.IP
 the reduction type of the curve E modulo p,
 the exponent of the conductor of E at p,
 the c_p value of E modulo p.
.PP
ecitatealg returns 
.PP
 - the list (-1) in case of an error occurs,
 - if E is not minimal at p, a list of five integer 
   numbers, being the coefficients of an curve, say E', 
   which is birationaly isomorphic to E and minimal at p.
 - a list of three elements (exp rtyp c_p) else, where
.PP
 exp  is the exponent of the conductor,
 rtyp is the reduction typ according the table below,
 c_p  = #E(Q)/E0(Q), where
      E0(Q) = {P in E(Q) | P = (0 : 1 : 0) mod p}.
.IP
 | rtyp   | Kodaira  | Neron  |  c_p-Wert   |
 |--------|----------|--------|-------------|
 | -n < 0 |    In    |   Bn   |  1, 2 or n  |
 |--------|----------|--------|-------------|
 |    1   |    II    |   C1   |      1      |
 |--------|----------|--------|-------------|
 |    2   |   III    |   C2   |      2      |
 |--------|----------|--------|-------------|
 |    3   |    IV    |   C3   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    5   |    I*0   |   C4   |   1, 2, 4   |
 |--------|----------|--------|-------------|
 | 10 + v | I*v, v>0 |  C5,v  |    2 or 4   |
 |--------|----------|--------|-------------|
 |    6   |    IV*   |   C6   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    7   |   III*   |   C7   |      2      |
 |--------|----------|--------|-------------|
 |    8   |    II*   |   C8   |      1      |
 -------------------------------------------- 
 
.SH SEE ALSO
 ecimintate
 Literature: J.T.Tate,
             Algorithm for finding the type of a singular
             fiber in an elliptic pencil.
             Modular functions in one variable IV. Antwerp
             1972.
             Lect. Notes Math. 476, 33-52 ( 1975 ).
             H.Cohen,
             A Course in Computaional Number Theory
             Graduate Texts in Mathematics 138, Springer
             Verlag, p. 400-403.       
 
M*/
   
/*H
	Version 1       05.04.1990      Michael Pfeifer
	Version 2	04.12.1990	fuer p auch int-Werte zugelassen.  MP
	Version 3       20.08.1991      '_arith2.h' statt '_pol2.h' eingebunden
					(nur aus Gruenden der Einheitl.).  MP
	Version 4       28.08.1991      von 'arith2 nach 'ec2.  PS
	Version 5       12.11.1992      zusaetzlich Berechnung des c_p-Werts,
					'nofdrts' gestrichen.  JG
	Version 6	20.11.1992	TATEALG -> ECITATEALG.  PS
	Version 7       09.06.1992      kurzfristige Anpassung an neues 
					Konzept.  MP
	Version 8	08.11.1993	ueberfluessigen static-Modul rtoi
					geloescht.  PS
   DATE ecitatealg    : 901120.910715.910915.9203__.921130.930531.931130
H*/

#include<_ec2.h>

static int trans1(int,single);
static int trans2(int,int,single,single);
static int trans3(int,int,single,single);
static int trans4(int,int,int,int,single,single,single);
static int trans6(int,int,int,int,int,single,single,single);

list ecitatealg( a1, a2, a3, a4, a6, p, n )
single   n;
int   a1, a2, a3, a4, a6, p;
{
    single  ok, c_p, j, v, exp, rtyp, tr;
    int                r,   s,   t,
           a11, a21, a31, a41, a61,
	   a12, a22, a32, a42, a62,
		a23,      a43, a63,
	   a14, a24, a34, a44, a64,
		     a36,      a66,
	   a17, a27, a37, a47, a67,
		a28, a38, a48, a68,
		a29,      a49, a69,
	   a10, a20, a30, a40, a60,
			  b21, b61, b81,
		 b2,       b4,  b6,  b8,
			   c4,  c6,
		 p2,  p3,  p4,  p5,  p6,
	   hi1, hi2, hi3, hi4, hi5, hi6,
	   lh1, lh2,        h,  h1,  h2;
    rat    a1r, a2r, a3r, a4r, a6r,  hr;
    list   L,  Lh;
    pol    P, Q;

    bind(   a1,  a2,  a3,  a4,  a6,   p );

    init(         r,   s,   t           );
    init(  a11, a21, a31, a41, a61      );
    init(  a12, a22, a32, a42, a62      );
    init(       a23,      a43, a63      );
    init(  a14, a24, a34, a44, a64      );
    init(            a36,      a66      );
    init(  a17, a27, a37, a47, a67      );
    init(       a28, a38, a48, a68      );
    init(       a29,      a49, a69      );
    init(  a10, a20, a30, a40, a60      );
    init(                 b21, b61, b81 );
    init(        b2,       b4,  b6,  b8 );
    init(                  c4,  c6      );
    init(        p2,  p3,  p4,  p5,  p6 );
    init(  hi1, hi2, hi3, hi4, hi5, hi6 );
    init(  lh1, lh2,        h,  h1,  h2 );
    init(  a1r, a2r, a3r, a4r, a6r,  hr );
    init(    L,  Lh                     );

    ok  = 1;
    v   = 0;
 
    /*   Berechnung der Tateschen Groessen b2, b4, b6, b8, c4, c6       */

    Lh  = ecitavalb(a1, a2, a3, a4, a6);
    b2  = lfirst(Lh);
    b4  = lsecond(Lh);
    b6  = lthird(Lh);
    b8  = lfourth(Lh);

    Lh  = ecitavalc(a1, a2, a3, a4, a6);
    c4  = lfirst(Lh);
    c6  = lsecond(Lh);

    p2  = iprod(  p,  p );
    p3  = iprod(  p, p2 );
    p4  = iprod( p2, p2 );
    p5  = iprod(  p, p4 );
    p6  = iprod(  p, p5 );

    /*   Transformiere E (falls notwendig) so, dass p                   */
    /*   a3', a4' und a6' teilt.                                        */
    
    h = mihom( p, c4 );
    if( ( n == 1 )  &&  ( h != 0 ) )
    {
        /*   MULTIPLIKATIVE REDUKTION: Um den c_p-Wert zu berechnen,    */
        /*   muss die Gleichung transformiert werden (s.o.).            */
        /*   Im Fall n = 1 muss diese Transformation allerdings nicht   */
        /*   durchgefuehrt werden, da in allen Faellen, die auftreten   */
        /*   koennen, c_p = 1 ist.                                      */
        /*                                                              */
        /*   REDUKTIONSTYP: Bn BZW. In, n = 1 = v_p( D ) > 0.           */
        /*                                                              */
        /*   c_p = 1                                                    */
   
	exp  = 1;
	rtyp = -1;
        c_p  = 1;
    
        L    = list3( exp, rtyp, c_p );

	return( L );
    }

    h = mihom( p, a3 );
    if ( h == 0 )
    {
        h = mihom( p, a4 );
	if ( h == 0 )
	{
	    h = mihom( p, a6 );
	    if ( h == 0 )
	    {
		/*   p teilt bereits a3, a4 und a6.                     */
		/*   Keine Transformation notwendig.                    */

		a11 = a1;
		a21 = a2;
		a31 = a3;
		a41 = a4;
		a61 = a6;

		b21 = b2;
		b61 = b6;
		b81 = b8;

		ok  = 0;
	    }
	}
    }
 
    if ( ok == 1 )
    {
	/*   p teilt nicht a3, a4 und a6. Transformiere E.              */

	tr = 1;

	for ( r = 0; icomp( r, p) != 1 && tr; r = isum( r, 1 ) )
	    for ( s = 0; icomp( s, p ) != 1 && tr; s = isum( s, 1 ) )
		for( t = 0; icomp( t, p ) != 1 && tr; t = isum( t, 1 ) )
		{
		    a31 = trans3( a1,     a3,         r,    t );
		    a41 = trans4( a1, a2, a3, a4,     r, s, t );
		    a61 = trans6( a1, a2, a3, a4, a6, r, s, t );

		    h = mihom( p, a31 );
		    if ( h == 0 )
		    {
			h = mihom( p, a41 );
			if ( h == 0 )
			{
			    h = mihom( p, a61 );
			    if ( h == 0 )
			    {
				/*   Transformation fuer a3, a4         */
				/*   und a6 beendet.                    */
				/*   Transformiere noch a1, a2, b6      */
				/*   und b8 entsprechend.               */

				tr  = 0;

				a11 = trans1( a1,        s );
				a21 = trans2( a1, a2, r, s );

				h1  = iprod(  12,   r );
				b21 =  isum(  b2,  h1 );

				h1  = iprod(   4,   r );
				b61 =  isum(  b2,  h1 );
				b61 = iprod( b61,   r );
				b61 =  isum( b61,  b4 );
				b61 =  isum( b61,  b4 );
				b61 = iprod( b61,   r );
				b61 =  isum( b61,  b6 );

				h1  = iprod(   3,   r );
				b81 =  isum(  h1,  b2 );
				b81 = iprod( b81,   r );
				lh1 = iprod(  b4,   3 );
				b81 =  isum( b81, lh1 );
				b81 = iprod( b81,   r );
				lh1 = iprod(  b6,   3 );
				b81 =  isum( b81, lh1 );
				b81 = iprod( b81,   r );
				b81 =  isum( b81,  b8 );
			    }
			}
		    }

		    /*   Ende der ersten for-Schleifen.                 */

		}

	if ( tr != 0 )
	{
	    /*   Fehler in der Rechnung: keine Transformation gefunden. */

	    return( list1( -1 ) );
	}
    }
    
    /*   Es gilt an dieser Stelle: p teilt a3, a4 und a6.               */

    h = mihom( p, b21 );
    if ( h != 0 )
    {
        /*   Multiplikative Reduktion.                                  */
        /*                                                              */
        /*   REDUKTIONSTYP: Bn BZW. In, n = v_p( D ) > 1.               */
        /*                                                              */
        /*   P(X) =  X^2 + a11 X - a21 in F_p[ X ] hat 2 verschiedene   */
        /*   Nullstellen (im algebraischen Abschluss von F_p).          */
        /*                                                              */
        /*          /  n, falls die Nullstellen von P(X) in F_p liegen  */
        /*          |  2, falls die Nullstellen von P(X) nicht          */
        /*   c_p = <            in F_p liegen und n gerade ist          */
        /*          |  1, falls die Nullstellen von P(X) nicht          */
        /*          \           in F_p liegen und n ungerade ist        */
   
	exp  = 1;
	rtyp = ( -1 ) * n;

	if( p == 2 )
	{
	    if( ( icomp( a1, 1 ) == 0 )  &&  ( icomp( a2, 1 ) == 0 ) )
	    {
	        /*   X^2 + a1 X - a2 hat keine Nullstellen in F_2       */
	        if( ( n % 2 ) == 0 )
	        {
	            /*   v_2( D ) gerade.                               */
		    c_p = 2;
	        }
	        else 
	        {
	            /*   v_2( D ) ungerade.                             */
		    c_p = 1;
                }
            }
	    else
	    {
	        /*   P(X) hat zwei Nullstellen in F_2.                  */
	        c_p = n;
            }
	}
	else    /*   p != 2                                             */
	{
	    /*   b21 ist die Diskriminante des Polynoms P(X)            */
	    if( ijacsym( b21, p ) == -1 )
	    {
	        /*   X^2 + a1 X - a2 hat keine Nullstellen in F_p.      */
	        if( ( n % 2 ) == 0 )
	        {
	            /*   v_p( D ) gerade.                               */
		    c_p = 2;
	        }
	        else
	        {
	            /*   v_p( D ) ungerade.                             */
		    c_p = 1;
	        }
	    }
	    else 
	    {
	        /*   P(X) hat zwei Nullstellen in F_p.                  */
	        c_p = n;
	    }
	}

	L    = list3( exp, rtyp, c_p );

	return( L );
    }

    /*   Additive Reduktion: der eigentliche Algorithmus wird nur       */
    /*   durchlaufen, wenn p die Diskriminante und c4 teilt.            */


    h = mihom( p2, a61 );
    if ( h != 0 )
    {
	/*   REDUKTIONSTYP: C1 BZW. II.                                 */
	/*                                                              */
        /*   c_p = 1 (immer).                                           */

	exp  = n;
	rtyp = 1;
	c_p  = 1;
	L    = list3( exp, rtyp, c_p );

	return( L );
    }

    /*   Es gilt: p^2 teilt a6 ( <=> p^2 teilt b8 ).                    */

    h = mihom( p3, b81 );
    if ( h != 0 )
    {
	/*   REDUKTIONSTYP: C2 BZW. III.                                */
	/*                                                              */
        /*   c_p = 2 (immer).                                           */

	exp  = n - 1;
	rtyp = 2;
	c_p  = 2;
	L    = list3( exp, rtyp, c_p );

	return( L );
    }

    /*   Es gilt: p^3 teilt b8 ( <=> p^2 teilt b6 ).                    */

    h = mihom( p3, b61 );
    if ( h != 0 )
    {
        /*   P(X) :=  X^2 + a31 X - a61 in F_p[ X ]                     */
	/*   hat zwei verschiedene Nullstellen                          */
	/*   (im algebraischen Abschluss von F_p).                      */
	/*                                                              */
	/*   REDUKTIONSTYP: C3 BZW. IV.                                 */
	/*                                                              */
        /*          /  3, falls die Nullstellen von P(X)                */
        /*   c_p = <                       in F_p liegen                */
        /*          \  1  sonst.                                        */

	a62 = iquot( a61, p2 );
	a31 = iquot( a31, p );

	exp  = n - 2;
	rtyp = 3;
    

	if( p == 2 )
	{
            if( ( mshom( 2, a31 ) !=0 )  &&  ( mshom( 2, a62 ) != 0 ) )
	    {
	        /*   P(X) hat keine Nullstellen in F_2                  */
                c_p = 1;
	    }
	    else
	    {
	        /*   P(X) hat zwei Nullstellen in F_2                   */
	        c_p = 3;
	    }
	}
	else    /*   p != 2                                             */
	{
	    /*   h ist die Diskriminante des Polynoms P(X)              */

	    h1 = iprod( a31, a31 );
	    h2 = iprod( a62, 4 );
	    h  = idif( h2, h1 );

	    if( ijacsym( h, p ) == -1 )
	    {
	        /*   P(X) hat keine Nullstellen in F_p.                 */
	        c_p = 1;
	    }
	    else
	    {
	        /*   P(X) hat zwei Nullstellen in F_p.                  */
	        c_p = 3;
	    }
	}
	
	L    = list3( exp, rtyp, c_p );
	return( L );
    }

    /*   Es gilt an dieser Stelle: p^3 teilt b6.                        */
    /*   Transformiere E (falls notwendig) so, dass gilt:               */
    /*                                 p   teilt a1 und a2,             */
    /*                                 p^2 teilt a3 und a4,             */
    /*                                 p^3 teilt a6.                    */

    ok  = 1;

    h = mihom( p, a11 );
    if ( h == 0 )
    {
	h = mihom( p, a21 );
	if ( h == 0 )
	{
	    h = mihom( p2, a31 );
	    if ( h == 0 )
	    {
		h = mihom( p2, a41 );
		if ( h == 0 )
		{
		    h = mihom( p3, a61 );
		    if ( h == 0 )
		    {
			/*    Teilbarkeitsbedingungen bereits erfuellt. */
			/*    Keine Transformation notwendig.           */

			a12 = a11;
			a22 = a21;
			a32 = a31;
			a42 = a41;
			a62 = a61;

			ok  = 0;
		    }
		}
	    }
	}
    }

    if ( ok == 1 )
    {
	/*   Teilbarkeitsbedingungen nicht erfuellt.                    */
	/*   Transformiere E.                                           */

	tr = 1;

	for ( r = 0; icomp( r, p ) != 1 && tr; r = isum( r, 1 ) )
	    for ( s = 0; icomp( s, p ) != 1 && tr; s = isum( s, 1 ) )
		for ( t = 0; icomp( t, p2 ) != 1 && tr; t = isum( t, 1 ) )
		{
		    a12 = trans1( a11,                        s    );
		    a22 = trans2( a11, a21,                r, s    );
		    a32 = trans3( a11,      a31,           r,    t );
		    a42 = trans4( a11, a21, a31, a41,      r, s, t );
		    a62 = trans6( a11, a21, a31, a41, a61, r, s, t );

		    h = mihom( p, a12 );
		    if ( h == 0 )
		    {
			h = mihom( p, a22 );
			if ( h == 0 )
			{
			    h = mihom( p2, a32 );
			    if ( h == 0 )
			    {
				h = mihom( p2, a42 );
				if ( h == 0 )
				{
				    h = mihom( p3, a62 );
				    if ( h == 0 )
					tr = 0;
				}
			    }
			}
		    }

		    /*   Ende der zweiten for-Schleifen.                */

		}

	if ( tr != 0 )
	{

	    /*   Fehler in der Rechnung: keine Transformation gefunden. */

	    return( list1( -1 ) );
	}
    }

    lh1 = iquot( a22,   p );
    a23 = mihom(   p, lh1 );

    lh1 = iquot( a42,  p2 );
    a43 = mihom(   p, lh1 );

    lh1 = iquot( a62,  p3 );
    a63 = mihom(   p, lh1 );

    /*   Sei nun P(T) das Polynom P(T) = T^3 + a23*T^2 + a43*T +a63.    */
    /*   Im folgenden ist h die Anzahl der  v e r s c h i e d e n e n   */
    /*   Nullstellen von P(T) in F_p = Z/pZ.                            */
    /*   Fuer p == 2 wird h direkt durch Fallunterscheidung der         */
    /*   Koeffizienten von P(T) ermittelt.                              */

    if ( icomp( p, 2 ) != 0 )
    {
        init( P, Q );
	P = _0;
        if ( a63 ) P = lcomp2( 0, a63, P );
        if ( a43 ) P = lcomp2( 1, a43, P );
        if ( a23 ) P = lcomp2( 2, a23, P );
	           P = lcomp2( 3,   1, P );
        
	Q = upmsgsd( p, P );
        h = lfirst( Q );

    }
    else
    {
	if ( ( a23 == 0 && a43 == 0 && a63 == 1 ) ||
	     ( a23 == 0 && a43 == 1 && a63 == 1 ) ||
	     ( a23 == 1 && a43 == 0 && a63 == 1 ) ||
	     ( a23 == 1 && a43 == 1 && a63 == 0 ) )
	{
	     h = 3;
	}
	else
	{
	    if ( ( a23 == 0 && a43 == 1 && a63 == 0 ) ||
		 ( a23 == 1 && a43 == 0 && a63 == 0 ) )
	    {
		h = 2;
	    }
	    else
	    {
		h = 1;

		/*   Es ist dann:                                       */
		/*   ( ( a23 == 0 && a43 == 1 && a63 == 0 ) ||          */
		/*     ( a23 == 1 && a43 == 0 && a63 == 0 ) )           */
	    }
	}
    }

    if ( icomp( h, 3) == 0 )
    {
        /*   P(T) = T^3 + a23 X^2 + a43 X + a63 in F_p[X]               */
	/*   hat drei verschiedene Nullstellen                          */
	/*   (im algebraischen Abschluss von F_p).                      */
	/*                                                              */
	/*   REDUKTIONSTYP: C4 BZW. I0*.                                */
	/*                                                              */
        /*   Dann ist c_p = 1 + Anzahl der Nullstellen von P(T) in F_p  */
        /*                = 1 + { 0, 1 oder 3 }                         */

	exp  = n - 4;
	rtyp = 4;
    
	if ( p == 2 ) 
	{
	    if ( icomp( a23, a43 ) == 0 )
	    {
	        /*   P(T) hat eine ( = 1 ) Nullstelle in F_2.           */
	        c_p = 2;
	    }
	    else
	    {
	        /*   P(T) hat keine Nullstelle in F_2.                  */
	        c_p = 1;
	    }
	    /*   Der Fall '3 Nullstellen' ist nicht moeglich, da        */
	    /*   alle Nullstellen verschieden sind und #F_2 = 2 ist.    */
	}
        else  /* p != 2 */
	{
	    Lh  = upmscfacts( p, P );
	    if( llength( Lh ) == 2 ) 
	    {
	        /*   P(T) irreduzibel ueber F_p                         */
		/*   ==>  P(T) hat keine Nullstelle in F_p.             */
	        c_p = 1;
	    }
	    else if( llength( Lh ) == 4 )
	    {
	        /*   P(T) besteht aus 2 ueber F_p irreduziblen          */
	        /*   Faktoren  ==>  P(T) hat eine Nullstelle in F_p.    */
	        c_p = 2;
	    }
	    else
	    {
	        /*   P(T) besteht aus 3 ueber F_p irreduziblen          */
	        /*   Faktoren  ==>  P(T) hat drei Nullstellen in F_p.   */
	        c_p = 4;
            }
	}

	L    = list3( exp, rtyp, c_p );

	return( L );
    }

    if ( icomp( h, 2 ) == 0 )
    {
        /*   P(T) = T^3 + a23 X^2 + a43 X + a63 in F_p[X]               */
	/*   hat zwei verschiedene Nullstellen, eine doppelte           */
	/*   Nullstelle t und eine einfache Nullstelle u,               */
	/*   (im algebraischen Abschluss von F_p).                      */
	/*                                                              */
	/*   Es liegt Reduktionstyp C5,v bzw. Iv* ( v > 0 ) vor.        */
	/*   ( v muss noch berechnet werden. )                          */
	/*                                                              */
	/*   Transformiere (falls notwendig) E so,                      */
	/*   dass die doppelte Nullstelle bei 0 liegt.                  */

	if ( ( a43 == 0 )  &&  ( a63 == 0 ) )
	{
	    /*   t == 0, keine Transformation notwendig.                */

	    a14 = a12;
	    a24 = a22;
	    a34 = a32;
	    a44 = a42;
	    a64 = a62;
	}
	else
	{
	    /*   t != 0, transformiere E.                               */

	    tr  = 1;
	    r   = 0;

	    while ( tr )
	    {
		a24 = trans2( a12, a22,                r, 0    );
		a44 = trans4( a12, a22, a32, a42,      r, 0, 0 );
		a64 = trans6( a12, a22, a32, a42, a62, r, 0, 0 );

		h = mihom( p, a24 );
		if ( h == 0 )
		{
		    h = mihom( p2, a24 );
		    if ( h != 0 )
		    {
			h = mihom( p3, a44 );
			if ( h == 0 )
			{
			    h = mihom( p4, a64 );
			    if ( h == 0 )
			    {
				tr  = 0;

				a14 = trans1( a12,         0 );
				a34 = trans3( a12, a32, r, 0 );
			    }
			}
		    }
		}

		r++;

	    }
	}

	/*   Berechnung von v                                           */
	/*   ( Immer noch im Fall einer doppelten Nullstelle ).         */

	for ( ; ; )
	{
	    hi1 = p;

	    for ( j = 1; j <= 15; j++ )
	    {
		hi1 = iprod( hi1,   p );
		hi2 = iprod( hi1,   p );
		hi3 = iprod( hi2,   p );
		hi4 = iprod( hi1, hi1 );
		hi5 = iprod( hi4,   p );
		hi6 = iprod( hi5,   p );

		v++;

		a38 = iquot( a34, hi1 );
		a68 = iquot( a64, hi4 );
		a68 =  ineg( a68 );

		a36 = mihom(   p, a38 );
		a66 = mihom(   p, a68 );

		h1  = iprod(   4, a66 );
		h2  = iprod( a36, a36 );
		h1  =  idif(  h1,  h2 );
		h1  = mihom(   p,  h1 );

		if ( h1 != 0 )
		{
		    /*   Q(Y) = Y^2 + a36*Y + a66 in F_p[Y]             */
		    /*   hat zwei verschiedene Nullstellen              */
		    /*   (im algebraischen Abschluss von F_p).          */
		    /*                                                  */
		    /*   REDUKTIONSTYP: C5v BZW. Iv*.                   */
		    /*                                                  */
                    /*          /  4, falls die Nullstellen von Q(Y)    */
		    /*   c_p = <                       in F_p liegen    */
                    /*          \  2  sonst.                            */

		    exp  = n - 4 - v;
		    rtyp = 10 + v;

	            if( p == 2 )
	            {
	                if( ( a36 == 0 )  ||  ( a66 == 0 ) )
		        {
		            /*   Q(Y) hat zwei Nullstellen in F_2.      */
	                    c_p = 4;
		        }
		        else
		        {
	                    /*   Q(Y) hat keine Nullstellen in F_2.     */
                            c_p = 2;
	                }
	            }
	            else    /*   p != 2                                 */
	            {
	                /*   h1 ist die Diskriminante des Polynoms Q(Y) */
	                if( ijacsym( h1, p ) == -1 )
	                {
	                    /*   Q(Y) hat keine Nullstellen in F_p.     */
	                    c_p = 2;
	                }
	                else
	                {
	                    /*   Q(Y) hat zwei Nullstellen in F_p.      */
		            c_p = 4;
		        }
	            }
	
		    L    = list3( exp, rtyp, c_p );

		    return( L );
		}

		/*   Q(Y) hat eine doppelte Nullstelle y (in F_p).      */
		/*   Transformiere E (falls notwendig) so, dass gilt:   */
		/*           y = 0, p^4 teilt a4, p^6 teilt a6.         */

		if ( ( a36 == 0 )  &&  ( a66 == 0 ) )
		{
		    /*    y = 0, keine Transformation notwendig.        */

		    a17 = a14;
		    a27 = a24;
		    a37 = a34;
		    a47 = a44;
		    a67 = a64;

		    h = mihom( p, a27 );
		    if ( h != 0 )
		    {
			lh1 = mihom( hi2, a47 );
			if ( lh1 != 0 )
			{
			    lh1 = mihom( hi5, a67 );
			    if ( lh1 != 0 )
			    {
				/*   Fehler in der Rechnung:            */
				/*   Teilbarkeitsbedingungen            */
				/*   nicht erfuellt.                    */

				return( list1( -1 ) );
			    }
			}
		    }
		}
		else
		{
		    /*   y != 0. Transformiere also E so, dass y = 0.   */

		    tr  = 1;
		    t   = 0;

		    while ( tr )
		    {
			a37 = trans3( a14,      a34,              0, t );
			a67 = trans6( a14, a24, a34, a44, a64, 0, 0, t );

			lh1 = mihom( hi2, a37 );
			if ( lh1 == 0 )
			{
			    lh1 = mihom( hi5, a67 );
			    if ( lh1 == 0 )
			    {
				tr  = 0;

				a17 = trans1( a14,                0       );
				a27 = trans2( a14, a24,           0, 0    );
				a47 = trans4( a14, a24, a34, a44, 0, 0, t );

				h = mihom( p, a27 );
				if ( h != 0 )
				{
				    lh1 = mihom( hi2, a47 );
				    if ( lh1 != 0 )
				    {
					lh1 = mihom( hi5, a67 );
					if ( lh1 != 0 )
					{
					    /*  Fehler in der Rechnung:  */
					    /*  Teilbarkkeitsbedingungen */
					    /*  nicht erfuellt.          */

					    return( list1( -1 ) );
					}
				    }
				}
			    }
			}

			t++;

		    }

		    /*   Ende der Transformation fuer y = 0.            */

		}

		v++;

		a28 = iquot( a27,   p );
		a48 = iquot( a47, hi2 );
		a68 = iquot( a67, hi5 );

		a29 = mihom(   p, a28 );
		a49 = mihom(   p, a48 );
		a69 = mihom(   p, a68 );

		/*   Teste R(Y) = a29*Y^2 + a49*Y + a69                 */
		/*   auf die Anzahl der verschiedenen Nullstellen       */
		/*   (im algebraischen Abschluss von F_p).              */

		if ( a29 == 0 )
		{
			/*   Fehler in der Rechnung:                    */
			/*   R(Y) ist keine quadratische Gleichung.     */

			return( list1( -1 ) );
		}

		h1  = iprod( a49, a49 );
		h2  = iprod(   4, a29 );
		h2  = iprod(  h2, a69 );
		h1  =  idif(  h1,  h2 );
		h1  = mihom(   p,  h1 );

		if ( h1 != 0 )
		{
		    /*   R(Y) = a29 Y^2 + a49 Y + a69                   */
		    /*   hat zwei verschiedene Nullstellen              */
		    /*   (im algebraischen Abschluss von F_p).          */
		    /*                                                  */
		    /*   REDUKTIONSTYP: C5v BZW. Iv*.                   */
		    /*                                                  */
                    /*          /  4, falls die Nullstellen von Q(Y)    */
		    /*   c_p = <                       in F_p liegen    */
                    /*          \  2  sonst.                            */

	            if( p == 2 )
	            {
	                if( ( icomp( a49, 1 ) == 0 )  && 
			    ( icomp( a69, 1 ) == 0 ) )
		        {
	                    /*   Q(Y) hat keine Nullstellen in F_2.     */
                            c_p = 2;
	                }
		        else
		        {
		            /*   Q(Y) hat zwei Nullstellen in F_2.      */
	                    c_p = 4;
		        }
	            }
	            else    /*   p != 2                                 */
	            {
	                /*  h1 ist die Diskriminante des Polynoms Q(Y)  */
	                if( ijacsym( h1, p ) == -1 )
	                {
	                    /*   Q(Y) hat keine Nullstellen in F_p.     */
	                    c_p = 2;
	                }
	                else
	                {
	                    /*   Q(Y) hat zwei Nullstellen in F_p.      */
		            c_p = 4;
		        }
	            }
	
		    exp  = n - 4 - v;
		    rtyp = 10 + v;
	            L    = list3( exp, rtyp, c_p );
 
		    return( L );
		}

		/*   R(Y) hat eine doppelte Nullstelle y (in F_p).      */
		/*   Transformiere E (falls notwendig) so, dass y = 0.  */

		if ( ( a49 == 0 )  &&  ( a69 == 0 ) ) 
		{
		    /*   y = 0: keine Transformation notwendig.         */

		    a10 = a17;
		    a20 = a27;
		    a30 = a37;
		    a40 = a47;
		    a60 = a67;
		}
		else
		{
		    tr  = 1;
		    r   = 0;

		    while ( tr )
		    {
			a20 = trans2( a17, a27,                r, 0    );
			a40 = trans4( a17, a27, a37, a47,      r, 0, 0 );
			a60 = trans6( a17, a27, a37, a47, a67, r, 0, 0 );

			h = mihom( p, a20 );
			if ( h == 0 )
			{
			    h = mihom( p2, a20 );
			    if ( h != 0 )
			    {
				lh1 = mihom( hi3, a40 );
				if ( lh1 == 0 )
				{
				    lh1 = mihom( hi6, a60 );
				    if( lh1 == 0 )
				    {
					tr  = 0;

					a10 = trans1( a17,         0 );
					a30 = trans3( a17, a37, r, 0 );
				    }
				}
			    }
			}

			r++;

		    }
		}

		a14 = a10;
		a24 = a20;
		a34 = a30;
		a44 = a40;
		a64 = a60;
	    }

	    /*   Ende der for-Schleife                                  */

	}

	/*   Ende der while-Schleife.                                   */

    }

    /*   Ende des Falles 'h = 2'; 2 verschiedene Nullstellen.           */

    /*   Beginn des Falles 'h = 1'; eine dreifache Nullstelle.          */
    /*   Transformiere E (falls notwendig) so,                          */
    /*   dass die dreifache Nullstelle bei 0 liegt.                     */

    if ( a63 == 0 )
    {
	/*   Dann ist auch t = 0. Keine Transformation notwendig.       */

	a14 = a12;
	a24 = a22;
	a34 = a32;
	a44 = a42;
	a64 = a62;
    }
    else
    {
	/*   t != 0. Transformiere E.                                   */

	tr  = 1;
	r   = 0;

	while ( tr )
	{
	    a24 = trans2( a12, a22,                r, 0    );
	    a44 = trans4( a12, a22, a32, a42,      r, 0, 0 );
	    a64 = trans6( a12, a22, a32, a42, a62, r, 0, 0 );

	    h = mihom( p2, a24 );
	    if ( h == 0 )
	    {
		h = mihom( p3, a44 );
		if ( h == 0 )
		{
		    h = mihom( p4, a64 );
		    if ( h == 0 )
		    {
			tr  = 0;

			a14 = trans1( a12,         0 );
			a34 = trans3( a12, a32, r, 0 );
		    }
		}
	    }

	    r++;

	}
    }

    lh1 = iquot( a34,  p2 );
    a36 = mihom(   p, lh1 );
    lh1 = iquot( a64,  p4 );
    lh1 =  ineg( lh1 );
    a66 = mihom(   p, lh1 );

    h1  = iprod(   4, a66 );
    h2  = iprod( a36, a36 );
    h1  =  idif(  h1,  h2 );
    h1  = mihom(   p,  h1 );

    if ( h1 != 0 )
    {
	/*   S(Y) = Y^2 + a36*Y + a66 in F_p[X]                         */
	/*   hat zwei verschiedene Nullstellen                          */
	/*   (im algebraischen Abschluss von F_p).                      */
        /*                                                              */
	/*   REDUKTIONSTYP: C6 BZW. IV*.                                */
        /*                                                              */
        /*          /  3, falls die Nullstellen von S(Y)                */
        /*   c_p = <                       in F_p liegen                */
        /*          \  1  sonst                                         */

	exp  = n - 6;
	rtyp = 6;
    
	if( p == 2 )
	{
	    if( ( a36 == 0 )  ||  ( a66 == 0 ) )
	    {
	        /*   S(Y) hat zwei Nullstellen in F_2                   */
	        c_p = 3;
	    }
	    else  
	    {
	        /*   S(Y) hat keine Nullstellen in F_2                  */
                c_p = 1;
	    }
	}
	else    /*   p != 2                                             */
	{
	    /*   h1 ist die Diskriminante des Polynoms S(Y)             */
	    if( ijacsym( h1, p ) == -1 )
	    {
	        /*   S(Y) hat keine Nullstellen in F_p.                 */
	        c_p = 1;
	    }
	    else
	    {
	        /*   S(Y) hat zwei Nullstellen in F_p.                  */
	        c_p = 3;
	    }
	}
	
	L    = list3( exp, rtyp, c_p );

	return( L );
    }

    /*   S(Y) hat eine doppelte Nullstelle y (in F_p).                  */
    /*   Transformiere E (falls notwendig) so,                          */
    /*   dass diese Nullstelle bei 0 liegt.                             */

    if ( a66 == 0 )
    {
	/*   y = 0. Keine Transformation notwendig.                     */

	a17 = a14;
	a27 = a24;
	a37 = a34;
	a47 = a44;
	a67 = a64;
    }
    else
    {
	/*   y != 0. Transformiere E.                                   */

	tr  = 1;
	t   = 0;

	while ( tr )
	{
	    a37 = trans3( a14,      a34,              0, t );
	    a67 = trans6( a14, a24, a34, a44, a64, 0, 0, t );

	    h = mihom( p3, a37 );
	    if ( h == 0 )
	    {
		h = mihom( p5, a67 );
		if ( h == 0 )
		{
		    tr  = 0;

		    a17 = trans1( a14,                   0    );
		    a27 = trans2( a14, a24,           0, 0    );
		    a47 = trans4( a14, a24, a34, a44, 0, 0, t );
		}
	    }

	    t++;

	}
    }

    h = mihom( p3, a47 );
    if ( h == 0 )
    {
	h = mihom( p4, a47 );
	if ( h != 0 )
	{
	    /*   REDUKTIONSTYP: C7 BZW. III*.                           */
	    /*                                                          */
            /*   c_p = 2 (immer).                                       */

	    exp  = n - 7;
	    rtyp = 7;
	    c_p  = 2;
	    L    = list3( exp, rtyp, c_p );

	    return( L );
	}

	h = mihom( p6, a67 );
	if ( h != 0 )
	{
	    /*   REDUKTIONSTYP: C8 BZW. II*.                            */
	    /*                                                          */
            /*   c_p = 1 (immer).                                       */

	    exp  = n - 8;
	    rtyp = 8;
	    c_p  = 1;
	    L    = list3( exp, rtyp, c_p );

	    return( L );
	}

	/*   Die vorgegebene elliptische Kurve E war nicht minimal.     */

	a11 = iquot( a17,   p );
	a21 = iquot( a27,  p2 );
	a31 = iquot( a37,  p3 );
	a41 = iquot( a47,  p4 );
	a61 = iquot( a67,  p6 );

	return( list5( a11, a21, a31, a41, a61 ) );
    }
}





/*c
			trans1( a1, s )

	"transformation of a1"
	static int trans1( a1, s )  int a1; single s;
	trans1 transformiert birational den Koeffizienten a1
	einer elliptischen Kurve gemaess
		a1' = a1 + 2*s.
	trans1 ist ein static-Modul zu ecitatealg.
c*/


static int trans1( a1, s )
int    a1;
single  s;

{
    int a1n;

    bind( a1 );
    init( a1n );

    a1n = iprod(   2,   s );
    a1n =  isum(  a1, a1n );

    return( a1n );
}










/*c
			trans2( a1, a2, r, s )

	"transformation of a2"
	static int trans2( a1, a2, r, s ) int a1, a2; single r, s;
	trans2 transformiert birational den Koeffizienten a2
	einer elliptischen Kurve gemaess
		a2' = a2 - s*a1 + 3*r - s^2.
	trans2 ist ein static-Modul zu ecitatealg.
c*/


static int trans2( a1, a2, r, s )
int    a1, a2;
single  r,  s;

{
    int a2n, h1;

    bind( a1, a2 );
    init( a2n, h1 );

    a2n = a2;
    h1  = iprod(   s,  a1 );
    a2n =  idif( a2n,  h1 );
    h1  = iprod(   3,   r );
    a2n =  isum( a2n,  h1 );
    h1  = iprod(   s,   s );
    a2n =  idif( a2n,  h1 );

    return( a2n );
}










/*c
			trans3( a1, a3, r, t )

	"transformation of a3"
	static int trans3( a1, a3, r, t )  int a1, a3; single r, t;
	trans3 transformiert birational den Koeffizienten a3
	einer elliptischen Kurve gemaess
		a3' = a3 + r*a1 + 2*t.
	trans3 ist ein static-Modul zu ecitatealg.
c*/


static int trans3( a1, a3, r, t )
int    a1, a3;
single  r,  t;

{
    int a3n, h1;

    bind( a1, a3 );
    init( a3n, h1 );

    a3n = a3;
    h1  = iprod(   r,  a1 );
    a3n =  isum( a3n,  h1 );
    h1  = iprod(   2,   t );
    a3n =  isum( a3n,  h1 );

    return( a3n );
}










/*c
			trans4( a1, a2, a3, a4, r, s, t )

	"transformation of a4"
	static int trans4( a1, a2, a3, a4, r, s, t )
		int a1, a2, a3, a4; single r, s, t;
	trans4 transformiert birational den Koeffizienten a4
	einer elliptischen Kurve gemaess
		a4' = a4 - s*a3 + 2*r*a2 - ( t + r*s )*a1 + 3*r^2 - 2*s*t.
	trans4 ist ein static-Modul zu ecitatealg.
c*/


static int trans4( a1, a2, a3, a4, r, s, t )
int    a1, a2, a3, a4;
single  r,  s,  t;

{
    int a4n, h1;

    bind( a1, a2, a3, a4 );
    init( a4n, h1 );

    a4n = a4;
    h1  = iprod(   s,  a3 );
    a4n =  idif( a4n,  h1 );
    h1  = iprod(   2,   r );
    h1  = iprod(  h1,  a2 );
    a4n =  isum( a4n,  h1 );
    h1  = iprod(   r,   s );
    h1  =  isum(   t,  h1 );
    h1  = iprod(  h1,  a1 );
    a4n =  idif( a4n,  h1 );
    h1  = iprod(   r,   r );
    h1  = iprod(   3,  h1 );
    a4n =  isum( a4n,  h1 );
    h1  = iprod(   2,   s );
    h1  = iprod(  h1,   t );
    a4n =  idif( a4n,  h1 );

    return( a4n );
}










/*c
			trans6( a1, a2, a3, a4, a6, r, s, t )

	"transformation of a6"
	static int trans6( a1, a2, a3, a4, a6, r, s, t )
		int a1, a2, a3, a4, a6; single r, s, t;
	trans6 transformiert birational den Koeffizienten a6
	einer elliptischen Kurve gemaess
		a6' = a6 + r*a4 + r^2*a2 + r^3 - t*a3 - r*t*a1 -t^2.
	trans6 ist ein static-Modul zu ecitatealg.
c*/


static int trans6( a1, a2, a3, a4, a6, r, s, t )
int    a1, a2, a3, a4, a6;
single  r,  s,  t;

{
    int a6n, h1;

    bind( a1, a2, a3, a4, a6 );
    init( a6n, h1 );

    a6n = a6;
    h1  = iprod(   r,  a4 );
    a6n =  isum( a6n,  h1 );
    h1  = iprod(   r,   r );
    h1  = iprod(  h1,  a2 );
    a6n =  isum( a6n,  h1 );
    h1  = iprod(   r,   r );
    h1  = iprod(  h1,   r );
    a6n =  isum( a6n,  h1 );
    h1  = iprod(   t,  a3 );
    a6n =  idif( a6n,  h1 );
    h1  = iprod(   t,   t );
    a6n =  idif( a6n,  h1 );
    h1  = iprod(   r,   t );
    h1  = iprod(  h1,  a1 );
    a6n =  idif( a6n,  h1 );

    return( a6n );
}

