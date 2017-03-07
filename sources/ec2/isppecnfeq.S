/*M
.SH NAME
isppecnfeq - is projective point of an elliptic curve over number field equal?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isppecnfeq( F, PL1, PL2 )  
pol F; 
list PL1, PL2;

.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B PL1
is a list, consisting of three elements of K and defining a point, say P1, in projective representation on an elliptic curve.
.TP 4
.B PL2
is a list, consisting of three elements of K and defining a point, say P2, in projective representation on an elliptic curve. 
.PP
isppecnfeq returns
.IP
 1, if P1 = P2,
 0, if P1 != P2.
                          
M*/

/*H                     
	Version 1       10.10.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE isppecnfeq    : 900315.9011__.910915
H*/

#include <_ec2.h>

single isppecnfeq( F, P1, P2 )

pol F;
list P1, P2;

{
	single n;

	bind( F, P1, P2 );
	init( n );

	P1 = ecnfsrpp( F, P1 );
	P2 = ecnfsrpp( F, P2 );
	n = oequal( P1, P2 );
	return( n );
}
