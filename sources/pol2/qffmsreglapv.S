/*M
.SH NAME
qffmsreglapv \- 
quadratic function field over modular singles,
regulator by approximation of the divisor class number
with variables
.\" ( q, D, d, LD, G, s, Ls, E, L, Ef, H0, H1 )

.SH SYNOPSIS
.nf
#include <_pol2.h>

int qffmsreglapv( q, D, d, LD, G, s, Ls, E, L, Ef, H0, H1 )
single q, s;
pol D, d;
list LD;
int G, Ls;
floating *pEf;
int *pE, *pL, *pH0, *pH1;

R = qffmsreglapv( q, D, d, LD, G, s, Ls, &E, &L, &Ef, &H0, &H1 ); 

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
.B d 
= principal part of D^(1/2) in dense representation.

.TP 4
.B LD
contains the factorization of D (see upmscfacts).

.TP 4
.B G
is an integer, 1 < G < BASIS^2. In the first step of the algorithm, one tests
whether R <= G (see qffmsregbgb()).

.TP 4
.B s
is an integer such that 0 < s < BASIS. If s = 0, then s := 10000 by default.
In the second step, one computes E and L such that | h - E | < L^2.
(See qffmsapprox()) The minimum of s and L will be the input L for qffmsmulti(). 

.TP 4
.B Ls
is an integer >= 0, and defines the starting point for
the search of qffmsmulti() in the interval [E-L^2,E+L^2]. 
If Ls = 0, then Ls is set to L by default.

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
be found in the reference. It is a version of qffmsreglap() which
leaves the definition of the parameters to the user. A non-experienced
user should use qffmsreglap().

.SH SEE ALSO
.BR qffmsapprox(),
.BR qffmsreglap()
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/

#include <_arith3.h>
#define defG 10000

/* single t, gt; */

int qffmsreglapv( q, D, d, LD, G, s, Ls, pE, pL, pEf, pH0, pH1 )
single q, s;
pol D, d;
list LD;
int G, Ls;
floating *pEf;
int *pE, *pL, *pH0, *pH1;
{
	single n, s1;
	int E, L, H0, H1, R, B;
	floating Ef;
	pol D1;
	bind( D, d, LD, G, Ls );
	init( E, L, H0, H1, R, B, Ef, D1 );
	
	n = lfirst( D );
	D1 = ptodp( 1, D );
	d = ptodp( 1, d );

	if( !G ) G = defG; /* Default G = 10000 */
	s1 = isqrt( G );

	if( !s ) s = 10000;

/* printf("\ns1 = %i", s1); fflush(stdout); */ 
/* gt = 0; settime(); */

   /* Step 1: Test, whether R <= G */
	R = qffmsregbgb( q, D1, d, s1, G ); 

/* t = settime(); gt += t; printf("\nR < G: ");upputtime(t);fflush( stdout ); */	
	if( R ) { *pEf = itofl( 1 ); *pE = 0; *pL = 0; *pH1 = 0; 
		*pH0 = 0; return( R );
	}

/* settime(); */

    /* Step2 : Approximation of h such that | h - E | < L^2, Ef = E'( al, D )  */

	E = qffmsapprox( q, D, LD, n, &L, &Ef ); 
	*pEf = Ef;

/* t = settime(); gt += t; printf("\nApprox: ");upputtime(t); */	
/* settime();*/

    /* Step3 : Compute a multiple H1 = H0 * R in the interval [ E - L^2, E + L^2 ] */

	H1 = qffmsmulti( q, D1, d, E, imin( L, s ), Ls ); 

/* t = settime();gt += t;printf("\nMultiple: ");upputtime(t);*/

	if( !H1 ) { *pE = E; *pL = L;  *pH1 = 0; *pH0 = 0;
		return( qffmsregbg( q, D ) );
	}
	B = isum( E, isquare( L ) );
	B = isum( 1, iquot( B, G ) );

/* settime(); */
    /* Step4 : Compute h1 = H1/ R  by a principal ideal test */

	H0 = qffmspitest( q, D1, d, H1, B );
	*pE = E;
	*pL = L;
	*pH1 = H1;
	*pH0 = H0;
	
/* t = settime();gt += t;printf("\nPitest: ");upputtime(t); */

	return( iquot( H1, H0 ) );
}

/* 
upputtime(t)
single t;
{
	single TS, TH, D, H, M;

	TH = t % 100;
	TS = t / 100;
	D  = TS / 86400; TS = TS % 86400;
	H  = TS / 3600; TS = TS % 3600;
	M  = TS / 60; TS = TS % 60;

      	if ( D ) printf("%d d ",D);
      	if ( H ) printf("%d h ",H);
      	if ( M ) printf("%d min ",M);
      	printf("%d.%02d sec",TS,TH);
  
}
*/