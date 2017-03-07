/*M
.SH NAME 
ecqnfbtlp - elliptic curve over quadratic number field birational 
transformation of list of points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtlp(D, LP, BT, modus)
int D;
list   LP, BT;
single modus;


.SH DESCRIPTION
ecqnfbtlp() returns the list of points which are the transformation of the 
points in the list LP, using the birational transformation represented by BT. 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B modus
is equal to 0 or 1.
.TP 4
.B LP
is a list containing points over the quadratic number field K=Q(D^(1/2)).
If modus = 0, LP = ( P1  P2  ...  Pn ). 
If modus = 1, LP = ( P1  h1  P2  h2 ...  Pn  hn ) where hi is the 
Neron-Tate height of the point Pi.
.TP 4
.B BT
is a list containing the coefficients r,s,t,u of the transformation, 
BT = (r, s, t, u). The coefficients are elements of the quadratic number
field K.
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtlp     :  980323
H*/

#include <_ec2.h>

list ecqnfbtlp( d, LP, BT, modus ) 
int d;
list LP, BT;
single modus;
{
    list L, P, Q;
    floating h;

    bind( d, LP, BT );
    init( L, P, Q );
    init( h );

    if( ( LP == _0 )  
    ||  ( !lfirst( BT ) && !lsecond( BT ) && !lthird( BT ) &&
	  !qnfelcomp( d, itonf( 1 ), lfourth( BT ) ) ) )
    {
	/*   Punktliste ist leer                            */
	/*   oder Transformation ist identische Abbildung   */
       return( LP );
    }

    L = _0;

    while( LP != _0 )
    {
	P  = lfirst( LP );
	LP = lred( LP );
	Q = ecqnfbtp( d, P, BT );
	L = lcomp( Q, L );
	if( modus )
	{
            h = lfirst( LP );
	    L = lcomp( h, L );
	    LP = lred( LP );
	}
    }

    return( linv( L ) );
}
