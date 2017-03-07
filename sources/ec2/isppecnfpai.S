/*M
.SH NAME
isppecnfpai - is projective point of an elliptic curve over number field point at infinity ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isppecnfpai( PL )  
list PL;
 
.SH DESCRIPTION
.TP 4
.B PL
= (x y z) defines a point, say P, in projective representation on an elliptic curve.
.PP
isppecnfpai returns
.IP
 1, if P = (x y 0),
 0, else.

M*/
                                                         
/*H
	Version 1       10.10.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE isppecnfpai   : 900315.9011__.910915
H*/

#include <_ec2.h>

single isppecnfpai( P )

list P;

{
	nfel z;

	bind( P );
	init( z );

	z = lthird( P );
	if ( z == 0 )
	{
		return( 1 );
	}
	else
	{
		return( 0 );
	}
}
