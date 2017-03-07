/*M
.SH NAME
ecnfsnfmul - elliptic curve over number field short normal form multiplication-map

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfsnfmul(F, a, b, n, PL)  
pol F; 
nfel a,b; 
single n; 
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
.B n
is a natural number.
.TP 4
.B PL
= (x, y, z) defines a point, say P, in projective representation on the curve E.
.PP
ecnfsnfmul returns the list PL1, consisting of three elements of K and representing the point P1 on E, where
.IP
P1 = n * P.                                                                         
M*/
                               
/*H
	Version 1       16.01.1990      Michael Pfeifer
	Version 2       19.11.1990      ECNFMULSNF -> ECNFSNFMUL,
					ECNFSUMSNF -> ECNFSNFSUM.   PS
	Version 3       27.08.1991      von 'arith2 nach 'ec2.  PS
	Version 4	10.09.1992	list3(0,list3(1,0,1),0) aufgeloest.  PS
   DATE ecnfsnfmul    : 900315.901120.9107__.910915.921130
H*/

#include <_ec2.h>

list ecnfsnfmul( F, a, b, n, P1 )

pol F;
nfel a, b;
single n;
list P1;

{
	list P2, Pn;
	single m, bits;

	bind( F, a, b, n, P1 );
	init( P2, Pn );

	/*   Standarddarstellung des projektiven Punktes P1             */

	P1 = ecnfsrpp( F, P1 );

	/*   Vorbereitungen, Initialisierungen                          */

	m = 1;
	bits = n;
	P2 = lcopy( P1 );
	Pn = list3( 1, 0, 1 );
	Pn = list3( 0, Pn, 0 );

	/*   Steuerung der Additionen durch das Bitmuster von n.        */
	/*   Fuer n = [b31b30...b2b1b0] berechne                        */
	/*       n*P1 = b0*P1 + b1*2*P1 + ... + bj*2^j*P1               */
	/*       mit 2^j = m <= n.                                      */

	while ( m <= n )
	{

	/*   ( bits & 01 ) liefert das letzte Bit in bits               */

		if ( ( bits & 01 ) == 1 )
		{
			Pn = ecnfsnfsum( F, a, b, P2, Pn );
		}

	/*   Linksshift: Multiplikation von m mit 2                     */

		m = m << 1;

	/*   Rechtsshift: letztes Bit kontrolliert Addition             */

		bits = bits >> 1;
		P2 = ecnfsnfsum( F, a, b, P2, P2 );
	}

	return( Pn );
}
