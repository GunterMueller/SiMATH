/*M
.SH NAME
ecnfsnflp - elliptic curve over number field short normal form line through points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list( F, a, b, PL1, PL2 )  
pol F; 
nfel a, b; 
list PL1, PL2;

.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a, b
are elements of the number field K, defining a elliptic curve in short normal form, say E.
.TP 4
.B PL1
= (x1, y1, z1) defines a point, say P1, in projective representation on the curve E.
.TP 4
.B PL2
= (x2, y2, z2) defines a point, say P2, in projective representation on the curve E.
.PP
ecnfsnflp computes the line, say G, trough the points P1 and P2, or the tangent to P1, if P1 = P2.
.IP
G: y = l * x + n.
.P
If possible, ecnfsnflp returns the list
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
	Version 1       16.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif, 
					nfneg, nfsum
	Version 3       19.11.1990      ECNFLPSNF  -> ECNFSNFLP,
					ECNFNEGSNF -> ECNFSNFNEG.   PS
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfsnflp     : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

list ecnfsnflp( F, a, b, P1, P2 )

pol F;
nfel a, b;
list P1, P2;

{
	nfel l, n, h, h1, h2, x1, y1, x2, y2;
	list Q, L;

	bind( F, a, b, P1, P2 );
	init( l, n, h, h1, h2, x1, y1, x2, y2 );

	/*   Standarddarstellungen der Punkte                           */

	Q = ecnfsrpp( F, P1 );
	x1 = lfirst( Q );
	y1 = lsecond( Q );
	Q = ecnfsrpp( F, P2 );
	x2 = lfirst( Q );
	y2 = lsecond( Q );

	/*   Test: P1 = -P2 ?                                           */

	Q = ecnfsnfneg( F, a, b, P2 );
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
		h1 = nfsum( F, a, h );
		h = itonf( 2 );
		h2 = nfprod( F, h, y1 );
		l = nfquot( F, h1, h2 );

		n = nfprod(F, l, x1);
		n = nfdif(F, y1, n);
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
