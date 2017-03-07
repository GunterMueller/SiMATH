/*M
.SH NAME
ecnftavc6 - elliptic curve over number field Tate's values c4, c6

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnftavc6( F, a1, a2, a3, a4, a6 ) 
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
ecnftavc6 omputes the Tate's values c4 and c6 of E, and returns them as a list of two elements.

.SH SEE ALSO
Literature: D. Husemoeller: Elliptic curves, p.68. 

M*/
    
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnftavc6     : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnftavc6( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel b2, b4, b6, c4, c6, h;
	list L;

	bind( F, a1, a2, a3, a4, a6 );
	init( b2, b4, b6, c4, c6, h, L );

	L = ecnftavb6( F, a1, a2, a3, a4, a6 );
	b2 = lfirst( L );
	b4 = lsecond( L );
	b6 =lthird( L );

	/*   Berechnung von c4 und c6                                   */

	h = itonf( 24 );
	h = nfprod( F, b4, h );
	c4 = nfprod( F, b2, b2 );
	c4 = nfdif( F, c4, h );
	h = itonf( 216 );
	h = nfprod( F, b6, h );
	c6 = itonf( 36 );
	c6 = nfprod( F, b2, c6 );
	c6 = nfprod( F, b4, c6 );
	c6 = nfdif( F, c6, h );
	h = nfprod( F, b2, b2 );
	h = nfprod( F, b2, h );
	c6 = nfdif( F, c6, h );

	return( list2( c4, c6 ) );

}
