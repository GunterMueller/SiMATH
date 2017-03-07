/*M
.SH NAME
qffmseuler8 \- 
quadratic function field over modular singles,
product of euler factors of degree 8
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler8( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler8( q, D, LF );

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
= prod ( q^8 / ( q^8 - [D/P] )

where P runs through all monic prime polynomials of degree 8;
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
#define EULERq8  7

/* The bound on q can be increased by making use of better storage means,
   for instance by using bit arrays. */

floating qffmseuler8( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P, P1, P2, P3, P4, P5, P6, P7, P8, Q;
	unsigned char ES[EULERq8][EULERq8][EULERq8][EULERq8][EULERq8][EULERq8][EULERq8][EULERq8];
	int S1, S2; 
	single c, i, j, k, l, t, s, r, u;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, P2, P3, P4, P5, P6, P7, P8, P, S1, S2, Q );

	fq = itofl( q );
	fq = flprod( fq, fq );
	fq = flprod( fq, fq );
	fq = flprod( fq, fq );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) ); /* eq1 = q^8/(q^8-1) */
	eq2 = flquot( fq, flsum( fq, M ) ); /* eq2 = q^8/(q^8+1) */

  /* Compute all monic prime polynomials of degree 8 by a sieve method */
  /* First, initialize a field of dimension 8 by zero. */
for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
									ES[ i ][ j ][ k ][ l ][ t ][ s ][ r ][ u ] = 0;
								}
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
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
		ES[(i+j)%q][(k+i*j)%q][(l+i*k)%q][(t+l*i)%q][(t*i+s)%q][(s*i+r)%q][(i*r+u)%q][(i*u)%q] = 1;
								}
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
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
		ES[(i+k)%q][(l+i*k+j)%q][(t+i*l+j*k)%q][(i*t+l*j+s)%q][(t*j+i*s+r)%q][(j*s+i*r+u)%q][(j*r+i*u)%q][(j*u)%q] = 1;
								}
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
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
	ES[(i+l)%q][(t+i*l+j)%q][(i*t+j*l+s+k)%q][(j*t+l*k+i*s+r)%q][(u+k*t+j*s+i*r)%q][(i*u+k*s+j*r)%q][(j*u+k*r)%q][(k*u)%q] = 1;
								}
							}
						}
					}
				}
			}
		}
	}

	for( i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 1; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
	ES[(i+t)%q][(s+i*t+j)%q][(j*t+i*s+r+k)%q][(u+k*t+l+j*s+i*r)%q][(l*t+k*s+i*u+j*r)%q][(l*s+j*u+k*r)%q][(k*u+l*r)%q][(l*u)%q] = 1;
								}
							}
						}
					}
				}
			}
		}
	}
  /* Compute the Artin (resp. Jacobi) symbol [D/P] of all monic prime polynomials
     of degree 8, i.e. which are represented by all field elements with value 0.  */
	P = list6( 0, 0, 0, 0, 0, 1 );
	P = lcomp4( 8, 1, 0, 0, P );
	P1 = lred2( P );
	P2 = lred3( P );
	P3 = lred4( P );
	P4 = lred5( P );
	P5 = lred6( P );
	P6 = lreduct( P, 7 );
	P7 = lreduct( P, 8 );
	P8 = lreduct( P, 9 );
	for( S1 = 0, S2 = 0, i = 0; i < q ; i++ ) {
		for( j = 0; j < q ; j++ ) {
			for( k = 0; k < q ; k++ ) {
				for( l = 0; l < q ; l++ ) {
					for( t = 0; t < q ; t++ ) {
						for( s = 0; s < q ; s++ ) {
							for( r = 0; r < q ; r++ ) {
								for( u = 1; u < q ; u++ ) {
									if( !ES[ i ][ j ][ k ][ l ][ t ][ s ][ r ][ u ] ) {
										lsfirst( P1, i );
										lsfirst( P2, j );
										lsfirst( P3, k );
										lsfirst( P4, l );
										lsfirst( P5, t );
										lsfirst( P6, s );
										lsfirst( P7, r );
										lsfirst( P8, u );
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
	}
/* printf("\nS8(1) = %d\tS8(-1) = %d", S1, S2);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}