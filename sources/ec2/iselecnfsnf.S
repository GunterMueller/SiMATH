/*M
.SH NAME
iselecnfsnf - is element of an elliptic curve over number field, short normal form ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single iselecnfsnf( F, a, b, PL )  
pol F; 
nfel a, b; 
list PL;
 
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a, b
are elements of the number field K, defining a cubic curve in short normal form, say E.
.TP 4
.B PL
= (x, y, z) defines a point, say P, in projective representation on the curve E.
.PP    
iselecnfsnf returns
.IP
 1, if P is an element of E,
 0, else.

M*/
             
/*H
	Version 1       17.10.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfdif
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE iselecnfsnf   : 900315.901120.910915
H*/

#include <_ec2.h>

single iselecnfsnf( F, a, b, P )

pol F;
nfel a, b;
list P;

{
	single n;
	nfel x, y, h1, h2;
	list Q;

	bind( F, a, b, P );
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
		h2 = nfprod( F, x, x );
		h2 = nfprod( F, h2, x );
		h1 = nfdif( F, h1, h2 );
		h2 = nfprod( F, a, x );
		h1 = nfdif( F, h1, h2 );
		h1 = nfdif( F, h1, b );
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
