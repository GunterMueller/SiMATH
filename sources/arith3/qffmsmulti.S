/*M
.SH NAME
qffmsmulti \- 
quadratic function field over modular singles,
multiple of the regulator search
.\" ( q, D, d, E, L, Ls )

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsmulti( q, D, d, E, L, Ls )
single q;
int E, L, Ls; 
pol D, d;

H1 = qffmsmulti( q, D, d, E, L, Ls );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, 2 < q < BASIS. Let k := Z/qZ.

.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.

.TP 4
.B d 
is the principal part of the puiseux series expansion of D^(1/2) in k((1/X))
in dense representation.

.TP 4
.B E, L
are integers > 1 such that
 | h - E | < L^2  ,
where h = h' * R denotes the divisor class number of k(X,Y). 
Since one has to store approximately L ideals, L should be chosen
according to the space limitations (for normal use L <= 20000).

.TP 4
.B Ls
is an integer >= 0, and defines the starting point for
the search in the interval [E-L^2,E+L^2]. 
If Ls = 0, then Ls is set to L by default.

.TP 4
.B H1
is a multiple of the regulator R of k(X,Y) such that 
 H1 = h0 * R < E + L^2.

.SH LITERATURE
A. Stein, "Algorithmen in reell-quadratischen Kongruenz-
funktionenk"orpern",
PhD Thesis, Universit"at des Saarlandes, Saarbr"ucken, 1996.

A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field", Preprint 1997.

.SH NOTE
The multiple is found by means of baby step-giant step algorithm.
At the current stage, the algorithm does not make use of the idea of
computing several baby steps at each giant step. Also,
the storing can be improved by using some aspects of the stored
ideals and the, if necessary, computes closest ideals.

.SH SEE ALSO
.BR qffmsreglap(),
.BR qffmsreglapv(),
.BR qffmsmulti1() etc.
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/



/* D, d in dense Darstellung
   neuer Parameter Ls */

/*H
        Version 1       13.08.1997	A.Stein  
H*/

#include <_arith3.h>

int qffmsmulti( q, D, d, E, L, Ls )
single q;
int E, L, Ls; 
pol D, d;
{
	single degD;
	int H1;
	bind( D, d, E, L, Ls );
        init( H1 );
	
	degD = lfirst( D );	
	if ( q > 10000 ) H1 = qffmsmulti0( q, D, d, E, L, Ls );
	else if ( ( degD <= 8 ) || ( q > 100 ) ) H1 = qffmsmulti1( q, D, d, E, L, Ls );
	else if ( ( degD <= 12 ) || ( q>20 && q<100 ) )  H1 = qffmsmulti2( q, D, d, E, L, Ls );
	else if ( ( degD >= 20 ) && ( q <= 7 ) ) H1 = qffmsmulti4( q, D, d, E, L, Ls ); 
	else H1 = qffmsmulti3( q, D, d, E, L, Ls ); 	

        return( H1 ) ;
}
