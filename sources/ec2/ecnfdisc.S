/*M
.SH NAME
ecnfdisc - elliptic curve over number field discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecnfdisc( F, a1, a2, a3, a4, a6 )  
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
ecnfdisc returns the discriminant of the curve E.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.46.

M*/
           
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2       29.08.1990      M.P.: Alter Name: DISCECNF
	Version 3	25.10.1990	M.P.: Uebergabe von F in nfdif 
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfdisc      : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

nfel ecnfdisc( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel b2, b4, b6, b8, h, D;
	list L;

	bind( F, a1, a2, a3, a4, a6 );
	init( b2, b4, b6, b8, h, D, L );

	/*   Berechnung von b2, b4, b6 und b8                           */

	L = ecnftavb8( F, a1, a2, a3, a4, a6 );
	b2 = lfirst( L );
	b4 = lsecond( L );
	b6 = lthird( L );
	b8 = lfourth( L );

	/*   Berechnung der Diskriminante                               */

	h = itonf( 9 );
	h = nfprod( F, b2, h );
	h = nfprod( F, b4, h );
	h = nfprod( F, b6, h );
	D = itonf( 27 );
	D = nfprod( F, D, b6 );
	D = nfprod( F, D, b6 );
	D = nfdif( F, h, D );
	h = itonf( 8 );
	h = nfprod( F, h, b4 );
	h = nfprod( F, h, b4 );
	h = nfprod( F, h, b4 );
	D = nfdif( F, D, h );
	h = nfprod( F, b2, b2 );
	h = nfprod( F, b8, h );
	D = nfdif( F, D, h );

	return( D );
}
