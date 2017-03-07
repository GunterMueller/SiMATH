/*M
.SH NAME
ecnfsnfjinv - elliptic curve over number field, short normal form, j-invariant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecnfsnfjinv( F, a, b )  
pol F; 
nfel a, b;
 
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a, b
are elements of the number field K, defining a elliptic curve in short normal form, say E.
.PP
ecnfsnfjinv returns the j-invariant of the curve E.

.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic
                            curves, p.50.              

M*/
                                     
/*H
	Version 1       09.01.1990      Michael Pfeifer
	Version 2       29.08.1990      M.P.: Alter Name: JINVECNFSNF
	Version 3 	25.10.1990	M.P.: Uebergabe von F in nfneg
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfsnfjinv   : 900315.901120.9107__.910915
H*/

#include <_ec2.h>

nfel ecnfsnfjinv( F, a, b )

pol F;
nfel a, b;

{
	nfel j, D, h;

	bind( F, a, b );
	init( j, D, h );

	/*   Berechnung der Diskriminante                               */

	D = ecnfsnfdisc( F, a, b );

	/*   Berechnung der j-Invariante                                */

	j = itonf( 64 );
	j = nfprod( F, j, a );
	j = nfprod( F, j, a );
	j = nfprod( F, j, a );
	h = itonf( 1728 );
	h = nfneg( F, h );
	j = nfprod( F, j, h );
	j = nfquot( F, j, D );

	return( j );
}
