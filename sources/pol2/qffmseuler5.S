/*M
.SH NAME
qffmseuler5 \- 
quadratic function field over modular singles,
product of euler factors of degree 5
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler5( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler5( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q <= 23.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B LF
contains the factorization of D (see upmscfacts).

.TP 4
.B f 
= prod ( q^5 / ( q^5 - [D/P] )

where P runs through all monic prime polynomials of degree 5;
[D/P] = Jacobi symbol of D over P.

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH SEE ALSO
.BR qffmseuler(), 
.BR qffmseuler1(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>
#define EULERq5  23

/* The bound on q can be increased by making use of better storage means,
   for instance by using bit arrays. */

floating qffmseuler5( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2, P3, P4, P5, Q;
	unsigned char ES[EULERq5][EULERq5][EULERq5][EULERq5][EULERq5];
	int S1, S2; 
	single c, i, j, k, l, t;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P3, P4, P5, P, S1, S2, Q );

	M = itofl( q );
	fq = flprod( M, M);
	fq = flprod( fq, flprod( M, fq ) );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^5/(q^5-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq2 = q^5/(q^5+1) */

  /* Compute all monic prime polynomials of degree 5 by a sieve method */
  /* First, initialize a field of dimension 5 by zero. */
	for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 1; t < q ; t++ ) {
						ES[ i ][ j ][ k ][ l ][ t ] = 0;
					}
				}
			}	
		}
	}

  /* Then, mark all composite polyomials by 1. */
	for( i = 1; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 1; t < q ; t++ ) {
						ES[((i+j)%q)][((k+i*j)%q)][((l+i*k)%q)][((t+l*i)%q)][((t*i)%q)] = 1;
					}
				}
			}
		}
	}
	
	for( i = 0; i < q ; i++ ) {
		for( j = 1; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 1; t < q ; t++ ) {
						ES[((i+k)%q)][((l+i*k+j)%q)][((t+i*l+j*k)%q)][((i*t+l*j)%q)][((t*j)%q)] = 1;
					}
				}
			}
		}
	}

  /* Compute the Artin (resp. Jacobi) symbol [D/P] of all monic prime polynomials
     of degree 5, i.e. which are represented by all field elements with value 0.  */
	P = list6( 1, 0, 0, 0, 0, 1 );
	P = lcomp( 5, P );
	P1 = lred2( P );
	P2 = lred3( P );
	P3 = lred4( P );
	P4 = lred5( P );
	P5 = lred6( P );
	for( S1 = 0, S2 = 0, i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 1; t < q ; t++ ) {
						if( !ES[ i ][ j ][ k ][ l ][t] ) {
							lsfirst( P1, i );
							lsfirst( P2, j );
							lsfirst( P3, k );
							lsfirst( P4, l );
							lsfirst( P5, t );
							Q = dptop( 1, P );
							if( !islelt( LF, Q ) ) {
		   						if( upmsjacsym( q, D, Q )==1 ) S1 = isum( S1, 1 );
		   						else  S2 = isum( S2, 1 );
							}
						}
					}
				}
			}
		}	
	}
/*printf("\nS5(1) = %d\tS5(-1) = %d", S1, S2);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}