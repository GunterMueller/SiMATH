/*M
.SH NAME
ecnfsrpp - elliptic curve over number field standard representation of projective point 

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfsrpp( F, PL )  
pol F; 
list PL;
   
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.  
.TP 4
.B PL
= (x y z) is a list of three elements of K, defining a projective point, say P, on an elliptic curve.
.PP
ecnfsrpp returns a representation P' = (x', y', z') for the point P, so that
.IP
 z' = 1,       for z != 0,
 P' = (0 1 0), for z  = 0.

M*/
                                       
/*H
	Version 1       10.01.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfsrpp      : 900315.9011__.910915
H*/

#include <_ec2.h>

list ecnfsrpp( F, P )

pol F;
list P;

{
	nfel x, y, z;

	bind( F, P );
	init( x, y, z );

	x = lfirst( P );
	y = lsecond( P );
	z = lthird( P );
	if ( z != 0 )
	{
		x = nfquot( F, x, z );
		y = nfquot( F, y, z );
		z = itonf( 1 );
	}
	else
	{
		x = 0;
		y = itonf( 1 );
		z = 0;
	}

	return( list3( x, y, z ) );
}
