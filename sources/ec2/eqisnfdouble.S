/*M
.SH NAME 
eqisnfdouble - elliptic curve over quadratic number field with integral 
coefficients, short normal form, double of point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfdouble(d,E,P)
int d;
list   E,P;

.SH DESCRIPTION
eqisnfdouble() returns the double of the point P, that is 2*P = P+P.

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
   DATE eqisnfdouble     : 980815  
H*/

# include <_ec2.h>

list eqisnfdouble( d,E, P )
int d;
list E, P;
{
    if( isppecnfpai( P ) || !lsecond( P ) )
    {
	/*   P = O oder P ist 2-Teilungspunkt ==> 2 * P = O     */
	return( list3( 0, itonf(1), 0 ) );
    }
    else
    {
        nfel a4, x1, x2, y1, y2, z1, t;
        list D;

        bind( d, E, P );
        init( a4, x1, x2, y1, y2, z1, t );
        init( D );
    
        a4 = eqisnfa4( E );
        
        x1 = lfirst ( P );
        y1 = lsecond( P );
        z1 = lthird ( P );
    
        /************************************************************/
        /*                                                          */
        /*  Sei P = ( X1, Y1 ) mit X1 = x1/z1, Y1 = y1/z1 )         */
        /*  D = 2 * P mit D = ( X2, Y2 ) = ( x2/z2,  y2/z2 ).       */
        /*                                                          */
        /*                                                          */
        /*  Seien weiter                                            */
        /*                                                          */
        /*           3 X1^2 + a4       3 x1^2 + a4 z1^2             */
        /*      t = -------------  =  ---------------------         */
        /*               2 Y1                2 y1 z1                */
        /*                                                          */
        /*  Dann ist X2 = t^2 - 2 X1                                */
        /*           Y2 = t (X1-X2) - Y1                            */
        /*                                                          */
        /************************************************************/

	x1 = qnfquot(d,x1,z1);
	y1 = qnfquot(d,y1,z1);

	z1 = qnfprod(d,x1,x1);
	t = qnfsum(d,z1,z1);
	t = qnfsum(d,t,z1);	
	t = qnfsum(d,t,a4);
	z1 = qnfsum(d,y1,y1);
	t = qnfquot(d,t,z1);

	x2 = qnfprod(d,t,t);
	z1 = qnfsum(d,x1,x1);
	x2 = qnfdif(d,x2,z1);

	y2 = qnfdif(d,x1,x2);
	y2 = qnfprod(d,y2,t);
	y2 = qnfdif(d,y2,y1);
    
        D = list3( x2, y2, itonf(1) );
    
        return( D );
    }
}
