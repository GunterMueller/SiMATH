/*M
.SH NAME
ecnfsnfdisc - elliptic curve over number field, short normal form, discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecnfsnfdisc( F, a, b )  
pol F; 
nfel a, b;
 
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.                                              
.TP 4
.B a, b
are elements of the number field K, defining a cubic curve in short normal form, say E.
.PP
ecnfsnfdisc returns the discriminant of the curve E.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.50. 

M*/
                           
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2       29.08.1990      M.P.: Alter Name: DISCECNFSNF
	Version 3 	25.10.1990	M.P.: Uebergabe von F in nfneg, nfsum
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfsnfdisc   : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

nfel ecnfsnfdisc( F, a, b )

pol F;
nfel a, b;

{
	nfel D, h;

	bind( F, a, b );
	init( D, h );

	/*   Berechnung der Diskriminante                               */

	h = itonf( 27 );
	h = nfprod( F, b, h );
	h = nfprod( F, b, h );
	D = itonf( 4 );
	D = nfprod( F, D, a );
	D = nfprod( F, D, a );
	D = nfprod( F, D, a );
	D = nfsum( F, D, h );
	h = itonf( 16 );
	h = nfneg( F, h );
	D = nfprod( F, D, h );

	return( D );
}
