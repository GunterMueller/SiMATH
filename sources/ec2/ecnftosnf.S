/*M
.SH NAME
ecnftosnf - elliptic curve over number field to short normal form

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnftosnf( F, a1, a2, a3, a4, a6 ) 
pol F; 
nfel a1, a2, a3, a4, a6;
  
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an elliptic curve in Weierstrass normal form, say E.
.PP
ecnftosnf omputes a curve E' in short Weierstrass normal form with coefficients
a and b, which is bi-rational isomorphic to E.
E' is given by the following  transformation : 
.TP 4
.PP
 x = u^2 * x' + r,
 y = u^3 * y' + u^2 * s * x' + t,
 z = z'.
.PP                      
ecnftosnf returns a list, say L, containing two other lists:
.IP
L = (( a b ) ( r s t u )).
 
.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.48.

M*/
   
/*H
	Version 1       10.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnftosnf     : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnftosnf( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel b2, c4, c6, a, b, r, s, t, u, h;
	list C, T;

	bind( F, a1, a2, a3, a4, a6 );
	init( b2, c4, c6, a, b, r, s, t, u, h, C, T );

	/*   Berechnung von b2                                          */

	h = itonf( 4 );
	h = nfprod( F, a2, h );
	b2 = nfprod( F, a1, a1 );
	b2 = nfsum( F, b2, h );

	/*   Berechnung von c4 und c6                                   */

	C = ecnftavc6( F, a1, a2, a3, a4, a6 );
	c4 = lfirst( C );
	c6 = lsecond( C );

	/*   Berechnung der kurzen Weierstrass-Normalform               */

	h = itonf( -27 );
	a = nfprod( F, c4, h );
	h = itonf( -54 );
	b = nfprod( F, c6, h );
	C = list2( a, b );

	/*   Berechnung der Transformation                              */

	h = rtonf( list2( -1, 12 ) );
	r = nfprod( F, b2, h );
	h = rtonf( list2( -1, 2 ) );
	s = nfprod( F, a1, h );
	t = nfprod( F, a3, h );
	h = rtonf( list2( 1, 24 ) );
	h = nfprod( F, a1, h );
	h = nfprod( F, b2, h );
	t = nfsum( F, t, h );
	u = rtonf( list2( 1, 6 ) );
	T = list4( r, s, t, u );

	return( list2( C, T ) );
}
