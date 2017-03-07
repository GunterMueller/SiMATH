/*M
.SH NAME
qffmseuler2 \- 
quadratic function field over modular singles,
product of euler factors of degree 2
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler2( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler2( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q <= 2819.

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

.SH SEE ALSO
.BR qffmseuler(), 
.BR qffmseuler3(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>
#define EULERq2  2819

/* The bound on q can be increased by making use of better storage means,
   for instance by using bit arrays. */

floating qffmseuler2( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2;
	unsigned char ES[EULERq2][EULERq2];

	int S1, S2; 
	single c, i, j;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P, S1, S2 );

	fq = itofl( q );
	fq = flprod( fq, fq );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^2/(q^2-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq2 = q^2/(q^2+1) */

  /* Compute all monic prime polynomials of degree 2 by a sieve method */
  /* First, initialize a field of dimension 2 by zero. */
  /* Here, ES[ i ][ j ] represents the polynomial X^2 + i * X + j */
	for( i = 0; i < q ; i++ ) {
		for( j = 1; j < q ; j++ ) {
			ES[ i ][ j ] = 0;
		}
	}

  /* Then, mark all composite polyomials by 1. */
	for( i = 1; i < q ; i++ ) {
		for( j = i; j < q ; j++ ) {
			ES[ ((i+j)%q) ][ ((i*j)%q) ] = 1;
		}
	}
	
  /* Compute the Artin (resp. Jacobi) symbol [D/P] of all monic prime polynomials,
     i.e. which are represented by all field elements with value 0.		   */
	P = list6( 2, 1, 1, 1, 0, 1 );
	P1 = lred3( P );
	P2 = lred5( P );
	for( S1 = 0, S2 = 0, i = 1; i < q ; i++ ) {
		for( j = 1; j < q ; j++ ) {
			if( !ES[ i ][ j ] ) {
				lsfirst( P1, i );
				lsfirst( P2, j );
				if( !islelt( LF, P ) ) {
		   			if( upmsjacsym( q, D, P )==1 ) S1 = isum( S1, 1 );
		   			else  S2 = isum( S2, 1 );
				}
			}
		}
	}	

	P = list4( 2, 1, 0, 1 );
	P1 = lred3( P );
	for( j = 1; j < q; j++ ) {
		if( !ES[ 0 ][ j ] ) {
			lsfirst( P1, j );
			if( !islelt( LF, P ) ) {
	   			if( upmsjacsym( q, D, P )==1 ) S1 = isum( S1, 1 );
	   			else  S2 = isum( S2, 1 );
			}
		}
	}
/* printf("\nS2(1) = %i\tS2(-1) = %i", S1, S2); fflush(stdout);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */

	return( flprod( M, fq ) );
}