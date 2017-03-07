/*M
.SH NAME
ecnftavb8 - elliptic curve over number field Tate's values b2, b4, b6, b8

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnftavb8( F, a1, a2, a3, a4, a6 ) 
pol F; 
nfel a1, a2, a3, a4, a6;
 
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an cubic curve in Weierstrass normal form, say E.
.PP
ecnftavb8 computes the Tate's values b2, b4, b6 and b8 of E, and returns them as a list of four elements.

.SH SEE ALSO 
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.46.

M*/
      
/*H
	Version 1       08.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif, nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnftavb8     : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnftavb8( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel b8, h;
	list L;

	bind( F, a1, a2, a3, a4, a6 );
	init( b8, h, L );

	/*   Berechnung von b8                                          */

	h = nfprod( F, a1, a1 );
	h = nfprod( F, a6, h );
	b8 = itonf( 4 );
	b8 = nfprod( F, a2, b8 );
	b8 = nfprod( F, a6, b8 );
	b8 = nfsum( F, b8, h );
	h = nfprod( F, a1, a3 );
	h = nfprod( F, a4, h );
	b8 = nfdif( F, b8, h );
	h = nfprod( F, a2, a3 );
	h = nfprod( F, a3, h );
	b8 = nfsum( F, b8, h );
	h = nfprod( F, a4, a4 );
	b8 = nfdif( F, b8, h );

	/*   Anhaengen an die Liste aus b2, b4 und b6                   */

	L = ecnftavb6( F, a1, a2, a3, a4, a6 );
	L = lconc( L, list1( b8 ) );

	return( L );
}
