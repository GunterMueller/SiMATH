/*M
.SH NAME
ecnfsnfsum - elliptic curve over number field short normal form sum of points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfsnfsum( F, a, b, PL1, PL2 )  
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
ecnfsnfsum returns the list PL3, consisting of three elements of K and defining the projective point P3 on E, where
.IP
P3 = P1 + P2.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic
                            curves, p.59.                        

M*/
                        
/*H
	Version 1       16.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif, nfneg
	Version 3       19.11.1990      ECNFSUMSNF -> ECNFSNFSUM   PS
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
	Version 5	10.09.1992	list3(0,list3(1,0,1),0) aufgeloest.  PS
   DATE ecnfsnfsum    : 900315.901120.9107__.910915.921130
H*/

#include <_ec2.h>

list ecnfsnfsum( F, a, b, P1, P2 )

pol F;
nfel a, b;
list P1, P2;

{
	nfel x1, x2, x3, y3, z3, l, n, h;
	list P3, L;

	bind( F, a, b, P1, P2 );
	init( x1, x2, x3, y3, z3, l, n, h );

	/*   Berechnung der Schnittgeraden                              */

	L = ecnfsnflp( F, a, b, P1, P2 );
	if ( llength( L ) == 1 )
	{
		if ( lfirst( L ) == 0 )
		{
			P3 = list3( 1, 0, 1 );
			P3 = list3( 0, P3, 0 );
		}
		if ( lfirst( L ) == 1 )
		{
			P3 = P2;
		}
		if ( lfirst( L ) == 2 )
		{
			P3 = P1;
		}
	}
	else
	{
		l = lfirst( L );
		n = lsecond( L );
		L = ecnfsrpp( F, P1 );
		x1 = lfirst( L );
		L = ecnfsrpp( F, P2 );
		x2 = lfirst( L );
		x3 = nfprod( F, l, l );
		x3 = nfdif( F, x3, x1 );
		x3 = nfdif( F, x3, x2 );
		y3 = nfprod( F, l, x3 );
		y3 = nfneg( F, y3 );
		y3 = nfdif( F, y3, n );
		z3 = itonf( 1 );
		P3 = list3( x3, y3, z3 );
	}

	return( P3 );
}
