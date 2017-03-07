/*M
.SH NAME
qffmseuler2s \- 
quadratic function field over modular singles,
product of euler factors of degree 2, special
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler2s( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler2s( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q <= BASIS.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B LF
contains the factorization of D (see upmscfacts).

.TP 4
.B f 
= prod ( q^2 / ( q^2 - [D/P] )

where P runs through all monic prime polynomials of degree 2;
[D/P] = Jacobi symbol of D over P.

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
If q <= 2819, qffmseuler2() should be used. qffmseuler2() makes use
of sieve methods, whereas qffmseuler2s() makes use of the Jacobi symbol
of integers.
	
.SH SEE ALSO
.BR qffmseuler(), 
.BR qffmseuler2(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>

floating qffmseuler2s( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2;
	int S1, S2; 
	single c, i, j;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P, S1, S2 );

	fq = itofl( q );
	fq = flprod( fq, fq );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^2/(q^2-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq1 = q^2/(q^2+1) */

  /* Generate all monic polynomials of degree 2. 
     Then test whether it is prime.
     If P = X^2 + i * X + j , then P is prime if and only if
     the Jacobi symbol ( ( i^2 - 4 j ) / q ) = - 1 .		*/

	P = list6( 2, 1, 1, 1, 0, 1 );
	P1 = lred3( P );
	P2 = lred5( P );
	for( S1 = 0, S2 = 0, i = 1; i < q; i++ ) {
		for( j=1; j < q; j++ ) {
			if( euler2discr( q, i, j )==-1 ) {
				lsfirst( P1, i );
				lsfirst( P2, j );
				if( pmsrem( 1, q, D, P ) ) {

		   			if( upmsjacsym( q, D, P )==1 ) S1 = isum( S1, 1 );
		   			else  S2 = isum( S2, 1 );

/* printf("\neuler2: P(irred) = "); puto( P ); */

				}
			}
		}
	}

	P = list4( 2, 1, 0, 1 );
	P1 = lred3( P );
	for( j = 1; j < q; j++ ) {
		if( euler2discr( q, 0, j )==-1 ) {
			lsfirst( P1, j );
			if( !isinl( LF, P ) ) {
	   			if( upmsjacsym( q, D, P )==1 ) S1 = isum( S1, 1 );
	   			else  S2 = isum( S2, 1 );
			}
		}
	}
printf("\nS2(1) = %d\tS2(-1) = %d", S1, S2);
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}

single euler2discr( q, i, j )
single q, i, j;
{
/* euler2discr computes the Jacobi symbol ( ( i^2 - 4 j ) / q )  */
	i = msprod( q, i, i );
	j = msprod( q, mshom(q, 4), j );
	j = msdif( q, i, j  );
	j = ( j )? ( ijacsym( j, q ) ) : ( 1 ); 
	return( j );
}
