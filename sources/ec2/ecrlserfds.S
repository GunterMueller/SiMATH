/*M
.SH NAME
ecrlserfds - elliptic curve over rational numbers, L-series, first derivative, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrlserfds(E, A, result)
list E;  
single *A;  
double *result;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B A
points on an array of singles, containing the coefficients (say a_n) of the L-series of the curve E/Q (s.ecrclser).
.PP 
ecrlserfds computes (approximates) the sum over the terms
.IP
a_n * exp(-2 * PI * n / sqrt(N) ) / n,
.PP
for n = 1 to infinity, where N denotes the conductor of the curve E/Q. ecrlserfds writes the result to *result and returns the pointer A or NULL in case of an error occured. 

M*/
               
/*H
	Version 1   	12.11.1992	Josef Gebel
	Version 2   	19.01.1993	Anpassung an neues Konzept. JG
	Version 3   	19.09.1993	Aenderung der Abbruchbedingung. JG
	Version 4   	02.05.1994	Aenderung der Subroutine 'dcfeintlser':
                                        fuer a <= 4 andere Berechnungsmethode.
                                        JG.
   DATE ecrlserfds    : 921130.930531.941201
H*/
/*cS
	ecrlserfds ruft auf: dcfeintlser, ecrclser, ecrcond,
		ecrlsers, ecrsign, exp, fabs, fltoCfl, log, sqrt
	Macros: itofl
Sc*/

#include <_ec2.h> 

#define PI2    6.283185307179586      /* 2 * PI */
#define Euler_Gamma 0.57721566490153286             

/***************************************************************************/
/***                                                                     ***/
/***                   s t a t i c   f u n c t i o n s                   ***/
/***                        ( B e g i n n i n g )                        ***/
/***                                                                     ***/
/***************************************************************************/

/*c
             dcfeintlser( a )

	"double continued fraction expansion, L- series"
	static double dcfeintlser( a )  double r;
	static-Modul zu ecrlserfds.
	d = dcrfeintlser( a );
c*/

#define MAXFRAC 10000000000000000.0

static double dcfeintlser( a )
double a;
{
    single i;
    double h1;

    if( a > 4 )
    {
        double p1 = 1.0, p2 = 0.0, q1 = 0.0, q2 = 1.0;

        i = 1;
    
        while (fabs(q2) < MAXFRAC)
        {
    
            /*  Berechnung von   p_(i+1), i ungerade.  */
            
            h1 = p2 * a + p1;
            p1 = p2;
            p2 = h1;
            
            /*  Berechnung von  q_(i+1), i ungerade.  */
            
            h1 = q2 * a + q1;
            q1 = q2;
            q2 = h1;
        
            /*  Berechnung von p_(i+1), i gerade.  */
        
            h1 = p2 / (double) i + p1;
            p1 = p2;
            p2 = h1;
        
            /*  Berechnung von  q_(i+1), i gerade.  */
        
            h1 = q2 / (double) i + q1;
            q1 = q2;
            q2 = h1;
        
            i++;
        }
        h1 = p2 / ( q2 * exp( a ) );
        return( h1 );
    }
    else
    {
        double fac, sum, x;
        single pm;

        fac = 1;
        sum = 0;
        pm  = 1;
        i   = 1;

        while( 1 )
        {
            fac *= a;
            x    = 1.0 / ( double ) i;
            fac *= x;
            if( pm )
            {
                sum += ( fac * x );
                pm = 0;
            }
            else
            {
                sum -= ( fac * x );
                pm = 1;
            }

            if( fac < 0.00000000000000000001 )
            {
                break;
            }
            i++;
        }
        sum -= log( a );
        sum -= Euler_Gamma;
        
        return( sum );
    }
}
/***************************************************************************/
/***                                                                     ***/
/***                   s t a t i c   f u n c t i o n s                   ***/
/***                              ( E n d )                              ***/
/***                                                                     ***/
/***************************************************************************/
/***                                                                     ***/
/***         B e g i n n i n g   o f   t h e   m a i n   p a r t         ***/
/***                                                                     ***/
/***************************************************************************/

single *ecrlserfds( E, A, res )
list E;
single *A;
double *res;
{
    floating flh;
    int N;
    double dh1, fltoCfl();
  
    bind( E );

    init( N );
    init( flh );

    N   = ecrcond( E );
    flh = itofl( N );
    dh1 = fltoCfl( flh );

    if( ecrsign( E ) == 1 )
    {
        if( ( A = ecrlsers( E, A, res ) ) == NULL )
	{
	    return( NULL );
	}
        *res *= ( log( dh1 ) * 0.5 );
    }
    else
    {
        single i, k, flag, step;
        double LS_TOL11, LS_TOL22, dh2, dh3, summand, isqrtN, dcfeintlser();
 
        LS_TOL11 = 10 * LS_TOL1;
        LS_TOL22 = 10 * LS_TOL2;

        k = 0; 
	i = 50;

	step = 0;
	flag = 5; 

        isqrtN = 1.0 / sqrt( dh1 );
        dh1 = 0.0;                     
        dh2 = PI2 * isqrtN;             

        while( flag )
        {
            step += LS_STEP;
            if( ( A = ecrclser( E, A, step ) ) == NULL )
	    {
	        return( NULL );
	    }

            while( k < step )
            {  
                k++;
                dh1 = dh1 + dh2;
                if( A[k] )
                {
                    summand = ( double ) A[k] 
			      * dcfeintlser( dh1 ) / ( double ) k;
                    *res += summand;       
		    if( fabs( summand ) < LS_TOL11 )
		    {
		        i--;
		        if( !i )
		        {
		            if( ( fabs( 1.0 - dh3 / *res ) < LS_TOL22 )
		            || ( fabs( *res ) < LS_TOL11 ) )
		            {
		                /* Approximation ist gut genug */
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
			    i = 50;
                            dh3 = *res;
                        }
                    }
	        }
            }
        }
        *res = *res * 2;
    }
    return( A );
}
