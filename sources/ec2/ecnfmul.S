/*M
.SH NAME
ecnfmul - elliptic curve over number field multiplication-map

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfmul( F, a1, a2, a3, a4, a6, PL )  
pol F;
nfel a1, a2, a3, a4, a6; 
single n, 
list PL;
   
.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an elliptic curve in Weierstrass normal form, say E.
.TP 4
.B n
is a natural number.
.TP 4
.B PL
= (x1, y1, z1) defines a point, say P, in projective representation on the curve E.
.PP
ecnfmul returns the list PL1, representing the point P1 on E, where 
.IP
P1 = n * P.
  
M*/
                    
/*H
	Version 1       15.01.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith2 nach 'ec2.  PS
	Version 3	10.09.1992	list3(0,list3(1,0,1),0) aufgeloest.  PS
   DATE ecnfmul       : 900315.9011__.910915.921130
H*/

#include <_ec2.h>

list ecnfmul( F, a1, a2, a3, a4, a6, n, P1 )

pol F;
nfel a1, a2, a3, a4, a6;
single n;
list P1;

{
	list P2, Pn;
	single m, bits;

	bind( F, a1, a2, a3, a4, a6, P1 );
	init( P2, Pn );

	/*   Standarddarstellung des projektiven Punktes P1             */

	P1 = ecnfsrpp( F, P1 );

	/*    Vorbereitungen, Initialisierungen                         */

	m = 1;
	bits = n;
	P2 = lcopy( P1 );
	Pn = list3( 1, 0, 1 );
	Pn = list3( 0, Pn , 0 );

	/*   Steuerung der Additionen durch das Bitmuster von n.        */
	/*   Fuer n = [b31b30...b2b1b0] berechne                        */
	/*       n*P1 = b0*P1 + b1*2*P1 + ... + bj*2^j*P1               */
	/*       mit 2^j = m <= n.                                      */

	while ( m <= n )
	{

	/*   ( bits & 01 ) liefert das letzte Bit in bits               */

		if ( ( bits & 01 ) == 1 )
		{
			Pn = ecnfsum( F, a1, a2, a3, a4, a6, P2, Pn );
		}

	/*   Linksshift: Multiplikation von m mit 2                     */

		m = m << 1;

	/*   Rechtsshift: letztes Bit kontrolliert Addition             */

		bits = bits >> 1;
		P2 = ecnfsum( F, a1, a2, a3, a4, a6, P2, P2 );
	}

	return( Pn );
}
