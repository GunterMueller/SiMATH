/*M
.SH NAME
ecnftavb6 - elliptic curve over number field Tate's values b2, b4, b6

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnftavb6( F, a1, a2, a3, a4, a6 ) 
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
ecnftavb6 computes the Tate's values b2, b4, b6 of E, and returns them as a list of three elements.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.46.   
M*/
        
/*H
	Version 1       08.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnftavb6     : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnftavb6( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel b2, b4, b6, h;

	bind( F, a1, a2, a3, a4, a6 );
	init( b2, b4, b6, h );

	/*   Berechnung von b2, b4 und b6                               */

	h = itonf( 4 );
	h = nfprod( F, a2, h );
	b2 = nfprod( F, a1, a1 );
	b2 = nfsum( F, b2, h );
	h = itonf( 2 );
	h = nfprod( F, a4, h );
	b4 = nfprod( F, a1, a3 );
	b4 = nfsum( F, b4, h );
	h = itonf( 4 );
	h = nfprod( F, a6, h );
	b6 = nfprod( F, a3, a3 );
	b6 = nfsum( F, b6, h );

	return( list3( b2, b4, b6 ) );
}
