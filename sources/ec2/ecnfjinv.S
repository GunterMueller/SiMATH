/*M
.SH NAME
ecnfjinv - elliptic curve over number field j-invariant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecnfjinv( F, a1, a2, a3, a4, a6 )  
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
ecnfjinv returns the j-invariant of the curve E.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.46.

M*/
       
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2       29.09.1990      M.P.: Alter Name: JINVECNF
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfjinv      : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

nfel ecnfjinv( F, a1, a2, a3, a4, a6 )

pol F;
nfel a1, a2, a3, a4, a6;

{
	nfel h, c4, j;
	list L;

	bind( F, a1, a2, a3, a4, a6 );
	init( h, c4, j, L );

	/*   Berechnung von c4 und D ( hier D = j )                     */

	L = ecnftavc6( F, a1, a2, a3, a4, a6 );
	c4 = lfirst( L );
	j = ecnfdisc( F, a1, a2, a3, a4, a6 );

	/*   Berechnung der j-Invariante                                */

	h = nfprod( F, c4, c4 );
	h = nfprod( F, c4, h );
	j = nfquot( F, h, j );

	return( j );
}
