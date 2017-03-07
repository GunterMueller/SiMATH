/*M
.SH NAME
isponecqnf - is point on elliptic curve over quadratic number field

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isponecqnf(D, E, PL)  
pol D; 
list E, PL;
 
.SH DESCRIPTION
.TP 4
.B D
is a polynomial, generating the quadratic number field Q(sqrt(D)).
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q(sqrt(D)), as descripted in the 
documentation of 'ecrinit'.
.TP 4
.B PL
is a list consisting of two or three elements of the number field Q(sqrt(D)), defining a point, say P, in affine resp. projective representation.
.PP
isponecqnf returns
.IP
 1, if P is a point on the actual model of the 
    curve E/Q(sqrt(D)),
 0, else.

.SH SEE ALSO
ecrinit

M*/
                    
/*H
	Version 1	03.03.1997	Susanne Schmitt
H*/	

#include <_ec2.h>

# define ecqnfa1(E) lfirst(lfirst(lfirst(E)))
# define ecqnfa2(E) lsecond(lfirst(lfirst(E)))
# define ecqnfa3(E) lthird(lfirst(lfirst(E)))
# define ecqnfa4(E) lfourth(lfirst(lfirst(E)))
# define ecqnfa6(E) lfifth(lfirst(lfirst(E)))

single isponecqnf( D, E, P )
pol D;
list E, P;
{
    nfel x, y, rs, ls;

    if( !P || (llength(P)==3 && lthird(P)==0))
    {
	/*   P ist der unendlich ferne Punkt   */
	return( 1 );
    }
    
    bind( E, P );

    init( x, y, rs, ls );

    x = lfirst( P ); 
    y = lsecond( P ); 
    if(llength(P)==3) 
    {	P=lthird(P);
	x=qnfquot(D,x,P);
	y=qnfquot(D,y,P);
    }

    /*   ls = linke  Seite = y^2 + a1 x y + a3 y      */
    
    ls = qnfprod( D, x, ecqnfa1( E ) );
    ls = qnfsum ( D, ls, ecqnfa3( E ) );
    ls = qnfsum ( D, ls, y );
    ls = qnfprod( D, ls, y );

    /*   rs = rechte Seite = x^3 + a2 x^2 + a4 x + a6    */
    rs = qnfsum ( D, x, ecqnfa2( E ) );
    rs = qnfprod( D,rs, x );
    rs = qnfsum ( D,rs, ecqnfa4( E ) );
    rs = qnfprod( D,rs, x );
    rs = qnfsum ( D,rs, ecqnfa6( E ) );

    if( qnfdif( D, rs, ls ) )
    {
	/*   linke Seite != rechte Seite   */
        return( 0 );
    }

    /*   else: linke Seite == rechte Seite   */
    return( 1 );
}   
