/*M
.SH NAME
ecrptoproj - elliptic curve over rational numbers, point to projective representation
                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list  ecrptoproj(P)  
list P;
                                                                     
.SH DESCRIPTION
ecrptoproj converts the affine representation of the point P to the projective one, and returns it as a list of three elements.

M*/

/*H
	Version 1       17.12.1992  	Josef Gebel (neues Konzept)
   DATE ecrptoproj    : 930531
H*/

#include <_ec1.h>

list ecrptoproj( P )
list P;
{
    if( lthird( P ) == 0 )
    {
	return( list3( 0, 1, 0 ) );
    }
    else
    {
        int x, y, z;
	list Q;
        
	bind( P );
        init( x, y, z );

	Q = ecrpnorm( P );

	z = lthird( Q );

	y = iprod( z, z );
	y = iprod( y, z );  /*  Z^3  */
	x = iprod( y, z );  /*  Z^4  */
	z = iprod( y, y );  /*  Z^6  */
	y = iprod( y, lsecond( Q ) );
	x = iprod( x, lfirst ( Q ) );

	Q = list3( x, y, z );
	return( Q );
    }
}
