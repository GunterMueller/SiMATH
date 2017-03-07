/*M
.SH NAME
ecnfsnfneg - elliptic curve over number field short normal form negative point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfsnfneg( F, a, b, PL )  
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
are elements of the number field K, defining a elliptic curve in short normal form, say E.
.TP 4
.B PL
= (x, y, z) defines a point, say P, in projective representation on the curve E.
.PP
ecnfsnfneg returns the list PL1, consisting of three elements of K and defining the projective point P1 on E, where 
.IP
P1 = - P.

.SH SEE ALSO
Literature: J.H. Silverman, The arithmetic of elliptic
                            curves, p.58.                       

M*/
                                 
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2 	25.10.1990	M.P.: Uebergabe von F in nfneg
	Version 3       19.11.1990      ECNFNEGSNF -> ECNFSNFNEG   PS
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfsnfneg    : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

list ecnfsnfneg( F, a, b, P )

pol F;
nfel a, b;
list P;

{
	nfel x, y, z, h;

	bind( F, a, b, P );
	init( x, y, z, h );

	x = lfirst( P );
	y = lsecond( P );
	z = lthird( P );

	/*   Berechnung des additiv inversen Punktes                    */

	if ( z != 0 )
	{
		x = nfquot( F, x, z );
		y = nfquot( F, y, z );
		z = itonf( 1 );
		y = nfneg( F, y );
	}
	else
	{
		x = 0;
		y = itonf( 1 );
		z = 0;
	}
	return( list3( x, y, z ) );
}
