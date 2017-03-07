/*M
.SH NAME
qffmsregbgb \- 
quadratic function field over modular singles,
baby step - giant step version with bound
.\" ( m, D, d, s, B ) 

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsregbgb( m, D, d, s, B )
single m, s;
int  B;
pol D, d; 

R = qffmsregbgb( m, D, d, s, B ); 

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k := Z/mZ.

.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.

.TP 4
.B d 
= principal part of D^(1/2) in dense representation.

.TP 4
.B s
is an integer such that 0 < s < BASIS, and d(A_s,A_1) <= B, where
A_1 = [ 1, D^(1/2) ], A_s is the  reduced, principal ideal,  which
one obtains after s baby steps applied to A_1. and d(A_s,A_1) denotes 
the distance from A_s to A_1. As long as the space
is large enough, s should be chosen in the order of magnitude
B^(1/2). Otherwise s should be chosen less than the
maximal space size or less than a fixed maximum for the stored
reduced, principal ideals (for instance s <= 100000).

.TP 4
.B B is an integer > 1. 

.TP 4
.B R 
is the regulator of k(X,Y), if R <= B. (baby -giant).

.TP 4
.B R 
= 0, if R > B.

.SH LITERATURE
A. Stein, "Algorithmen in reell-quadratischen Kongruenz
funktionenk"orpern",
PhD Thesis, Universit"at des Saarlandes, Saarbr"ucken, 1996.

.SH NOTE
The algorithm depends strongly on the maximal space. Since, there
has to be stored about 4s polynomials and s integers.

.SH SEE ALSO
.BR qffmiregbgb(),
.BR qffmsregbg()
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/

#include <_arith3.h>

int qffmsregbgb( m, D, d, s, B )
single m, s;
pol D, d;
int B; 
{
	single degD;
	int R;
	bind( D, d, B );
        init( R );

	degD = lfirst( D );	
	if ( m > 10000 ) R = qffmsregbgb0( m, D, d, s, B );
	else if ( ( degD <= 8 ) || ( m > 100 ) ) R = qffmsregbgb1( m, D, d, s, B );
	else if ( ( degD <= 12 ) || ( m>20 && m<100 ) )  R = qffmsregbgb2( m, D, d, s, B );
	else if ( ( degD >= 20 ) && ( m <= 7 ) ) R = qffmsregbgb4( m, D, d, s, B ); 
	else R = qffmsregbgb3( m, D, d, s, B ); 	

        return( R ) ;
}
