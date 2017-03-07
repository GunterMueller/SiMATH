/*M
.SH NAME
ecrlserhdlc - elliptic curve over the rationals, L-series, higher derivative, large conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrlserhdlc(E, A, s, result)
list E;  
single *A, s;  
double *result;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.                                                    
.TP 4
.B A
points on an array of singles, containing the coefficients (say a_n) of the L-series of the curve E/Q (s.ecrclser).
.TP 4
.B s
is an integer number, s > 0.
.PP
ecrlserhdlc computes (approximates) the s-th derivation of the L-series of E/Q at the spot 1 and writes the result to *result. L^s(E, 1) is the sum over the terms
.IP
2 * Pi * a_n * I_n, where I_n =
.PP
  oo        s-1                  
 (    log(y)         -2*Pi*n*y / sqrt(N)
  \  ----------- * e                     dy
   )      y
  1        
.PP
for n = 1 ... infinity, whereat N denotes the conductor of the curve E.
.PP
ecrlserhdlc returns the pointer A by success or NULL in case of an error ocured.

.SH CAUTION
ecrlserhdlc works only for C = (-1)^s, where C denotes the sign of the L-series of E/Q.

.SH NOTES
ecrlserhdlc should be used only for large conductors     (N > 10^6), for small conductors, it is better to use ecrlserhdsc.

.SH SEE ALSO
 ecrinit
 ecrclser
 ecrlserhdsc
 Literature: J.E. Cremona: 
             Algorithms for modular elliptic curves,
             Cambridge University Press, 1992.    

M*/

/*H
	Version 1	19.04.1993	Josef Gebel
	Version 2	09.09.1993	Aenderung der Abbruchbedingung.  JG
   DATE ecrlserhdlc   : 930531.931130
H*/

#include <_ec2.h> 

#define EL       12
#define LS_TOL22   0.0001 

      /***    ZETA_k ist die floating-Darstellung von Zeta( k )   ***/
#define ZETA_2 list6( -4,  736492441, 575470521, 319279876, 692492681, 1 )
#define ZETA_3 list6( -4,  211779554, 937227974, 805708035, 216956947, 1 )
#define ZETA_4 list6( -4,  937106116, 378717328, 131614715,  88393899, 1 )
#define ZETA_5 list6( -4,  232918021 , 41325622, 175951361,  39650875, 1 )
#define ZETA_6 list6( -4, 1072500131, 120581786,   9585923,  18621971, 1 )
#define ZETA_7 list6( -4, 1027855495, 642840475, 349124868,   8964968, 1 )
#define ZETA_8 list6( -4,  452048479, 556536313, 946050816,   4378027, 1 )

#define EULER_C list6( -5, 151496762, 112012810, 557782057, 937102464, 619780600 )
      /***   floating-Darstellung der Eulerschen Konstanten ***/

/*******************  Externe Variable  ******************************/
double zN, T;
single FLAG;
/*********************************************************************/

static single romberglc(single,double*,single*);
static floating G_r_func(single,single,floating,list*,single*);
static floating P_1_func(floating);
static floating P_2_func(floating);
static floating P_3_func(floating);
static floating P_4_func(floating);
static floating P_5_func(floating);
static floating P_6_func(floating);
static floating P_7_func(floating);

single *ecrlserhdlc( E, A, r, res )
list E;
single *A, r;
double *res;
{
    single i, k, m, n, j = 50, flag, ixv[ EL ];
    double dtol1, dh, summand, ev[ EL ];
    floating z;
    int N;

    extern double zN, T;
    extern single FLAG;

    double fltoCfl( );

    bind( E );

    init( N );
    init( z );
    
    *res = 0.0;
    dh = 0.0;
    flag = 5;
    k = n = 0;
    
    N = ecrcond( E );
    
    z = fllog( itofl( N ) );   
    T = fltoCfl( z );
    T /= 2.0;
    T += 25;

    z = flsqrt( itofl( N ) );   
    z = flquot( flPi( ), z );  
    z = flsum ( z, z );          /*   -  z = zN = 2 Pi /  ___        */
    zN = fltoCfl( z );           /*                   / \/ N         */
    
    T /= zN;
    m = ( single ) floor( 2.5 /  ( r * zN) ); 
    if( m < 100 ) 
    {
	m = 100;
    }

    zN *= (-1.0);

    if( k < m )
    {
	single lJ;
        floating f, g, h, x, tol1, tol2;
	list LJ;

        init( f, g, h, x, tol1, tol2 );
        init( LJ );
    
        lJ = 0;
        LJ = _0;

        g = 0;
        x = 0;
    
	dtol1 = LS_TOL1 / ( 2.0 * r );
        tol1 = Cfltofl( dtol1 );
        tol2 = Cfltofl( LS_TOL2 );
        
        while( flag  && ( k < m ) ) 
        {
            k++;
	    x = flsum( x, z );
    
            if( k > n )
            {  
                n += LS_STEP;
                A = ecrclser( E, A, n );
                if( A == NULL )
                {
                    return( NULL );
                }
            }
    
            if( *( A + k ) )      
            {
	        if( ( h = G_r_func( r, k, x, &LJ, &lJ ) ) == ERROR )
	        {
	            *res = fltoCfl( g );
	            m = ifactl( r );
	            *res *= ( 2.0 * m );
	            return( NULL );
	        }
                h = flprod( h, itofl( A[k] ) );
                h = flquot( h, itofl( k ) );
                g = flsum ( g, h );
                if( flcomp( flabs( h ), tol1 ) < 0 )
                {
                    j--;
                    if( !j )
                    {
                        h = flquot( f, g );
                        f = flabs( fldif( itofl( 1 ), h ) );
		        if( ( flcomp( f, tol2 ) < 0 )
                        ||  ( flcomp( flabs( g ), tol1 ) < 0 ) )
                        {
                            /* Approximation ist gut genug        */
			    flag--;
			    if( flag < 0 )
			    {
                               flag = 0;
			    }
                        }
		        else
		        {
			    flag = 5;
		        }
			f = g;
                        j = 50;
                    }
                }
            }
        }
	*res = fltoCfl( g );
	m = ifactl( r - 1 );
	*res *= ( double ) m;
    }

    FLAG = 1;
    while( flag )
    {
        i = 0;
        while( i < EL )
        {
            k++;
            if( k > n )
            {  
                n += LS_STEP;
                A = ecrclser( E, A, n );
		if ( A == NULL )
		{
		    return( NULL );
		}
            }
            if( *( A + k ) )      
            {
	        *( ixv + i ) = k;
                i++;
            }
        }

	if( romberglc( r, ev, ixv ) == ERROR )
	{
           *res *= ( 2 * r );
	   return( NULL );
	}

        for( i = 0; i < EL; i++ )
        {
            *( ev + i ) *= ( *( A + *( ixv + i ) ) / (double) *(ixv + i ) );
            *res        += *( ev + i );
            if( fabs( *( ev + i ) ) < LS_TOL1 ) 
            {
                j--;
                if( !j )
                {
		    if( ( fabs( 1.0 - dh / *res ) < LS_TOL22 ) 
		    ||  ( fabs( *res ) < dtol1 ) )
                    {
                        /* Approximation ist gut genug        */
			flag--;
			if( flag < 0 )
			{
                           flag = 0;
			}
                    }
		    else
		    {
			flag = 5;
		    }
                    dh = *res;
                    j = 50;
                }
            }
        }
    }

    *res *= ( 2 * r );
    return( A );
}
/***************   Ende von   e c r l s e r h d l c   ******************/

/*c
         	romberglc( r, ergv, indexv )
	
	"romberg, large conductor"
        static single romberglc( r, ergv, indexv )
            single r, indexv[ EL ]; double ergv[ EL ];
	static Modul zu ecrlserhdlc.
        t = romberglc( r, ergv, indexv );
	romberglc berechnet ( approximiert ) mit dem Romberg'schen
	Integrationsverfahren die Integrale
             T
	    (     /   r-1          \     - x * y
             \   | log ( y )  / y  | * e          dy
              )   \                /
             1
        fuer y = indexv[ k ], 0 <= k < EL.
	Die Ergebnisse werden in *ergv abgelegt.
	Rueckgabe: 0 bei Erfolg, ERROR sonst.
c*/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static single romberglc( r, ergv, indexv )
single r, *indexv;
double *ergv;
{
    double erg1v[EL], erg2v[EL], integv[EL], *feld, integ, mul, zNn,
	   d1, d2, d3, arg, og, T0, h1, h2, h3, h4, tol;
    single i , j, k, l, n, a1, a2, a3, K, M, diffv[EL], flag;

    extern single FLAG;
    extern double zN, T;
  
    K = 105;         /*****  105 = 10 * 11 / 2   *****/
    tol = LS_TOL1 / 1000000.0;
    
    if( ( feld = ( double * ) calloc( EL * K, sizeof( double ) ) ) == NULL )
    {
        return( ERROR );
    }
        
    diffv[0] = 0;
    for( i = 1; i < EL; i++ )
    {
        diffv[i] = indexv[i] - indexv[i - 1];
    }

    feld = ( double * ) calloc( EL * K, sizeof( double ) );
    zNn = zN * indexv[0];               /*      2 Pi n    */
                                        /*  -  --------   */
    M = 4;                              /*       \/ N     */

    T0 = T / ( double ) *indexv;

    h3 = T0 / 8000000.0;       /*   Laenge des Integrations-Int.    */
    for( i = 1; i < r; i++ )
    {
	h3 *= 6;
    }
    og = 1.0 + h3;           /*   Obergrenze des Integrations-Int.    */
    h1 = h3 / ( double ) M;  /*   aktuelle Schrittweite               */
    h2 = 0.5 * h1;           /*   halbe Schrittweite                  */
    d3 = 0.0;
   
    /*    Berechnung von a_00 = a( h ) =                             */
    /*       N-1                                                     */
    /*     / ---                                                     */
    /*    |  \                      1                     \          */
    /*    |  /    f( a + h * j ) + --- ( f( b ) - f( a ) ) | * h     */
    /*     \'---                    2                     /          */
    /*       i=0                                                     */
    /*   mit den Intervallgrenzen a < b und Schrittweite h.          */
    
    arg = 1.0;   /*   Aktuelles Argument des Integranden f  */
		 /*   (am Anfang: arg = untere Grenze = 1)  */
		 /*   Wegen f( 1 ) = 0 braucht dieser Wert  */
		 /*   nicht ausgewetret zu werden.          */
    for( l = 0; l < EL; l++ )
    {
        integv[l] = 0;
    }
    
    j = M;
    while( j )
    {
        j--;
        arg += h1;

	d1 = 1.0 / arg;
	d2 = log( arg );
	k = r - 1;
	while( k )
	{
	    if( k & 01 )
	    {
		d1 *= d2;
	    }
	    k >>= 1;
            if( !k )
            {
		break;
            }
	    d2 *= d2;
	}
	/*   d1 = log(arg)^(r-1) / arg   */
    
        integ = d1 * h1 * exp( zNn * arg );
        mul = exp( zN * arg );        /*  __   */
	/*   mul = e^( - 2 * Pi * arg / \/N  ) */

        for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
	    if( j ) 
	    {
                integv[l] += integ;
	    }
	    else
	    {
		integv[l] += ( integ * 0.5 );
	    }
        }
    }
    
    for( l = 0; l < EL; l++ )
    {
        feld[l] = integv[l];
    }

    i = 0;
    while( 1 )
    {
        i++;
        for( l = 0; l < EL; l++ )
	{
            erg1v[l] = 0;
	}
        arg = 1.0 - h2;

        j = M;
        while( j )
        {
            j--;
            arg += h1;
    
	    d1 = 1.0 / arg;
	    d2 = log( arg );
	    k = r - 1;
	    while( k )
	    {
	        if( k & 01 )
	        {
		    d1 *= d2;
	        }
	        k >>= 1;
		if( !k )
		{
		    break;
		}
	        d2 *= d2;
	    }
	    /*   d1 = log(arg)^(r-1) / arg   */
        
            integ = d1 * h1 * exp( zNn * arg );
            mul = exp( zN * arg );        /*  __   */
	    /*   mul = e^( - 2 * Pi * arg / \/N  ) */
    
            for( l = 0; l < EL; l++ )
            {
                for( n = 0; n < diffv[l]; n++ )
	        {
                    integ *= mul;
	        }
                erg1v[l] += integ;
            }
        }
        
	a1 = EL * ( ( i * ( i + 1 ) ) >> 1 );
        
	if( a1 >= K )
        {
            K += i;
            feld = ( double * ) realloc( feld, K * EL * sizeof( double ) );
        }
        
	for( l = 0; l < EL; l++ )
        {
            integv[l] = ( integv[l] + erg1v[l] ) * 0.5;
            feld[a1] = integv[l];
	    a1++;
        }
  
        M <<= 1;
        h1 *= 0.5;
        h2 *= 0.5;

        h3 = 1.0;
    
        for( k = 0; k < i; k++ )
        {
            h3 *= 4.0;
	    h4 = 1.0 / ( h3 - 1.0 );
            a1 = EL * ( ( ( i * ( i - 1 ) ) >> 1 ) + k );
            a2 = a1 + EL * i;
            a3 = a2 + EL;
            
	    for( l = 0; l < EL; l++ )
            {
                ergv[l] = feld[a2] + ( feld[a2] - feld[a1] ) * h4;
                feld[a3] = ergv[l];
		a1++;
		a2++;
		a3++;
            }
            
	    a1 = EL * ( ( ( i - 1 ) * ( i + 2 ) ) >> 1 );
        }
        
	d2 = fabs( ergv[0] - feld[a1] );
	if( ( d2 < d3 ) && ( d2 < tol ) ||  ( i == 20 ) )
        {
            break;
	}
	d3 = d2;
    }
    
    if( FLAG )                /* Falls i > 1 ist, muss auch das   */
    {                         /* 2. Teilintegral berechnet werden */
    
        i = 0;
        M = 4;
        arg = og;
        d3 = 0.0;

        h3  = T0 - og;           /*   Laenge des Integrations-        */
	                         /*   Intervalls                      */
        h1  = h3 / ( double ) M;  /*   aktuelle Schrittweite           */
        h2  = 0.5 * h1;          /*   halbe Schrittweite              */

	d1 = 1.0 / og;
	d2 = log( og );
	k = r - 1;
	while( k )
	{
	    if( k & 01 )
	    {
		d1 *= d2;
	    }
	    d2 *= d2;
	    k >>= 1;
	}
	/*   d1 = log(og)^(r-1) / og   */
    
        integ = d1 * h2 * exp( zNn * og );
        mul = exp( zN * og );        /*  __   */
	/*   mul = e^( - 2 * Pi * og / \/N  ) */

	for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
            integv[l] = integ;
        }
        
	d1 = 1.0 / T0;
	d2 = log( T0 );
	k = r - 1;
	while( k )
	{
	    if( k & 01 )
	    {
		d1 *= d2;
	    }
	    d2 *= d2;
	    k >>= 1;
	}
	/*   d1 = log(T0)^(r-1) / T0   */
    
        integ = d1 * h2 * exp( zNn * T0 );
        mul = exp( zN * T0 );        /*  __   */
	/*   mul = e^( - 2 * Pi * T0 / \/N  ) */

	for( l = 0; l < EL; l++ )
        {
            for( n = 0; n < diffv[l]; n++ )
	    {
                integ *= mul;
	    }
            integv[l] += integ;
        }
	/*   integv[] = 1/2 * [ f(a) + f(b) ]   */

	j = M - 1;
        while( j )
        {
            j--;
            arg += h1;
            
	    d1 = 1.0 / arg;
	    d2 = log( arg );
	    k = r - 1;
	    while( k )
	    {
	        if( k & 01 )
	        {
		    d1 *= d2;
	        }
	        d2 *= d2;
	        k >>= 1;
	    }
	    /*   d1 = log(arg)^(r-1) / arg   */
        
            integ = d1 * h1 * exp( zNn * arg );
            mul = exp( zN * arg );        /*  __   */
	    /*   mul = e^( - 2 * Pi * arg / \/N  ) */
    
            for( l = 0; l < EL; l++ )
            {
                for( n = 0; n < diffv[l]; n++ )
	        {
                    integ *= mul;
	        }
                integv[l] += integ;
            }
        }
        for( l = 0; l < EL; l++ )
        {
            feld[l] = integv[l];
        }
  
        while( 1 )
        {
            i++;
            for( l = 0; l < EL; l++ )
	    {
                erg1v[l] = 0;
	    }
            arg = og - h2;
  
            for( j = 1; j <= M; j++ )
            {
                arg += h1;
                
	        d1 = 1.0 / arg;
	        d2 = log( arg );
	        k = r - 1;
	        while( k )
	        {
	            if( k & 01 )
	            {
		        d1 *= d2;
	            }
	            d2 *= d2;
	            k >>= 1;
	        }
	        /*   d1 = log(arg)^(r-1) / arg   */
        
                integ = d1 * h1 * exp( zNn * arg );
                mul = exp( zN * arg );        /*  __   */
	        /*   mul = e^( - 2 * Pi * arg / \/N  ) */
        
                for( l = 0; l < EL; l++ )
                {
                    for( n = 0; n < diffv[l]; n++ )
	            {
                        integ *= mul;
	            }
	            erg1v[l] += integ;
                }
            }
            
	    a1 = EL * ( ( i * ( i + 1 ) ) >> 1 );
            
	    for( l = 0; l < EL; l++ )
            {
	        integv[l] = ( integv[l] + erg1v[l] ) * 0.5;
	        feld[a1]  = integv[l];
		a1++;
            }
  
            M <<= 1;
            h1 *= 0.5;
            h2 *= 0.5;
            h3 = 1.0;
  
            for( k = 0; k < i; k++ )
            {
                h3 *= 4.0;
	        h4 = 1.0 / ( h3 - 1.0 );
                a1 = EL * ( ( ( i * ( i - 1 ) ) >> 1 ) + k );
                a2 = a1 + EL * i;
                a3 = a2 + EL;

                for( l = 0; l < EL; l++ )
                {
	            erg2v[l] = feld[a2] + ( feld[a2] - feld[a1] ) * h4;
	            feld[a3] = erg2v[l];
		    a1++;
		    a2++;
		    a3++;
                }
                a1 = EL * ( ( i - 1 ) * ( i + 2 ) >> 1 );
            }
	    d2 = fabs( erg2v[0] - feld[a1] );
	    if( ( d2 < d3 ) && ( d2 < tol ) ||  ( i == 20 ) )
            {
	        if( i == 2 )
	        {
	            FLAG = 0;
	        }
                break;
	    }
	    d3 = d2;

        }
        for( l = 0; l < EL; l++ )
        {
            ergv[l] += erg2v[l];
	}
    }

    free( feld );
    return( 0 );
}
/******************   Ende von   r o m b e r g l c   *******************/

/*c
                 G_r_func( r, k, x, LJ, lJ )

	"function G( r, x )
        static floating G_r_func( k, x, LJ, lJ )
            single k, *lJ; floating x; list *LJ;
        f = G_r_func( k, x, LJ, lJ );
	G_r_func approximiert den Wert der Funktion       
	                          ._oo_        n
                                  \     ( -x )
         G( r, x ) = P( r, x ) +  /   ----------- ,
                                 '---   n^r * n!
	                         n = 1
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating G_r_func( r, k, x, LJ, lJ )
single r, k, *lJ;
floating x;
list *LJ;
{
    single j;
    int i;
    floating f, g, y, z;
    list Lptr;

    bind( x );
    bind( *LJ );
    
    init( f, g, y, z );
    init( i );
    init( Lptr );

    f = flprod( x, list2( 0, 6 ) );
    i = flfloor( f );
    if( issingle( i ) )
    {
	if( i < 100 )
	{
	    i = 100;
	}
    }
    else
    {
	i = 1073741823;
    }

    z = flneg( x );
    y = z;
    g = z;
    j = 2;

    Lptr = *LJ;

    while( j < i )
    {
	f = getJr( r, j, LJ, &Lptr, lJ );
	j++;

	y = flprod( y, z );
	f = flprod( y, f );
	g = flsum ( g, f );
    }

    switch( r )
    {
	case  1: y = P_1_func( x );
		 break;
	case  2: y = P_2_func( x );
		 break;
	case  3: y = P_3_func( x );
		 break;
	case  4: y = P_4_func( x );
		 break;
	case  5: y = P_5_func( x );
		 break;
	case  6: y = P_6_func( x );
		 break;
	case  7: y = P_7_func( x );
		 break;
	default: printf(" %d. derivative not yet", r );
	         printf(" implemented\n");
		 break;
    }

    if( r % 2 )
    {
        g = fldif( y, g );
    }
    else
    {
        g = flsum( g, y );
    }

    return( g );
}

/*****************   Ende von  G _ r _ f u n c *****************/

/*c
                 getJr( r, j, LJ, Lptr, lJ )

        static floating getJr( r, j, LJ, Lptr, lJ )
            single r, j, *lJ; list *LJ, *Lptr;
        f = getJr( r, j, LJ, Lptr, lJ )
	                        1
	Rueckgabe: g( j ) = ----------
	                     j^r * j!     
        Falls g( j ) noch nicht in *LJ abgespeichert ist, so wird es
	berechnet und dort gespeichert.
	Lptr zeigt anschliessend auf das Element der Liste *LJ,
	das g( j+1 ) enthaelt.
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

floating getJr( r, j, LJ, Lptr, lJ )
single r, j, *lJ;
list *LJ, *Lptr;
{
    floating f;
    
    bind( *LJ, *Lptr );
    init( f );
    
    if( j < *lJ )
    {
	f  = lfirst( *Lptr );
	*Lptr = lred( *Lptr );
    }
    else if( j == *lJ )
    {
	f  = lfirst( *Lptr );
    }
    else
    {
        floating g;
	single k;

        init( g );
	k = r;
            
	*lJ = j;
   
	if( j == 2 )
	{
	    k++;
	    g = rtofl( list2( list1( 1 ), list1( 2 ) ) );  /* 1/2 */
	    f = itofl( 1 );
	    
	    while( 1 )
	    {
		if( k & 01 )
		{
		    f = flprod( f, g );
		}
		k >>= 1;
		if( !k )
		{
		    break;
		}
		g = flprod( g, g );
	    }
        }
	else
	{
	    g = itofl( j );
	    g = flquot( itofl( j - 1 ), g );
	    f = itofl( 1 );
	    while( 1 )
	    {
		if( k & 01 )
		{
		    f = flprod( f, g );
		}
		k >>= 1;
		if( !k )
		{
		    break;
		}
		g = flprod( g, g );
	    }

	    f = flquot( f, itofl( j ) );
	    f = flprod( f, lfirst( *Lptr ) );
        }
	
	*Lptr = list1( f );
	*LJ = linv( *LJ );
	*LJ = lcomp( f, *LJ );
	*LJ = linv( *LJ );
    }
    return( f );
}
/********************   Ende von  g e t J r   ******************/

/*c
                 P_1_func( x )

        static floating P_1_func( x ) floating x;
        f = P_1_func( x )
	Rueckgabe: P1( x ) = log( 1/x ) - gamma,
        wobei gamma = 0.5772... die Eulersche Konstante ist. 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_1_func( x )
floating x;
{
    floating f;

    init( f );
    bind( x );

    f = fllog( x );
    f = flsum( f, EULER_C );
    f = flneg( f );

    return( f );
}

/**************   Ende von  P _ 1 _ f u n c   *****************/

/*c
                 P_2_func( x )

        static floating P_2_func( x ) floating x;
        f = P_2_func( x )
	Rueckgabe: P2( x ) = Q2( t ) = ( t^2 + Z(2) ) / 2
	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772...
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_2_func( x )
floating x;
{
    floating f;

    init( f );
    bind( x );

    f = fllog ( x );
    f = flsum ( f, EULER_C );
    f = flprod( f, f );
    f = flsum ( f, ZETA_2 );
    f = flquot( f, list2( 0, 2 ) );

    return( f );
}

/**************   Ende von  P _ 2 _ f u n c   *****************/

/*c
                 P_3_func( x )

        static floating P_3_func( x ) floating x;
        f = P_3_func( x )
                                       t^3   Z(2)       Z(3) 
	Rueckgabe: P3( x ) = Q3( t ) = --- + ---- * t - ----
                                        6     2          3
	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772...
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_3_func( x )
floating x;
{
    floating f, g, h;

    init( f, g, h );
    bind( x );

    f = fllog( x );
    f = flsum( f, EULER_C );
    
    g = flprod( f, f );
    h = ZETA_2;
    h = flprod( h, list2( 0, 3 ) );
    g = flsum ( g, h );
    g = flprod( g, f );
    g = flsum ( g, ZETA_3 );
    g = flsum ( g, ZETA_3 );
    g = flquot( g, list2( 0, 6 ));

    return( flneg( g ) );
}

/**************   Ende von  P _ 3 _ f u n c   *****************/

/*c
                 P_4_func( x )

        static floating P_4_func( x ) floating x;
        f = P_4_func( x )
	Rueckgabe: P4( x ) = Q4( t ) = 
	  t^4   Z(2)         Z(3)       2*Z(4)+Z(2)^2
	  --- + ---- * t^2 - ---- * t + -------------   
	   24    4            3               8  
	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772...
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_4_func( x )
floating x;
{
    floating f, g, h, k;

    init( f, g, h, k );
    bind( x );

    k = fllog( x );
    f = flneg ( flsum( k, EULER_C ) );
    
    h = ZETA_2;

    g = flprod( f, f );
    k = flprod( h, list2( 0, 6 ) );
    g = flsum ( g, k );
    g = flprod ( g, f );

    k = ZETA_3;
    k = flprod( k, list2( 0, 8 ) );
    g = fldif  ( g, k );
    g = flprod ( g, f );
    
    k = flprod( h, h );
    k = flprod( k, list2( 0, 3 ) );
    g = flsum ( g, k );

    h = ZETA_4;
    k = flprod( h, list2( 0, 6 ) );
    g = flsum  ( g, k );
    
    g = flquot( g, list2( 0, 24 ) );
        
    return( g );
}

/**************   Ende von  P _ 4 _ f u n c   *****************/

/*c
                 P_5_func( x )

        static floating P_5_func( x ) floating x;
        f = P_5_func( x )
	Rueckgabe: P5( x ) = Q5( t ) = 
	  t^5   Z(2)         Z(3)         2*Z(4)+Z(2)^2
	  --- + ---- * t^3 - ---- * t^2 + ------------- * t  
	  120    12            6                 8  

               Z(5)   Z(3)*Z(2)
             - ---- - ---------
                5         6   
	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772...
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_5_func( x )
floating x;
{
    floating f, g, h, v, w;

    init( f, g, h, v, w );
    bind( x );

    v = fllog( x );
    f = flneg ( flsum( v, EULER_C ) );
    
    h = ZETA_2;
    v = ZETA_3;
     
    g = flprod( f, f );
    g = flquot( g, list2( 0, 5 ) );
    w = flprod( h, list2( 0, 2 ) );
    g = flsum ( g, w );
    g = flprod( g, f );
    w = flprod( v, list2( 0, 4 ) );
    g = fldif ( g, w );
    g = flprod( g, f );

    w = ZETA_4;
    w = flprod( v, list2( 0, 6 ) );
    g = flsum ( g, w );
    w = flprod( h, h );
    w = flprod( w, list2( 0, 3 ) );
    g = flsum ( g, w );
    g = flprod( g, f );

    v = flprod( h, v );
    v = flprod( v, list2( 0, 4 ) );
    g = fldif ( g, v );
    g = flquot( g, list2( 0, 24 ) );

    w = ZETA_5;
    w = flquot( w, list2( 0, 5 ) );
    g = fldif ( g, w );
 
    return( g );
}

/**************   Ende von  P _ 5 _ f u n c   *****************/

/*c
                 P_6_func( x )

        static floating P_6_func( x ) floating x;
        f = P_6_func( x )
	Rueckgabe: P6( x ) = Q6( t ) = 
	  t^6   Z(2)*t^4   Z(3)*t^3   [2*Z(4)+Z(2)^2]*t^2 
	  --- + -------- - -------- + ------------------- 
	  720      48         18              16  

            Z(5)   Z(3)*Z(2)      Z(6)   Z(4)*Z(2)   Z(3)^2    Z(2)^3
         - [---- + ---------]*t + ---- + --------- + ------  + ------ 
             5         6           6         8        18         48
	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772...
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_6_func( x )
floating x;
{
    floating f, g, h, u, v, w;

    bind( x );
    init( f, g, h, u, v, w );

    h = fllog( x );
    f = flneg( flsum( h, EULER_C ) );

    u = ZETA_2;
    v = ZETA_3;
 
    g = flprod( f, f );
    g = flquot( g, list2( 0, 5 ) );

    h = flprod( u, list2( 0, 3 ) );
    g = flsum ( g, h );
    g = flprod( g, f );
    
    h = flprod( v, list2( 0, 8 ) );
    g = fldif ( g, h );
    g = flprod( g, f );

    h = ZETA_4;
    h = flprod( h, list2( 0, 18 ) );
    g = flsum ( g, h );
    w = flprod( u, u );
    h = flprod( w, list2( 0, 9 ) );
    g = flsum ( g, h );
    g = flprod( g, f );

    h = ZETA_5;
    h = flprod( h, list2( 0, 144 ) );
    h = flquot( h, list2( 0, 5 ) );
    g = fldif ( g, h );
    h = flprod( u, v );
    h = flprod( h, list2( 0, 24 ) );
    g = fldif ( g, h );
    g = flprod( g, f );

    h = ZETA_6;
    h = flprod( h, list2( 0, 24 ) );
    g = flsum ( g, h );
    h = ZETA_4;
    h = flprod( h, list2( 0, 6 ) );
    h = flsum ( h, w );
    h = flprod( h, u );
    h = flprod( h, list2( 0, 3 ) );
    g = flsum ( g, h );
    h = flprod( v, v );
    h = flprod( h, list2( 0, 8 ) );
    g = flsum ( g, h );

    g = flquot( g, list2( 0, 144 ) );

    return( g );
}

/**************   Ende von  P _ 6 _ f u n c   *****************/

/*c
                 P_7_func( x )

        static floating P_7_func( x ) floating x;
        f = P_7_func( x )
	Rueckgabe:
	                       t^7   Z(2)         Z(3)
	  P7( x ) = Q7( t ) =  --- + ---- * t^5 - ---- * t^4
	                        7!   240           72 
	  
	            2*Z(4)+Z(2)^2          Z(5)   Z(3)*Z(2)     
	          + ------------- * t^3 - [---- + ---------] * t^2 
	                   48               10       12  

                     Z(6)   Z(4)*Z(2)   Z(3)^2    Z(2)^3
	         + [ ---- + --------- + ------  + ------ ] * t
	              6         8        18         48

                    Z(7)   Z(5)*Z(2)   Z(4)*Z(3)     Z(3)*Z(2)^2
	         - ---- - ---------- - ----------  - -----------
	             7        10          12             24

	mit t = log( 1/x ) - gamma, wobei gamma = 0.5772... 
	die Eulersche Konstante ist, und Z(x) = Zeta(x). 
*c/
/*H
	Version 1	19.04.1993	Josef Gebel
H*/

static floating P_7_func( x )
floating x;
{
    floating f, g, h, u, z2, z3, z4, z5;

    bind( x );
    init( f, g, h, u, z2, z3, z4, z5 );

    h = fllog( x );
    f = flneg ( flsum( h, EULER_C ) );

    z2 = ZETA_2;
    z3 = ZETA_3;
    z4 = ZETA_4;
    z5 = ZETA_5;
    
    g = flprod(  f,  f );
    g = flquot(  g, list2( 0, 7 ) );
    g = flsum (  g, z2 );
    g = flprod(  g,  f );

    h = flprod( z3, list2( 0, 10 ) );
    g = fldif (  g , h );
    g = flprod(  g,  f );

    u = flprod( z2, z2 );
    h = flsum (  h, z4 );
    h = flsum (  h, z4 );
    h = flprod(  h, list2( 0, 15 ) );
    g = flsum (  g , h );
    g = flprod(  g,  f );

    h = flprod( z5, list2( 0, 72 ) );
    g = fldif (  g , h );
    h = flprod( z2, z3 );
    h = flprod(  h, list2( 0, 60 ) );
    g = fldif (  g, h );
    g = flprod(  g,  f );
    
    h = ZETA_6;
    h = flprod(  h, list2( 0, 3 ) );
    h = flsum (  h, flprod( z3, z3 ) );
    h = flprod(  h, list2( 0, 40 ) );
    g = flsum (  g , h );
    h = flprod( z4, list2( 0, 6 ) );
    h = flsum (  h , u );
    h = flprod(  h, z2 );
    h = flprod(  h, list2( 0, 15 ) );
    g = flsum (  g , h );
    g = flprod(  g,  f );

    h = flsum (  u, z4 );
    h = flsum (  h, z4 );
    h = flprod(  h, z3 );
    h = flprod(  h, list2( 0, 30 ) );
    g = fldif (  g , h );
    h = flprod( z5, z2 );
    h = flprod(  h, list2( 0, 72 ) );
    g = fldif (  g , h );
    g = flquot(  g, list2( 0, 240 ) );
    h = ZETA_7;
    h = flquot(  h, list2( 0, 7 ) );
    g = fldif (  g , h );

    return( g );
}

/**************   Ende von  P _ 7 _ f u n c   *****************/
