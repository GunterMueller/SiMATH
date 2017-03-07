/*M
.SH NAME
ecrsigns - elliptic curve over rational numbers, sign of the functional equation, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrsigns(E, A, C)  
single *A, *C;  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.  
.PP  
ecrsigns returns NULL, if there was an ERROR within the computations or, by success, a pointer A on an array of singles with A[n] = a_n, the coefficients of the L-series (see 'ecrclser') and writes the sign of  the functional equation to C. 
.SH SEE ALSO
 ecrinit
 ecrclser

M*/
       
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	14.01.1993	Anpassung an neues Konzept. JG
	Version 3	16.09.1993	Abbruchsbed. geaendert. JG
	Version 4	11.12.1993	Ableitung der Fouriertrans-
                                        formation herausgenommen. JG.
	Version 5	22.11.1994	Zusaetzlichen Test eingefuehrt,
                                        falls Rang( E/Q ) = 0. JG.
	Version 6	14.12.1994	Neue Methode verwendet. JG.
                                        PI2 durch 2 * flPi() ersetzt
	Version 7	30.05.1996	Fehler beseitigt. JG.
   DATE ecrsigns      : 921130.930531.961201
H*/

#include <_ec2.h>

/***********************************************************************/
/***                                                                 ***/
/***    s t a t i c   f u n c t i o n s   ( b e g i n n i n g )      ***/
/***                                                                 ***/
/***********************************************************************/

static single *get_sign_s( E, A, C )
list E;
single *A, *C;
{
    double dh1, dh2, dh3, dh4, dist, fltoCfl( ); 
    floating fl;
    single k, *ecrfelser( );

    init( fl );
    bind( E );

    fl = itofl( ecrcond( E ) );
    fl = flsqrt( fl );
    dh1 = 1.0 / fltoCfl( fl );
    k = 0;

    dh2 = dh1;
    dh3 = dh4 = 0;
    dist = dh1 * 0.1;
    
    *C = 0;

    while( k < 10 )
    {
        k++;
        dh1 -= dist;
        dh2 += dist;
 
        if( ( ( A = ecrfelser( E, A, dh1, &dh3 ) ) == NULL )
        ||  ( ( A = ecrfelser( E, A, dh2, &dh4 ) ) == NULL ) )
        {
             return( NULL );
        }

        if( ( fabs( dh3 ) > 0.00001 ) && ( fabs( dh4 ) > 0.00001 ) )
        {
            dh3 /= dh4;
 
            if( dh3 < -0.25 )
            {
                /* Vorzeichenwechsel.  */
     
                *C = -1;
                return( A );
            }
            if( dh3 > 0.25 )
            {
                /* Kein Vorzeichenwechsel.  */
     
                *C = 1;
                return( A );
            }
        }
    }
    
    return( A );
}

static ec_copy( E, F )
list E, F;
{
    list L;

    init( L );
    bind( E, F );

    L = lfirst ( F );
    leset( E, 1, L );

    L = lsecond( F );
    leset( E, 2, L );

    L = lthird ( F );
    leset( E, 3, L );

    L = lfourth( F );
    leset( E, 4, L );

    return( 0 );
}

/*c
			ecrsigncbc( E )

	"elliptic curve over rational numbers, sign of the functional 
	equation, computed by the conductor"
	Quellbibliothek: srclib.ec2
	Include-Datei:   _ec2.h
	static single ecrsigns( E )  list E;   
	C = ecrsigns( E );
	Dabei ist E eine Liste mit allen wichtigen Daten der 
        elliptischen Kurve E/Q (siehe 'ecrinit').
        ecrsigncbc ist static zu ecrsigns.
        Rueckgabe: C, falls das Vorzeichen C der Funktionalgleichung
                      von E erfolgreich berechnet werden kann,
	           0  sonst.
c*/
/*H
	Version 1	10.12.1992	Josef Gebel
H*/
/*cS
	ecrsigncbc ruft auf: eciminmrtmp, ecrfcond
        Macros: lfirst, lred2, lsecond

Sc*/

static ecrsigncbc( E )
list E;
{
    list L;
    single C;

    bind( E );
    init( L );

    L = ecrfcond( E );
    C = -1;
    
    /*  Falls E nirgendwo additive Reduktion hat, dann berechnet  */
    /*  sich das Vorzeichen C = (-1)^(n+1), wobei n die Anzahl    */
    /*  der Primzahlen ist, bzgl. derer E verzweigt               */
    /*  multiplikative Reduktion hat.                             */

    while( L != _0 )
    {
        if( lsecond( L ) > 1 )
        {
            /*   E hat additive Reduktion bei p = lfirst( L ).   */
            return( 0 );
        }
        else
        {
            /*  Multiplikative Reduktion bei p = lfirst( L ).    */
            /*  eciminmrtmp berechnet Verhalten der multipl.      */
            /*  Reduktion (zerfallend oder nicht-zerfallend)      */
  
            C *= ( (-1) * eciminmrtmp( E, lfirst( L ) ) );
        }
        L = lred2( L );
    }
    return( C );
}

single *fourier_s( E, A, C )
list   E;
single *A, *C;
{
    single   i, k, flag, step;
    double   c1, c2, c3, d1, d2, d3, dh, dz, r1, r2, r3, s1, s2, LS_TOL2s;
    int      N;
    list     L;
    floating fl;
    single   *ecrclser(), *ecrfelser();
    double   fltoCfl();

    bind( E );
    init( L, fl );

    /*  Seien N der Fuehrer von E und sei C das Vorzeichen    */
    /*  von E. Die Fourier-Reihe F(t) ist definiert durch     */
    /*  die Summe ueber alle Terme der Form                   */
    /*                 a_n * exp(2 * Pi * i * n * t)          */
    /*  fuer n = 1 bis Unendlich. F(t) genuegt einer          */
    /*  Funktionalgleichung                                   */
    /*         F(t) = -C * N * t^2 * F(-1/(t * N)).           */
    /*  Indem man in dieser Gleichung  t = (i / sqrt(N))      */
    /*  einsetzt erhaelt man die Identitaet                   */
    /*         F(i / sqrt(N)) = C * F(i / sqrt(N)).           */
    /*  Falls nun die Auswertung von F(i / sqrt(N)) != 0      */
    /*  ist, so ist C = 1. Ansosten untersucht man            */
    /*      f(t) := F(i * t) an der Stelle t0 = 1 / sqrt(N)   */
    /*  auf Vorzeichenwechsel, indem man die Ableitung        */
    /*  f'(t0) betrachtet. Falls f'(t0) != 0 ist, liegt ein   */
    /*  Vorzeichenwechsel in t0 vor, sonst untersucht man     */
    /*  f(t) durch Auswerten der Fourierreihe in              */
    /*        t1 < t0 < t2 (t1, t2 "nahe bei t0");            */
    /*  auf Vorzeichenwechsel.                                */

    r1 = 0.0;
    r2 = 0.0;
    r3 = 0.0;
    dz = 0.0;

    k = 0;
    i = 50;

    flag = 8;
    step = 0;
    
    {
        int N;
        floating f1, f2, f3;

        init( N, f1, f2, f3 );

        N  = ecrcond( E );
        f1 = itofl( N );
        f2 = flsqrt( f1 );
    
        f1 = flPi();
        f1 = flprod( f1, itofl( -2 ) );
        f1 = flquot( f1, f2 );
        f3 = Cfltofl( 1.5 );
        f2 = flprod( f1, f3 );
        f3 = flquot( f1, f3 );

        fl = flexp( f1 );
        d1 = ( double ) fltoCfl( fl );
        fl = flexp( f2 );
        d2 = ( double ) fltoCfl( fl );
        fl = flexp( f3 );
        d3 = ( double ) fltoCfl( fl );
    }

    c1 = 1.0;
    c2 = 1.0;
    c3 = 1.0;

    LS_TOL2s = LS_TOL2 * 0.01;
 
    while( flag )
    {
        step += LS_STEP;
        if( ( A = ( single * ) ecrclser( E, A, step ) ) == NULL )
        {
            return( NULL );
        }
 
        while( k < step )
        {  
            k++;
            c1 *= d1;
            c2 *= d2;
            c3 *= d3;

            if( A[k] )
            {
                dh = ( double ) A[k];
                r3 += ( c1 * dh );
                dh /= ( ( double ) k );
                s1 = c1 * dh;
                s2 = ( c2 + c3 ) * dh;
                r1 += s1;       
                r2 += s2;       
                if( fabs( s2 ) < LS_TOL2s )
                {
                    i--;
		    if( !i )
		    {
			if( ( fabs( 1.0 - dz / r1 ) < LS_TOL2s )
                        ||  ( fabs( r1 ) < LS_TOL1 ) )
			{
		            /* Approximation ist gut genug   */
	                    flag--;
			    if( flag < 0 )
			    {
				flag = 0;
			    }
			}
			else
			{
			    flag = 8;
			}
		        i = 50;
			dz = r1;
		    }
	        }
            }
        }
    }
    
    r1 = fabs( 2.0 * r1 );       /**  r1 = L(E, 1) if C = 1  **/
    r2 = fabs( r1 - r2 );        /**  r2 =  0 if C = 1       **/
                                 /**     != 0 if C = -1      **/
    r3 = fabs( r3 );             /**  r3 = 0 if C = -1       **/


    if( ( r2 < 0.01 ) && ( r3 < 0.1 ) )
    {
        single *get_sign_s( );

        A = ( single * ) get_sign_s( E, A, C );
    }
    else if( r2 < 0.01 )
    {
        *C = 1;
    }
    else
    {
        *C = -1;
    }
 
    L = lfourth( E );
    leset( L, 4, list6( *C, ERROR, 0, 0, 0, fl ) );
    leset( E, 4, L );

    return( A );
}

/***********************************************************************/
/***                                                                 ***/
/***    s t a t i c   f u n c t i o n s               ( e n d )      ***/
/***                                                                 ***/
/***********************************************************************/

single *ecrsigns( E, A, C )                    
list E;
single *A, *C;
{
/******************************************************************************/
/***   If the conductor N is squarefree C = - \prod_{p | N} (-a_p).         ***/
/***   Otherwise:                                                           ***/
/***     The second part of the Birch and-Swinnerton-Dyer conjecture        ***/
/***     (see 'ecrmaninalg.) is verified under the assumption C = +1.       ***/
/***     The same is done under the assumption C = -1.                      ***/
/***     If the BSD-conjecture is fulfilled for C = +1 and not for C = -1:  ***/
/***       C := +1.                                                         ***/
/***     If the BSD-conjecture is fulfilled for C = -1 and not for C = +1:  ***/
/***       C := +1.                                                         ***/
/***     If the BSD-conjecture is fulfilled for both C = +1 and C = -1,     ***/
/***       C := +1: if the rank obtained under the assumption C = +1 is     ***/
/***                larger than the rank obtained under the assumption      ***/
/***                C = -1.                                                 ***/
/***       C := -1: otherwise.                                              ***/
/***     If the BSD-conjecture is not fulfilled for C = +1 nor C = -1:      ***/
/***     C is computed using the Fourier series.                            ***/
/******************************************************************************/

    if( lfourth( lfourth( E ) ) == _0 )
    {
        list     L;
        floating fl;
        double   fltoCfl();
    
        bind( E );
        init( L );
        init( fl );
    
        fl = Cfltofl( -1.0 );
        
        if( *C = ecrsigncbc( E ) )
	{
	    L = lfourth( E );

	    if( *C < 0 )
            {
                fl = 0;
            }
    
            leset( L, 4, list6( *C, ERROR, 0, 0, 0, fl ) );
            leset( E, 4, L );
            
        }
        else
        {
            /*  E hat additive Reduktion bzgl. (mindestens) einer     */
            /*  Primzahl p. Berechnung des Vorzeichens durch Aus-     */
            /*  wertung der Fourier-Entwicklung der L-Reihe.          */

            single s1, s2, r1, r2;
            list   F, G;

            init( F, G );

            F = lcopy( E );
	    L = lfourth( F );
            leset( L, 4, list6( 1, ERROR, 0, 0, 0, 0 ) );
            leset( F, 4, L );

            G = lcopy( E );
	    L = lfourth( G );
            leset( L, 4, list6( -1, ERROR, 0, 0, 0, 0 ) );
            leset( G, 4, L );

            if( ( A = ( single * ) ecrranks( F, A, &r1 ) ) == NULL ) 
            {
                return( NULL );
            }

            s1 = ecrordtsg( F ); 

            if( ( A = ( single * ) ecrranks( G, A, &r2 ) ) == NULL ) 
            {
                return( NULL );
            }
            s2 = ecrordtsg( G ); 
 
            if( ( s1 > 0 ) && ( s2 <= 0 ) )
            {
                /***   C = +1 does and C = -1 does not fit    ***/
                /***   into the B-SD conjecture ==>  C = +1   ***/
                G = _0;
            }
            else if( ( s2 > 0 ) && ( s1 <= 0 ) )
            {
                /***   C = -1 does and C = +1 does not fit    ***/
                /***   into the B-SD conjecture ==>  C = -1   ***/
                F = _0;
            }
            else if( ( s1 > 0 ) && ( s2 > 0 ) )
            {
                /***   C = +1 and C = -1 both fit into the    ***/
                /***   B-SD conjecture. Let r = max{r1, r2}.  ***/
                /***   ==> C = (-1)^r                         ***/
                
                if( r1 > r2 )
                {
                    G = _0;
                }
                else
                {
                    F = _0;
                }
            }
            else
            {
                /***   Neither C = +1 nor C = -1 do fit into  ***/
                /***   the B-SD conjecture. (==> There must   ***/
                /***   be an ERROR in the computation.)       ***/
                /***   Probably E/Q has positive rank and     ***/
                /***   (at least) one generator has Neron-    ***/
                /***   Tate height larger than _H_BOUND.      ***/
                /***   Compute C by the Fourier expansion:    ***/

                if( ( A = ( single * ) fourier_s( E, A, C ) ) == NULL )
                {
                    return( NULL );;
                }
 
                if( *C == 1 )
                {
                    /***   Fourier expansion ==> C = +1       ***/
                    G = _0;
                }
                else if( *C == -1 )
                {
                    /***   Fourier expansion ==> C = +1       ***/
                    F = _0;
                }
                else if( ( s1 < 0 ) && ( s2 == 0 ) )
                {
                    /***   C cannot be determined by Fourier  ***/
                    /***   expansion (convergence too bad)    ***/
                    /***   but C = -1 does not fit into B-SD  ***/
                    /***   conjecture whereas C = +1 could    ***/
                    /***   fit (height of point too large)    ***/
                    *C = 1;
                    G = _0;
                }
                else if( ( s2 < 0 ) && ( s1 == 0 ) )
                {
                    /***   C cannot be determined by Fourier  ***/
                    /***   expansion (convergence too bad)    ***/
                    /***   but C = +1 does not fit into B-SD  ***/
                    /***   conjecture whereas C = -1 could    ***/
                    /***   fit (height of point too large)    ***/
                    *C = -1;
                    F = _0;
                }
                else 
                {
                    /***   C cannot be determined by Fourier  ***/
                    /***   expansion (convergence too bad)    ***/
                    /***   nor do C = +/- 1 fit into B-SD     ***/
                    /***   conjecture: C cannot be computed.  ***/
                    return( A );
                }
            }

            if( F == _0 )
            {
                ec_copy( E, G );
            }
            else if( G == _0 )
            {
                ec_copy( E, F );
            }
        }
    }   

    *C = lfirst( lfourth( lfourth( E ) ) );

    return( A );
}
