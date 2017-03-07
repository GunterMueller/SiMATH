/*M
.SH NAME
iselecnf - is element of an elliptic curve over number field ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single iselecnf( F, a1, a2, a3, a4, a6, PL )  
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
are elements of the number field K, defining a cubic curve in Weierstrass normal form, say E.
.TP 4
.B PL
= (x y z) defines a point, say P, in projective representation.
.PP
iselecnf returns
.IP
 1, if P is a point on E,
 0, else.

M*/
    
/*H
	Version 1       17.10.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif, nfsum
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE iselecnf      : 900315.901120.910915
H*/

#include <_ec2.h>

single iselecnf( F, a1, a2, a3, a4, a6, P )

pol F;
nfel a1, a2, a3, a4, a6;
list P;

{
	single n;
	nfel x, y, h1, h2;
	list Q;

	bind( F, a1, a2, a3, a4, a6, P );
	init( n, x, y, h1, h2, Q );

	Q = ecnfsrpp( F, P );
	if ( isppecnfpai( P ) )
	{
		n = 1;
	}
	else
	{
		x = lfirst( Q );
		y = lsecond( Q );
		h1 = nfprod( F, y, y );
		h2 = nfprod( F, a1, x );
		h2 = nfprod( F, h2, y );
		h1 = nfsum( F, h1, h2 );
		h2 = nfprod( F, a3, y );
		h1 = nfsum( F, h1, h2 );
		h2 = nfprod( F, x, x );
		h2 = nfprod( F, h2, x );
		h1 = nfdif( F, h1, h2 );
		h2 = nfprod( F, x, x );
		h2 =nfprod( F, h2, a2 );
		h1 = nfdif( F, h1, h2 );
		h2 = nfprod( F, a4, x );
		h1 = nfdif( F, h1, h2 );
		h1 = nfdif( F, h1, a6 );
		if ( h1 == 0 )
		{
			n = 1;
		}
		else
		{
			n = 0;
		}
	}

	return( n );
}
