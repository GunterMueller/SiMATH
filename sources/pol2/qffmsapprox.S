/*M
.SH NAME
qffmsapprox \- 
quadratic function field over modular singles,
approximation of divisor class number
.\" ( q, D, LF, n, L, Ef )

.SH SYNOPSIS
.nf
#include <_pol2.h>

int qffmsapprox( q, D, LF, n, L, Ef )
single q, n;
list LF;
pol D;
int *L;
floating *Ef;

E = qffmsapprox( q, D, LF, n, &L, &Ef );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.

.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.

.TP 4
.B LF
contains the factorization of D (see upmscfacts).

.TP 4
.B n
= deg(D) >= 4.

.TP 4
.B *Ef
floating, is an approximation of the divisor class number.

.TP 4
.B  E
= nearest integer to Ef.
 
.TP 4
.B *L
is an integer > 0 such that

 | h - E | < L^2  ,

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
The approximation can be computed very efficiently in the range
given in the reference.

.SH SEE ALSO
.BR qffmsreglap(),
.BR qffmsreglapv()
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_pol2.h>
#define EULERq2  2819
#define EULERq3  199
#define EULERq4  53
#define EULERq5  23
#define EULERq6  13
#define EULERq7  7
#define EULERq8  7
#define EULERq9  5

int qffmsapprox( q, D, LF, n, pL, pEf )
single q, n;
list LF;
pol D;
int *pL;
floating *pEf;
{
	single al;
	int E, L;
	floating Ef;
	bind( D, LF );
	init( E, L, Ef );

	n = n/2 - 1; /* n= genus */
	if( n == 1 ) { E = qffmsapprox1( q, &L ); *pEf = itofl( E ); }
	else if( n == 2 ) { E = qffmsapprox2( q, &L ); *pEf = itofl( E ); }
	else {
	/* al = [(deg(D)-3)/5] = [(2g-1)/5] */
		al = ( mshom( 5, n ) != 4 ) ? ( (2*n+2)/5 ) : ( ((2*n+2)/5) - 1 );
		if( ((n == 4) && (q <= EULERq3) )
		  || ((n == 9) && (q <= EULERq5) )
		  || ((n == 14) && (q <= EULERq7) )
		  || ((n == 19) && (q <= EULERq9) ) ) al++;	
		E = qffmsapprox3( q, D, LF, n, al, &L, &Ef );
		*pEf = Ef;
	}
	*pL = L;
	return( E );
}

int qffmsapprox1( q, pL )
single q;
int *pL;
{
	int E;
	init( E);
	
	E = isum( q, 1 );
	q = isprod( q, 4 );
	*pL = isum( 1, iroot( q, 4, &q ) );
	return( E );
}

int qffmsapprox2( q, pL)
single q;
int *pL;
{
	int E, L;
	init( E, L );
	
	E = isum( q, 1 );
	E = isquare( E );
	L = iprod( q, isprod( E, 16 ) );
	E = isum( E, isprod( q, 4 ) );
	L = isum( 1, iroot( L, 4, &q ) );
	*pL = L;
	return( E );
}

int qffmsapprox3( q, D, LF, g, al, pL, pEf )
single q, g, al;
list LF;
pol D;
int *pL;
floating *pEf;
{
	single i;
	int E;
	floating M, M1, Psi, eins;
	bind( D, LF );
	init( E, Psi, M, M1, eins);

	eins = itofl( 1 );

  /* Compute Psi = Psi( alpha, D ) */

	Psi = qffmsppssii( q, g, al );

  /* Compute M = M( al, D ) */ 

	M = qffmseuler1( q, D, LF );  

	if( (al >= 2) || ( (g == 4) && (q <= EULERq3) ) ) {
		M1 = ( q <= EULERq2 ) ? ( qffmseuler2( q, D, LF ) ) : ( qffmseuler( q, D, LF ) );
		M = flprod( M, M1 );
	}
	if( al >= 3 ) {
		M1 = ( q <= EULERq3 ) ? ( qffmseuler3( q, D, LF ) ) : ( qffmseuler( q, D, 3 ) );
/*		M1 = ( q <= EULERq3 ) ? ( qffmseuler3( q, D, LF ) ) : ( eins ); */
		M = flprod( M, M1 );
	}
	if( ( al >= 4 ) || ( (g == 9) && (q <= EULERq5) ) ) {
		M1 = ( q <= EULERq4 ) ? ( qffmseuler4( q, D, LF ) ) : ( qffmseuler( q, D, 4 ) );
/*		M1 = ( q <= EULERq4 ) ? ( qffmseuler4( q, D, LF ) ) : ( eins );*/
		M = flprod( M, M1 );
	}
	if( al >= 5 ) {
		M1 = ( q <= EULERq5 ) ? ( qffmseuler5( q, D, LF ) ) : ( qffmseuler( q, D, 5 ) );
/*		M1 = ( q <= EULERq5 ) ? ( qffmseuler5( q, D, LF ) ) : ( eins ); */
		M = flprod( M, M1 );
	}
	if( ( al >= 6 ) || ( (g == 14) && (q <= EULERq7) ) ) {
		M1 = ( q <= EULERq6 ) ? ( qffmseuler6( q, D, LF ) ) : ( qffmseuler( q, D, 6 ) );
/*		M1 = ( q <= EULERq6 ) ? ( qffmseuler6( q, D, LF ) ) : ( eins ); */
		M = flprod( M, M1 );
	}
	if( al >= 7 ) {
		M1 = ( q <= EULERq7 ) ? ( qffmseuler7( q, D, LF ) ) : ( qffmseuler( q, D, 7 ) );
/*		M1 = ( q <= EULERq7 ) ? ( qffmseuler7( q, D, LF ) ) : ( eins );  */
		M = flprod( M, M1 );
	}
	if( ( al >= 8 ) || ( (g == 19) && (q <= EULERq9) ) ) {
		M1 = ( q <= EULERq8 ) ? ( qffmseuler8( q, D, LF ) ) : ( qffmseuler( q, D, 8 ) );
/*		M1 = ( q <= EULERq8 ) ? ( qffmseuler8( q, D, LF ) ) : ( eins ); */
		M = flprod( M, M1 );
	}
	if( al >= 9 ) {
		M1 = ( q <= EULERq9 ) ? ( qffmseuler9( q, D, LF ) ) : ( qffmseuler( q, D, 9 ) );
/*		M1 = ( q <= EULERq9 ) ? ( qffmseuler9( q, D, LF ) ) : ( eins ); */
		M = flprod( M, M1 );
	}
	for( i = 10; i <= al; i++ ) {
		M1 = qffmseuler( q, D, i );
		M = flprod( M, M1 );
	}

  /* Compute E = Nearest( q^{g+1} * M( al, D ) / (q-1)  */

	E = iexp( q, (g+1) ); /* E = q^{g+1} = q^{deg(D)/2} */
	M1 = itofl(  E );
	M = flprod( M, M1 );
	M = flquot( M, itofl( q-1 ) ); /* here: M = E'( al, D ) */
	E = flround( M );
	*pEf = M;

  /* Compute L( al, D ) */

	Psi = flexp( Psi );
	Psi = fldif( Psi, eins );
	Psi = flprod( M, Psi );
	M   = fldif( M, itofl( E ) );
	M   = flsum( Psi, flabs( M ) );
	M = flsqrt( M );
	*pL = isum( 1, flfloor( M ) );

	return( E );
}