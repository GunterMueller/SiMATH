/*M
.SH NAME
ecisnfneg - elliptic curve with integer coefficients, short normal form, negative point
.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfneg(E1, P1)
list E1, P1;

.SH DESCRIPTION
ecisnfneg computes the point N = -P of the elliptic curve E/Q, i.e.
.P
P + N = 0 = ( 0 : 1 : 0 ),
.P
and returns
.P
( 0  1  0 ),    for P = ( 0  1  0 ),
.P
( x  y' z ),    y' = - y		     , else.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1 = ( x y z ) int x, y, z;                                                 
defines the point P on the minimal model of the elliptic curve E/Q.             
   
.SH SEE ALSO                                                                    
ecrinit                                                                         
M*/          

/*H
	Version 1	12.11.1992	Josef Gebel (neues Konzept)
   DATE ecisnfneg     : 930531
H*/

#include<_ec1.h>

list ecisnfneg( E, P )
list E, P;
{
    int y;
     
    init( y );
    bind( E, P );

    if( ispecrpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> -P = P                           */
	return( P );
    }

    y = ineg( lsecond( P ) );

    return( list3( lfirst ( P ), y, lthird ( P ) ) );
}
