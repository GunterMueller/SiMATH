/*M
.SH NAME
qffmseuler1 \- 
quadratic function field over modular singles,
product of euler factors of degree 1
.\" ( q, D, LF )

.SH SYNOPSIS
.nf
#include <_pol2.h>

floating qffmseuler1( q, D, LF )
single q;
pol D;
list LF;

f = qffmseuler1( q, D, LF );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.

.TP 4
.B D 
is a polynomial in k[X], deg(D) > 0, in sparse representation. 

.TP 4
.B LF
list, contains the factorization of D (see upmscfacts).

.TP 4
.B f 
= prod ( q / ( q - [D/P] )

where P runs through all monic (prime) polynomials of degree 1;
[D/P] = Jacobi symbol of D over P.

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
The algorithm computes the Euler factors of  degree 1.

.SH SEE ALSO
.BR qffmseuler(), 
.BR qffmseuler2(),
.BR etc. 
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>
	
floating qffmseuler1( q, D, LF )
single q;
pol D;
list LF;
{
	floating eq1, eq2, fq, M;
	pol P1;
	list LH;
	int S1, S2; 
	single c, i;
	bind( D, LF );
	init( eq1, eq2, fq, M, P1, S1, S2, LH );

    /* LH = ( a_1, ... a_l ) such that (X + a_i) | D */ 
	for( LH = _0; LF != _0 ; ) {
		P1 = lfirst( LF );
		LF = lred( LF ); 
		if( lfirst( P1 ) == 1 ) { 
			c = (llength( P1 ) == 4 ) ? ( lfourth( P1 ) ) : ( 0 ); 
			LH = lcomp( c, LH );
		}
	}
/* printf("\neuler1: LH = "); puto( LH );fflush(stdout); */
	fq = itofl( q );
	M = itofl( 1 );
	eq1 = flquot( fq, fldif( fq, M ) );  /* eq1 = q/(q-1) */
	eq2 = flquot( fq, flsum( fq, M ) );  /* eq2 = q/(q+1) */

	for( S1 = 0, S2 = 0, i = 0; i < q; i++ ) {
		if( !islelt( LH, i ) ) {
		   c = pmseval( 1, q, D, msneg( q, i ) );
		   if( (c=ijacsym( c, q ))==1 ) S1 = isum( S1, 1 );
		   else  S2 = isum( S2, 1 );
		}
	}
/* printf("\nS1(1) = %d\tS1(-1) = %d", S1, S2);*/
	fq = flpow( eq1, itofl( S1 ) ); /* S1 = #{ P:	P not| D and [D/P] =  1} */
	M =  flpow( eq2, itofl( S2 ) ); /* S2 = #{ P:	P not| D and [D/P] = -1} */
	return( flprod( M, fq ) );
}