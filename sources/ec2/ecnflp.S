/*M
.SH NAME
ecnflp - elliptic curve over number field line through points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnflp( F, a1, a2, a3, a4, a6, PL1, PL2 )  
pol F;
nfel a1, a2, a3, a4, a6; 
list PL1, PL2;
               
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an elliptic curve in Weierstrass normal form, say E.
.TP 4
.B PL1
= (x1, y1, z1) defines a point, say P1, in projective representation on the curve E.
.TP 4
.B PL2
= (x2, y2, z2) defines a point, say P2, in projective representation on the curve E.
.PP
ecnflp computes the line, say G, trough the points P1 and P2, or the tangent to P1, if P1 = P2.
.IP
G: y = l * x + n.
.P
If possible, ecnflp returns the list
.IP
 L = ( l n ),   or
 L = ( 0 ),     for P1 = -P2,
 L = ( 1 ),     for P1 the point at infinity,
 L = ( 2 ),     for P2 the point at infinity. 

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.58.
                                                                            
M*/
                       
/*H
	Version 1       11.01.1990      Michael Pfeifer
	Version 2       25.10.1990      M.P.: Uebergabe von F in nfdif,
					nfneg, nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnflp        : 900315.901120.910915
H*/

#include <_ec2.h>

list ecnflp( F, a1, a2, a3, a4, a6, P1, P2 )

pol F;
nfel a1, a2, a3, a4, a6;
list P1, P2;

{
	nfel l, n, h, h1, h2, x1, y1, x2, y2;
	list Q, L;

	bind( F, a1, a2, a3, a4, a6, P1, P2 );
	init( l, n, h, h1, h2, x1, y1, x2, y2, Q, L );

	/*   Standarddarstellung der Punkte                             */

	Q = ecnfsrpp( F, P1 );
	x1 = lfirst( Q );
	y1 = lsecond( Q );
	Q = ecnfsrpp( F, P2 );
	x2 = lfirst( Q );
	y2 = lsecond( Q ),

	/*   Test: P1 = -P2 ?                                           */

	Q = ecnfneg( F, a1, a2, a3, a4, a6, P2 );
	if ( isppecnfeq( F, P1, Q ) )
	{
		return( list1( 0 ) );
	}

	/*   Test: P1 = ( 0, 1, 0 ) oder P2 = ( 0, 1, 0 ) ?             */

	if ( isppecnfpai( P1 ) )
	{
		return( list1( 1 ) );
	}
	if ( isppecnfpai( P2 ) )
	{
		return( list1( 2 ) );
	}

	/*   Berechnung von l und n                                     */

	if ( oequal( x1, x2 ) )
	{
		h = itonf( 3 );
		h = nfprod( F, x1, h );
		h = nfprod( F, x1, h );
		h1 = itonf( 2 );
		h1 = nfprod( F, a2, h1 );
		h1 = nfprod( F, x1, h1 );
		h1 = nfsum( F, h1, h );
		h1 = nfsum( F, h1, a4 );
		h = nfprod( F, a1, y1 );
		h1 = nfdif( F, h1, h );
		h2 = itonf( 2 );
		h2 = nfprod( F, y1, h2 );
		h = nfprod( F, a1, x1 );
		h2 = nfsum( F, h2, h );
		h2 = nfsum( F, h2, a3 );
		l = nfquot(F,h1,h2);

		n = nfprod(F, l,x1);
		n = nfdif(F, y1,n);
	}
	else
	{
		h1 = nfdif( F, y2, y1 );
		h2 = nfdif( F, x2, x1 );
		l = nfquot( F, h1, h2 );

		n = nfprod(F,l,x1);
		n = nfdif(F,y1,n);
	}

	return( list2( l, n ) );
}
