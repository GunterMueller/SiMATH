/*M
.SH NAME
ecrlsers - elliptic curve over rational numbers, L-series, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrlsers(E, A, result)  
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
points at a array of singles. The entries of the array are the coefficients a_n of the L-series of the elliptic curve E/Q (s.ecrclser).
.PP
Let N be the conductor of the curve E/Q and let 
.IP
b_n = exp(-2 * PI * n / sqrt(N)) /n.
.PP
ecrlsers computes (approximates) the sum of a_n * b_n for n = 1 to infinite.
The result will be written to *result.
ecrlsers returns a pointer at the array A, or NULL in case of an error occurs.

.SH SEE ALSO
 ecrinit 
 ecrclser

M*/
                
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	19.01.1993	Anpassung an neues Konzept. JG
	Version 3	19.09.1993	Aenderung der Abbruchsbed.  JG
	Version 4	11.07.1994	Aenderung als Folge der Aenderung von
                                        'ecrranks'(Ergebis kann eventuell schon
                                        aus der Liste E entnommen werden). JG.
	Version 5	12.02.1996     Aenderung des Zugriffs auf die 
                                       Liste E als Folge der Einfuehrung
                                       von 'ecrrank2d'. JG.
   DATE ecrlsers      : 921130.930531.941201.9512__.960201
H*/

#include <_ec2.h>

#define PI2    6.283185307179586      /*  2 * PI */

single *ecrlsers( E, A, res )
list E;
single *A;
double *res;
{
    single i;

    bind( E );

    if( ( A = ( single * ) ecrsigns( E, A, &i ) ) == NULL )
    {
        return( NULL );
    }

    *res = 0.0;

    if( i == 1 )
    {
        double LS_TOL11, LS_TOL22, fltoCfl();
                                
        LS_TOL11 = LS_TOL1 * 10;
        LS_TOL22 = LS_TOL2 * 10;

        if( ( lfourth( lfourth( E ) ) != _0 )
        &&  ( lsecond( lfourth( lfourth( E ) ) ) != ERROR )
        &&  ( lthird ( lfourth( lfourth( E ) ) ) ) )
        {
            *res = fltoCfl( ecrlserrkd( E ) );
        }
        else
        {
            single k, flag, step;
            double dh1, dh2, dh3, summand, isqrtN;
            floating flh;
            int N;
            single *ecrclser( );
    
            k = 0;
            i = 50;
            flag = 5;
            step = 0;
            
        
            init( N );
            init( flh );
          
            N = ecrcond( E );
            flh = itofl( N );
            dh1 = fltoCfl( flh );
          
            isqrtN = 1.0 / sqrt( dh1 );
            
            dh1 = 1.0;
            dh2 = 1.0 / exp( PI2 * isqrtN );
            /***   exp( ( n + 1 ) * PI2 * isqrtN )                      ***/
            /***           = exp( n * PI2 * isqrtN ) * dh2              ***/
        
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
                    dh1 *= dh2;
                    if( A[k] )
                    {
                        summand = ( double ) A[k] * dh1 / ( double ) k;
                        *res += summand;       
                        if( fabs( summand ) < LS_TOL11 )
                        {
                            i--;
		            if( !i )
		            {
			        if( ( fabs( 1.0 - dh3 / *res ) < LS_TOL22 ) 
                                ||  ( fabs( *res ) < LS_TOL11 ) )
			        {
		                    /*** Approximation ist gut genug    ***/
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
            *res *= 2;
        }
    }
    return( A );
}
