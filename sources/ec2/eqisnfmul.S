/*M
.SH NAME 
eqisnfmul - elliptic curve over quadratic number field with integral 
coefficients, short normal form, multiplication map

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfmul(d,E,P,n)
int d;
list   E,P;
single n;

.SH DESCRIPTION
eqisnfmul() returns the point  n*P.

.PP
.TP 4
.B d
is a squarefree integer not equal to 0 and 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field Q(sqrt(d)) (see 'ecqnfinit').
.TP 4
.B P
is a projective point P=(x,y,z) of E over K.
.TP 4
.B n
is a single precision number.
M*/
/*H
        Version 1       12.08.1998      S. Schmitt
   DATE eqisnfmul     : 980815  
H*/

# include <_ec2.h>

list eqisnfmul( d, E, P, n )
int d;
list E, P;
single n;
{
    if( !n )
    {
	return( list3( 0, itonf(1), 0 ) );
    }
    if( isppecnfpai( P ) || ( n == 1 ) )
    {
	return( P );
    }
    else
    {
        list Q, R;
        single m;
        
        bind( d, E, P );
        init( Q, R );
        
        /*    Vorbereitungen, Initialisierungen                     */
    
        if( n < 0 )
        {
	    /*  Fuer n < 0:  n * Q = |n| * (-Q)   */
	    Q = eqisnfneg( d, E, P );
            m = (-1) * n;
        }
        else
        {
            Q = P;
            m = n;
        }
    
        R = list3( 0, itonf(1), 0 );
    
        while( 1 )
        {
            /*   ( m & 01 ) liefert das letzte Bit in m           */
            
            if( m & 01 )
            {
                R = eqisnfsum( d, E, Q, R );
            }
            m >>= 1;

	    if( !m )
	    {
		break;
	    }
            Q = eqisnfdouble( d, E, Q );
        }
        return( R );
    }
}
