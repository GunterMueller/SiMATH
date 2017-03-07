/*M
.SH NAME
qffmseuler \- 
quadratic function field over modular singles,
euler product of fixed degree
.\" ( q, D, n )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler( q, D, n )
single q, n;
pol D;

f = qffmseuler( q, D, n );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B n
is an integer > 0.

.TP 4
.B f 
= prod ( q^n / ( q^n - [D/P] )

where P runs through all monic prime polynomials of degree n;
[D/P] = Jacobi symbol of D over P.

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
This version is a (slow) version for general range. Faster
algorithms which depend on the size of q can be found in
qffmseuler1 - qffmseuler9. 

.SH SEE ALSO
.BR qffmseuler1(), 
.BR qffmseuler2(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/

#include <_pol2.h>

floating qffmseuler( q, D, n )
single q, n;
pol D;
{
	floating eq1, eq2, fqn, M;
	int S1, S2; 
	int H, H1;
	pol P, P1;
	single c, j;
	bind( D );
	init( H, H1, eq1, eq2, fqn, M, P, P1, S1, S2 );

	H = iexp( q, n );
	fqn = itofl( H );
	M = itofl( 1 );
	eq1 = flquot( fqn, fldif( fqn, M ) ); /* eq1 = q^n/(q^n-1) */
	eq2 = flquot( fqn, flsum( fqn, M ) ); /* eq2 = q^n/(q^n+1) */

	H = idif(H,1);
	while ( H ) {
		H1 = H;
		isqrem( H1, q, &H1, &c );
		if( !c ) { H = idif(H,1); continue;}


  /* Generate a polynomial. Then test whether it is prime */

		for( P1 = list1( c ), j = n-1; j; j-- ) {
			isqrem( H1, q, &H1, &c );
			P1 = lcomp( c, P1 );
		}
		P1 = lcomp( 1, P1 );
		P1 = lcomp( n, P1 );
		P = dptop( 1, P1 );
		if( pmsrem( 1, q, D, P ) && isimupms( q, P ) ) {
		   if( upmsjacsym( q, D, P )==1 ) S1 = isum( S1, 1 );
		   else  S2 = isum( S2, 1 );
		}
		H = idif(H,1);
	}	
/* printf("\nS%d(1) = %d\tS%d(-1) = %d", n, S1, n, S2); */
	fqn = flpow( eq1, itofl( S1 ) );/* S1 = #{ P:	P not| D and [D/P] =  1} */
	M   = flpow( eq2, itofl( S2 ) );/* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fqn ) );
}