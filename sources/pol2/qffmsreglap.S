/*M
.SH NAME
qffmsreglap \- 
quadratic function field over modular singles,
regulator by approximation of the divisor class number
.\" ( q, D, E, L, Ef, H0, H1 )

.SH SYNOPSIS
.nf
#include <_pol2.h>
int qffmsreglap( q, D, E, L, Ef, H0, H1 )
single q;
pol D; 
floating *Ef;
int *E, *L, *H0, *H1;


E = qffmsreglap( q, D, &E, &L, &Ef, &H0, &H1 );

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
.B *Ef
floating, is an approximation of the divisor class number. 

.TP 4
.B *E
is the nearest integer to *Ef.

.TP 4
.B *L
is an integer such that

 | h - (*E) | < (*L)^2  .

.TP 4
.B *H1
is a multiple of the regulator, eventually the divisor class number.

.TP 4
.B *H0
= (*H1) / R and eventually the ideal class number.

.TP 4
.B R
is the regulator of k(X,Y).

.SH LITERATURE
A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", 1997.

.SH NOTE
If R > 2 (*L)^2 , then *H1 is the divisor class number and *H0
the ideal class number.
This algorithm is far better than the baby step - giant step algorithm
provided R is bigger than 10^7. The range for q and deg(D) can
be found in the reference.

.SH SEE ALSO
.BR qffmsapprox(),
.BR qffmsreglapv()
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_arith3.h>
#define defG 10000
#define maxL 20000

int qffmsreglap( q, D, pE, pL, pEf, pH0, pH1 )
single q;
pol D; 
floating *pEf;
int *pE, *pL, *pH0, *pH1;
{
	single n, s1;
	int E, L, H0, H1, R, B, G;
	floating Ef;
	pol D1, d;
	list LD;
	bind( D );
	init( E, L, H0, H1, R, B, Ef, G, D1, d, LD );
	
	n = lfirst( D );
	d = upmssrpp( q, D );
	D1 = ptodp( 1, D );
	d = ptodp( 1, d );
	LD = upmscfact( q, D );

	if( !G ) G = defG; /* Default G = 10000 */
	s1 = isqrt( G );

    /* Step 1: Test, whether R <= G */
	R = qffmsregbgb( q, D1, d, s1, G ); 
	if( R ) { *pEf = itofl( 1 ); *pE = 0; *pL = 0; *pH1 = 0; 
		*pH0 = 0; return( R );
	}

    /* Step2 : Approximation of h such that | h - E | < L^2, Ef = E'( al, D )  */
	E = qffmsapprox( q, D, LD, n, &L, &Ef );
	*pEf = Ef;

    /* Step3 : Compute a multiple H1 = H0 * R in the interval [ E - L^2, E + L^2 ] */
	H1 = qffmsmulti( q, D1, d, E, imin( L, maxL ), L ); 

	if( !H1 ) { *pE = E; *pL = L;  *pH1 = 0; *pH0 = 0;
		return( qffmsregbg( q, D ) );
	}
	B = isum( E, isquare( L ) );
	B = isum( 1, iquot( B, G ) );

    /* Step4 : Compute h1 = H1/ R  by a principal ideal test */
	H0 = qffmspitest( q, D1, d, H1, B );
	*pE = E;
	*pL = L;
	*pH1 = H1;
	*pH0 = H0;
	return( iquot( H1, H0 ) );
}