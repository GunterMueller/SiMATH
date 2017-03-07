/*M
.SH NAME
qffmseuler7 \- 
quadratic function field over modular singles,
product of euler factors of degree 7
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler7( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler7( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q <= 7.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B LF
contains the factorization of D (see upmscfacts).

.TP 4
.B f 
= prod ( q^7 / ( q^7 - [D/P] )

where P runs through all monic prime polynomials of degree 7;
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
#define EULERq7  7

/* The bound on q can be increased by making use of better storage means,
   for instance by using bit arrays. */

floating qffmseuler7( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2, P3, P4, P5, P6, P7, Q;
	unsigned char ES[EULERq7][EULERq7][EULERq7][EULERq7][EULERq7][EULERq7][EULERq7];
	int S1, S2; 
	single c, i, j, k, l, t, s, r;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P3, P4, P5, P6, P7, P, S1, S2, Q );

	M = itofl( q );
	fq = flprod( M, M );
	fq = flprod( fq, flprod( fq, fq ) );
	fq = flprod( fq, M );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^7/(q^7-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq2 = q^7/(q^7+1) */

  /* Compute all monic prime polynomials of degree 7 by a sieve method */
  /* First, initialize a field of dimension 7 by zero. */
	for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 1; r < q ; r++ ) {
								ES[ i ][ j ][ k ][ l ][ t ][ s ][ r ] = 0;
							}
						}
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
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 1; r < q ; r++ ) {
						ES[(i+j)%q][(k+i*j)%q][(l+i*k)%q][(t+l*i)%q][(t*i+s)%q][(s*i+r)%q][(i*r)%q] = 1;
							}
						}
					}
				}
			}
		}
	}
	
	for( i = 0; i < q ; i++ ) {
		for( j = 1; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 1; r < q ; r++ ) {
					ES[(i+k)%q][(l+i*k+j)%q][(t+i*l+j*k)%q][(i*t+l*j+s)%q][(t*j+i*s+r)%q][(j*s+i*r)%q][(j*r)%q] = 1;
							}
						}
					}
				}
			}
		}
	}
	for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 1; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 1; r < q ; r++ ) {
				ES[(i+l)%q][(t+i*l+j)%q][(i*t+j*l+s+k)%q][(j*t+l*k+i*s+r)%q][(k*t+j*s+i*r)%q][(k*s+j*r)%q][(k*r)%q] = 1;
							}
						}
					}
				}
			}
		}
	}

  /* Compute the Artin (resp. Jacobi) symbol [D/P] of all monic prime polynomials
     of degree 7, i.e. which are represented by all field elements with value 0.  */
	P = list6( 0, 0, 0, 0, 0, 1 );
	P = lcomp3( 7, 1, 0, P );
	P1 = lred2( P );
	P2 = lred3( P );
	P3 = lred4( P );
	P4 = lred5( P );
	P5 = lred6( P );
	P6 = lreduct( P, 7 );
	P7 = lreduct( P, 8 );
	for( S1 = 0, S2 = 0, i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 1; r < q ; r++ ) {
								if( !ES[ i ][ j ][ k ][ l ][ t ][ s ][ r ] ) {
									lsfirst( P1, i );
									lsfirst( P2, j );
									lsfirst( P3, k );
									lsfirst( P4, l );
									lsfirst( P5, t );
									lsfirst( P6, s );
									lsfirst( P7, r );
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
		}	
	}
/*printf("\nS7(1) = %d\tS7(-1) = %d", S1, S2);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}