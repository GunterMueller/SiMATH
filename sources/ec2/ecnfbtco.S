/*M
.SH NAME
ecnfbtco - elliptic curve over number field birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecnfbtco( F, a1, a2, a3, a4, a6, r, s, t, u )  
pol F;
nfel a1, a2, a3, a4, a6, r, s, t, u;               

.SH DESCRIPTION
.TP 4
.B F
is an univariate and irreducible polynomial in dense-representation, generating
a number field, say K.
.TP 4
.B a1, a2, a3, a4, a6
are elements of the number field K, defining an elliptic curve in Weierstrass normal form, say E.
.TP 4
.B r, s, t, u
are elements of K, u != 0, defining a birational transformation, say BT.    
.PP
ecnfbtco returns the coefficients a1', a2', a3', a4', a6' of the curve in Weiherstrass normal form, which arises by  the birational transformation BT of the elliptic curve E, given by  
.IP
 x = u^2*x' + r,
 y = u^3*y' + u^2*s*x' + t.
.PP
   
.SH SEE ALSO
Literature: J.H. Silverman: The arithmetic of elliptic 
                            curves, p.49.

M*/
                    
/*H
	Version 1       17.10.1989      Michael Pfeifer
	Version 2	25.10.1990	M.P.: Uebergabe von F in nfdif, nfsum
	Version 3       01.03.1991      P.S.: Fehler verbessert (nfsum hatte
					      1x nur 2 Parameter)
	Version 4       27.08.1991      von 'arith2 nach 'ec2.  PS
   DATE ecnfbtco      : 900315.901120.910301.910915
H*/

#include <_ec2.h>

list ecnfbtco( F, a1, a2, a3, a4, a6, r, s, t, u )

pol F;
nfel a1, a2, a3, a4, a6, r, s, t, u;

{

	nfel a1s, a2s, a3s, a4s, a6s, h1, h2;

	bind( F, a1, a2, a3, a4, a6, r, s, t, u );
	init( a1s, a2s, a3s, a4s, a6s, h1, h2 );

	h2 = u;

	/*   Berechnung von a1' ( hier a1s )                            */

	a1s = a1;
	h1 = itonf( 2 );
	h1 = nfprod( F, h1, s );
	a1s = nfsum( F, a1s, h1 );
	a1s = nfquot( F, a1s, h2 );

	/*   Berechnung von a2' ( hier a2s )                           */

	h2 = nfprod( F, h2, u );
	a2s = a2;
	h1 = nfprod( F, s, a1 );
	a2s = nfdif( F, a2s, h1 );
	h1 = itonf( 3 );
	h1 = nfprod( F, h1, r );
	a2s = nfsum( F, a2s, h1 );
	h1 = nfprod( F, s, s );
	a2s = nfdif( F, a2s, h1 );
	a2s = nfquot( F, a2s, h2 );

	/*   Berechnung von a3' ( hier a3s )                            */

	h2 = nfprod( F, h2, u );
	a3s = a3;
	h1 = nfprod( F, r, a1 );
	a3s = nfsum( F, a3s, h1 );
	h1 = itonf( 2 );
	h1 = nfprod( F, h1, t );
	a3s = nfsum( F, a3s, h1 );
	a3s = nfquot( F, a3s, h2 );

	/*   Berechnung von a4' ( hier a4s )                            */

	h2 = nfprod( F, h2, u );
	a4s = a4;
	h1 = nfprod( F, s, a3 );
	a4s = nfdif( F, a4s, h1 );
	h1 = itonf( 2 );
	h1 = nfprod( F, h1, r );
	h1 = nfprod( F, h1, a2 );
	a4s = nfsum( F, a4s, h1 );
	h1 = nfprod( F, r, s );
	h1 = nfsum( F, h1, t );
	h1 = nfprod( F, h1, a1 );
	a4s = nfdif( F, a4s, h1 );
	h1 = itonf( 3 );
	h1 = nfprod( F, h1, r );
	h1 = nfprod( F, h1, r );
	a4s = nfsum( F, a4s, h1 );
	h1 = itonf( 2 );
	h1 = nfprod( F, h1, s );
	h1 = nfprod( F, h1, t );
	a4s = nfdif( F, a4s, h1 );
	a4s = nfquot( F, a4s, h2 );

	/*   Berechnung von a6' ( hier a6s )                            */

	h2 = nfprod( F, h2, u );
	h2 = nfprod( F, h2, u );
	a6s = a6;
	h1 = nfprod( F, r, a4 );
	a6s = nfsum( F, a6s, h1 );
	h1 = nfprod( F, r, r );
	h1 = nfprod( F, h1, a2 );
	a6s = nfsum( F, a6s, h1 );
	h1 = nfprod( F, r, r );
	h1 = nfprod( F, h1, r );
	a6s = nfsum( F, a6s, h1 );
	h1 = nfprod( F, t, a3 );
	a6s = nfdif( F, a6s, h1 );
	h1 = nfprod( F, t, t );
	a6s = nfdif( F, a6s, h1 );
	h1 = nfprod( F, t, r );
	h1 = nfprod( F, h1, a1 );
	a6s = nfdif( F, a6s, h1 );
	a6s = nfquot( F, a6s, h2 );

	return( list5( a1s, a2s, a3s, a4s, a6s ) );
}
