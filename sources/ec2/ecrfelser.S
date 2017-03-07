/*M
.SH NAME
ecrfelser - elliptic curve over rational numbers, Fourier expansion of the L-series

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrfelser(E, A, z, result)
list L; 
double z, *result; 
single *A;
         
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'. 
.TP 4
.B A
points on an array of singles, containing the coefficients (say a_n) of the L-series of the curve E/Q (s.ecrclser).
.PP
For a reall number z, ecrfelser computes (approximates) the sum over the terms
.IP
a_n * exp(-2 * PI * n * z), 
.PP
for n = 1 to infinity. ecrfelser writes the result to *result and returns the pointer A or NULL in case of an error occured.
.SH CAUTION
Because ecrfelser is of type *single, it had to be declared in every function it is used !
.SH SEE ALSO
 ecrinit
 ecrclser
 Literature:Y.I. Manin, "Cyclotomic fields and modular 
                         curves", 
            Russian Math. Surveys 25, no. 6 ( 1971 ), 
            pp 7-78.

M*/
            
/*H
	Version 1     	12.11.1992	Josef Gebel
	Version 2     	19.01.1992	Anpassung an neues Konzept. JG
	Version 3     	01.06.1994	Abbruchbedingung veraendert. JG
   DATE ecrfelser     : 921130.930531.941201
H*/

#include <_ec2.h>
#define _PI2    -6.283185307179586      /* - 2 * PI */

single *ecrfelser( E, A, z, result )
list E;
single *A;
double z, *result;
{
    single e, k, flag, step;
    double dh1, dh2, dh3, dh4, summand;
    
    single *ecrclser();
    double exp();
  
    bind( E );
   
    *result = 0;       
    k = 0;
    e = 100;

    flag = 5;
    step = 0;
    
    dh1 = 1.0;
    dh2 = exp( _PI2 * z );
    dh3 = 0.0;
    dh4 = 100.0 * LS_TOL1;

    while( flag )
    {
        step += LS_STEP;
        if( ( A = ecrclser( E, A, step ) ) == NULL )
        {
            printf( "ECRFELSER: ERROR ( 1 ) \n" );
            return( NULL );
        }
    
	while( k < step )
        {
	    k++;
	    dh1 *= dh2;
	    if( *( A + k ) )
	    {
                summand = *( A + k ) * dh1;
                *result += summand;       
	        if( fabs( summand ) < LS_TOL2 )
	        {
		    e--;
		    if( !e )
		    {
                        if( ( fabs( 1.0 - dh3 / *result ) < dh4 )
                        ||  ( fabs( *result ) < dh4 ) )
	                {
	                    /* Approximation ist gut genug    */
	                    flag--;
		        }
	                else
		        {
	                    flag = 5;
	                }
                        dh3 = *result;
		        e = 100;
		    }
	        }
            }
        }
    }
    return( A );
}
