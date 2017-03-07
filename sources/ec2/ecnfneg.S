/*M
.SH NAME
ecnfneg - elliptic curve over number field negative point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfneg( F, a1, a2, a3, a4, a6, PL )  
pol F;
nfel a1, a2, a3, a4, a6; 
list PL;
            
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an elliptic curve in Weierstrass normal form, say E.
.TP 4
.B PL
= (x1, y1, z1) defines a point, say P, in projective representation on the curve E.
.PP              
ecnfmul returns the list PL1, defining the projective point P1 on E, where
.IP
P1 = - P.

.SH SEE ALSO
Literature: J.H. Silverman, The arithmetic of elliptic 
                            curves, p.58.

M*/
        
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfneg, nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfneg       : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnfneg( F, a1, a2, a3, a4, a6, P )

pol F;
nfel a1, a2, a3, a4, a6;
list P;

{
	nfel x, y, z, h;

	bind( F, a1, a2, a3, a4, a6, P );
	init( x, y, z, h );

	x = lfirst( P );
	y = lsecond( P );
	z = lthird( P );

	/*   Berechnung des additiv inversen Punktes                    */

	if ( z != 0 )
	{
		x = nfquot( F, x, z );
		y = nfquot( F, y, z );
		z = itonf( 1 );
		h = nfprod( F, a1, x );
		y = nfsum( F, y, h );
		y = nfsum( F, y, a3 );
		y = nfneg( F, y );
	}
	else
	{
		x = 0;
		y = itonf( 1 );
		z = 0;
	}
	return( list3( x, y, z ) );
}
