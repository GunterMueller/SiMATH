/*M
.SH NAME
eciminmul - elliptic curve with integer coefficients, minimal model, multiplication-map
.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminmul(E1, P1, n)
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
defines the point P on the minimal model of the elliptic curve E/Q.
The model representing E is of restricted typ (i.e. a1',a3'= 0 or 1, a2'=-1, 0, 1).

M*/

/*H     
       	Version 1	22.12.1992      Josef Gebel (neues Konzept)
   DATE eciminmul     : 930531
H*/

#include <_ec1.h>

list eciminmul( E, P, n )
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
	/*   P = ( 0 : 1 : 0 ) unendlich ferner Punkt oder 1 * P   */
        return( P );
    }
    else
    {

        list Q, Pn;
        single m;
    
        init( Q, Pn );

        if( n < 0 )
        {
	     /*  Fuer n < 0:  n * Q = |n| * (-Q)   */
	     Q = eciminneg( E, P );
             m = (-1) * n;
	     if( m == 1 )
	     {
	         return( Q );
	     }
        }
	else
	{
            Q = P;
	    m = n;
        }

	Pn = list3( 0, 1, 0 );

        while( 1 )
        {
            if( ( m & 01 ) == 1 )
            {
                Pn = eciminsum( E, Q, Pn );
            }
        
            /*   Linksshift: Multiplikation von m mit 2                 */
    
            m >>= 1;

	    if( !m )
	    {
		break;
	    }
    
            /*   Rechtsshift: letztes Bit kontrolliert Addition         */
        
            Q = ecimindouble( E, Q );
        }
    
        return( Pn );
    }
}
