/*M
.SH NAME
qffmseuler3 \- 
quadratic function field over modular singles,
product of euler factors of degree 3
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler3( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler3( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q <= 199.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B LF
contains the factorization of D (see upmscfacts).

.TP 4
.B f 
= prod ( q^3 / ( q^3 - [D/P] )

where P runs through all monic prime polynomials of degree 3;
[D/P] = Jacobi symbol of D over P.

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH SEE ALSO
.BR qffmseuler(), 
.BR qffmseuler4(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>
#define EULERq3  199

/* The bound on q can be increased by making use of better storage means,
   for instance by using bit arrays. */

floating qffmseuler3( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2, P3, Q;
	unsigned char ES[EULERq3][EULERq3][EULERq3];
	int S1, S2; 
	single c, i, j, k;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P3, P, S1, S2, Q );

	fq = itofl( q );
	fq = flprod( fq, flprod( fq, fq ) );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^3/(q^3-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq2 = q^3/(q^3+1) */

  /* Compute all monic prime polynomials of degree 3 by a sieve method */
  /* First, initialize a field of dimension 3 by zero. */
  /* Here, ES[ i ][ j ][ k ] represents the polynomial X^3 + i * X^2 + j* X + k */
	for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 1; k < q ; k++ ) {
				ES[ i ][ j ][ k ] = 0;
			}
		}
	}

  /* Then, mark all composite polyomials by 1. */
	for( i = 1; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 1; k < q ; k++ ) {
				ES[ ((i+j)%q) ][ ((k+i*j)%q) ][ ((i*k)%q) ] = 1;
			}
		}
	}
	
  /* Compute the Artin (resp. Jacobi) symbol [D/P] of all monic prime polynomials
     of degree 3, i.e. which are represented by all field elements with value 0.  */
	P = list5( 3, 1, 0, 0, 1 );
	P1 = lred2( P );
	P2 = lred3( P );
	P3 = lred4( P );
	for( S1 = 0, S2 = 0, i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 1; k < q ; k++ ) {
				if( !ES[ i ][ j ][k] ) {
					lsfirst( P1, i );
					lsfirst( P2, j );
					lsfirst( P3, k );
					Q = dptop( 1, P );
					if( !islelt( LF, Q ) ) {
		   				if(upmsjacsym(q, D, Q)==1) S1 = isum( S1, 1 );
		   				else  S2 = isum( S2, 1 );
					}
				}
			}
		}	
	}

/* printf("\nS3(1) = %i\tS3(-1) = %i", S1, S2);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}