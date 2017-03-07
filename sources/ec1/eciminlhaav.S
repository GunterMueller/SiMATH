/*M
.SH NAME
eciminlhaav - elliptic curve with integer coefficients, minimal model, local height at the archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating eciminlhaav(E1, P1)  
list E1, P1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B P1
= ( x y z )   int x, y, z;
 defines the point P on the minimal model ( of 
 restricted typ; i.e. a1', a3' = 0 or 1, 
 a2' = -1, 0, 1.) of the elliptic curve E/Q.
.PP
eciminlhaav computes the local Neron-Tate height of P at the archimedean absolute value of Q with an error of the magnitude O( 4^{-NTH_EPS} ) .
(default: NTH_EPS = 20, see '_ec1.h').
E will be changed.
 
.SH SEE ALSO
ecrinit

J.H. Silverman: Math. of Comp., 51, 1988, p.339-350.

M*/

/*H
	Version 1       19.02.1992      Joachim Stein
	Version 2	05.10.1992	lambda := lambda(alt) - log(D)/12
				        zusaetzlich D als Parameter.  J.St.
	Version 3       04.01.1993      Anpassung an neues Konzept.
					Summanden -log(D)/12 wieder 
					auskommentiert.  JG
	Version 4	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE eciminlhaav   : 920331.921130.930531.931130
H*/

#include <_ec1.h>

static list eciminLnth(list);

floating eciminlhaav( E, P ) 
list E, P;
{
    single   i, Nnth, flag;
    int      hi;
    list     L, Lwz, Lbm, Lbs;
    floating erg, hf, my, eins, vier, x, t, w, z;
    floating b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s;

    bind( E, P );
    
    init( hi );
    init( L, Lwz, Lbm, Lbs );
    init( erg, hf, my, eins, vier );
    init( x, t, w, z );
    init( b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s );
   
    if( ispecrpai( P ) )
    {
        /*   P = ( 0 : 1 : 0 )   */
	return( 0 );
    }
	
    vier = itofl( 4 );
    eins = itofl( 1 );

    Lbs  = eciminLnth( E );
    Nnth = lfirst( Lbs );
    Lbs  = lred ( Lbs );  /*  Lbs = ( b2'  b4'  b6'  b8' )  */

    /*   Berechnung von b2', b4', b6', b8'   */
    hi  = lfirst ( Lbs );
    b2s = itofl( hi );
    hi  = lsecond( Lbs );
    b4s = itofl( hi );
    hi  = lthird ( Lbs );
    b6s = itofl( hi );
    hi  = lfourth( Lbs );
    b8s = itofl( hi );

    /*   Berechnung von b2, b4, b6, b8   */
    hi  = eciminb2( E );
    b2m = itofl( hi );
    hi  = eciminb4( E );
    b4m = itofl( hi );
    hi  = eciminb6( E );
    b6m = itofl( hi );
    hi  = eciminb8( E );
    b8m = itofl( hi );

    /*   Initialisierung von t und flag    */
    x  = itofl( lfirst(  P ) );
    hi = lthird( P );
    hi = iprod ( hi, hi );
    x  = flquot( x, itofl( hi ) );

    hf = Cfltofl( 0.5 );
    if( flcomp( hf, flabs( x ) ) <= 0 )
    {
	/*   |x| >= 1/2: t = 1 / x   */

	t = flquot( eins, x );
	flag = 1;
    }
    else
    {
	/*   |x| < 1/2: t = 1 / (x + 1)  */

	t = flsum ( eins, x );
	t = flquot( eins, t );

	flag = 0;
    }

    /*   erg = log|t|    */
    hf  = flabs( t );
    erg = fllog( hf );

    L = _0;

    for( i = 0; i <= Nnth; i++ )
    {
	if( flag )
	{
	    /*   flag == 1    */

	    /*  Berechne w und z   */
	    w = flprod(  b6m, t );
	    w = flsum (  b4m, w );
	    w = flsum (  b4m, w );
	    w = flprod(    w, t );
	    w = flsum (  b2m, w );
	    w = flprod(    w, t );
	    w = flsum ( vier, w );
	    w = flprod(    w, t );

	    z = flprod(  b8m, t );
	    z = flsum (  b6m, z );
	    z = flsum (  b6m, z );
	    z = flprod(    z, t );
	    z = flsum (  b4m, z );
	    z = flprod(    z, t );
	    z = flprod(    z, t );
	    z = fldif ( eins, z );

            hf = flabs( z );
	    hf = flsum( hf, hf );

	    if( flcomp( hf, flabs( w ) ) <= 0 )
	    {
		/*   |w| > 2 |z|   */
		z = flsum( z, w );
		
		flag = 0;
	    }
	    
	    t = flquot( w, z );

	}
	else
	{
	    /*   flag == 0    */

	    /*  Berechne w' und z'   */
	    w = flprod(  b6s, t );
	    w = flsum (  b4s, w );
	    w = flsum (  b4s, w );
	    w = flprod(    w, t );
	    w = flsum (  b2s, w );
	    w = flprod(    w, t );
	    w = flsum ( vier, w );
	    w = flprod(    w, t );

	    z = flprod(  b8s, t );
	    z = flsum (  b6s, z );
	    z = flsum (  b6s, z );
	    z = flprod(    z, t );
	    z = flsum (  b4s, z );
	    z = flprod(    z, t );
	    z = flprod(    z, t );
	    z = fldif ( eins, z );
	    
            hf = flabs( z );
	    hf = flsum( hf, hf );

	    if( flcomp( hf, flabs( w ) ) <= 0 )
	    {
		/*   |w'| > 2 |z'|   */
		z = fldif( z, w );
		
		flag = 1;
	    }
	    
	    t = flquot( w, z );

	}
	
	
	hf = fllog( flabs( z ) );
	L  = lcomp( hf, L );
    }

    /*                               _N_   log | z_i |          */
    /*                               \    --------------        */
    /*    Ausrechnen der Summe  my = /__       4^i              */
    /*                               i=1                        */
    /*    mit Horner-Schema.                                    */

    vier = flquot( eins, vier );  /*  Ab hier: vier = 1/4       */
    my   = 0;

    while( L != _0 )
    {
        my = flsum ( my, lfirst(  L ) );
        my = flprod( my, vier );

	L = lred( L );
    }

    erg = fldif ( my, erg );
    erg = flquot( erg, itofl( 2 ) );

    /*    Wegen der Summenformel fuer Bewertungen von Q  kann   */
    /*                  log( |D| )                              */
    /*    der Term  -  ------------  weggelassen werden, wenn   */
    /*                     12                                   */
    /*    bei der Berechneung der lokalen nichtarchimedischen   */
    /*    die entsprechenden Terme weggelassen werden.          */
    /*    Um die wirkliche lokale Neron-Tate-Hoehe zu be-       */
    /*    rechnen, muessen die Terme aber beruecksichtigt       */
    /*    werden. Zur Beschleunigung des Programms werden       */
    /*    sie hier auskommentiert, also weggelassen.            */

    /*    hf  = itofl( ecimindisc( E ) );                       */
    /*    my  = flabs( hf );                                    */
    /*    hf  = fllog ( my );                                   */
    /*    my  = flquot( hf, itofl( 12 ) );                      */
    /*    erg = fldif ( erg, my );                              */

    return( erg );
}

/**********   Ende von  e c i m i n l h a a v   *****************/

/*c
                eciminLnth( E )

        "elliptic curve with integer coefficients, minimal model,
	 bound N for summation of Neron-Tate height"
        Quellbibliothek: srclib.ec1
        Include-Datei:   _ec1.h
	list eciminLnth( E )  list E;
	Lnth = eciminLnth( E );
	ecmLnth liefert 
	  - bei korrektem Lauf die 5-elementige Liste 
		Lnth = ( Nnth  b2'  b4'  b6'  b8' ) 
		single Nnth; int b2', b4', b6', b8';
            mit Groesen zur Berechnung der lokalen archimedischen Neron-
	    Tate-Hoehe fuer die elliptische Kurve E/Q (siehe 'ecrinit').
          - ERROR sonst,
        Falls Lnth noch nicht in der Liste E vorhanden ist, so wird 
	diese Liste berechnet und dort abgelegt.
	Die Groessen sind wie folgt definiert:
	          __                                   __
	          |  5               1     4             |
	   Nnth = | --- * NTH_EPS + --- + --- * log( H ) |
                  |  3               2     3             |
                  mit H = max{ 4, |b2|, 2 * |b4|, 2 * |b6|, |b8| }
        
	   b2'  = b2m - 12
	   b4'  = b4m - b2m + 6
	   b6'  = b6m - 2b4m + b2m - 4
           b8'  = b8m - 3 b6m + 3 b4m - b2m + 3

	E wird veraendert.
        Literatur: J.H. Silverman: Math. of Comp., 51, 1988, p.339-358.
c*/


static list eciminLnth( E )
list E;
{
    if( lsixth( lfourth( E ) ) == _0 )
    {
	/*   Lnth ist noch nicht berechnet   */
    
        single n, Nnth;
        int max, hi, b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s;
        floating hf;
        list L, Lnth;

        bind( E );

        init( L, Lnth );
        init( max, hi, b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s );
	init( hf );
    
	/*   max = max{ 4, |b2|, 2 * |b4|, 2 * |b6|, |b8| }     */

	max = 4;
	
	b8m = eciminb8( E );
	hi  = iabs( hi );
	if( icomp( hi, max ) > 0 )
	{
	    max = hi;
	}
	
	b6m = eciminb6( E );
	hi  = iabs( hi );
	if( icomp( hi, max ) > 0 )
	{
	    max = hi;
	}
	
	b4m = eciminb4( E );
	hi  = iabs( hi );
	if( icomp( hi, max ) > 0 )
	{
	    max = hi;
	}
	
	b2m = eciminb2( E );
	hi  = iabs( hi );
	if( icomp( hi, max ) > 0 )
	{
	    max = hi;
	}

        /*   Berechnung von Nnth              */
	
	n  = 3 + 10 * NTH_EPS;
	hf = fllog ( itofl( max ) );
	hf = flprod( hf, itofl( 8 ) );
	hf = flsum ( hf, itofl( n ) );
	hf = flquot( hf, itofl( 6 ) );

	Nnth = flfloor( hf ) + 1;

	b2s = idif ( b2m,  12 );

	b4s = idif ( b4m, b2m );
	b4s = isum ( b4s,   6 );
	
	hi  = idif ( b6m, b4m );
	b6s = idif (  hi, b4m );
	b6s = isum ( b6s, b2m );
	b6s = idif ( b6s,   4 );

	b8s = iprod(  hi,   3 );
	b8s = idif ( b8m, b8s );
	b8s = idif ( b8s, b2m );
	b8s = isum ( b8s,   3 );

	Lnth = list6( Nnth, b2s, b4s, b6s, b8s, NTH_EPS );

	L = lfourth( E );
	leset( L, 6, Lnth );
	leset( E, 4, L );

        return( Lnth );
    }

    return( lsixth( lfourth( E ) ) );
}   
/************   Ende von  e c i m i n L n t h   *****************/
