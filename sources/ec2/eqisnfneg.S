/*M
.SH NAME 
eqisnfneg - elliptic curve over quadratic number field with integral 
coefficients, short normal form, negative of point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfneg(d,E,P)
int d;
list   E,P;

.SH DESCRIPTION
eqisnfneg() returns the negative of the point P.

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
M*/
/*H
        Version 1       12.08.1998      S. Schmitt
   DATE eqisnfneg     : 980815  
H*/

# include <_ec2.h>

list eqisnfneg( d, E, P )
int d;
list E, P;
{
    nfel y;
     
    init( y );
    bind( d, E, P );

    if( isppecnfpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> -P = P                           */
	return( P );
    }

    y = qnfneg( d, lsecond( P ) );

    return( list3( lfirst ( P ), y, lthird ( P ) ) );
}
