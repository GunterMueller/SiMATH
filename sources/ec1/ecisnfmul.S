/*M
.SH NAME
ecisnfmul - elliptic curve with integer coefficients, short normal form, multiplication-map

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfmul(E1, P1, n)  
list E1, P1;  
single n;

.SH DESCRIPTION
eciminmul computes the multiple of the point P,
.PP
n*P = P + ... + P ( n-times),
.PP
and returns it as a list of three elements.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1                                                                           
defines the point P on the model in short normal form of the elliptic curve E/Q.  
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       12.11.1992      Josef Gebel (neues Konzept)
   DATE ecisnfmul     : 930531
H*/

#include <_ec1.h>

list ecisnfmul( E, P, n )
list E, P;
single n;
{
        bind( E, P );
    if( !n )
    {
	return( list3( 0, 1, 0 ) );
    }
    if( ispecrpai( P ) || ( n == 1 ) )
    {
	return( P );
    }
    else
    {
        list Q, R;
        single m;
        
        /**bind( E, P ); **/
        init( Q, R );
        
        /*    Vorbereitungen, Initialisierungen                     */
    
        if( n < 0 )
        {
	    /*  Fuer n < 0:  n * Q = |n| * (-Q)   */
	    Q = ecisnfneg( E, P );
            m = (-1) * n;
        }
        else
        {
            Q = P;
            m = n;
        }
    
        R = list3( 0, 1, 0 );
    
        while( 1 )
        {
            /*   ( m & 01 ) liefert das letzte Bit in m           */
            
            if( m & 01 )
            {
                R = ecisnfsum( E, Q, R );
            }
            m >>= 1;

	    if( !m )
	    {
		break;
	    }
            Q = ecisnfdouble( E, Q );
        }
        return( R );
    }
}
