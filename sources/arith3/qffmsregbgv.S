/*M
.SH NAME
qffmsregbgv \- 
quadratic function field over modular singles regulator,
baby step - giant step version"

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsregbgv( m, D, s )
single m; 
pol D; 

R = qffmsregbg( m, D, s ); 

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k:= Z/mZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.B s
is an integer such that 0 < s < BASIS. As long as the space
is large enough, s should be chosen in the order of magnitude
q^(deg(D)/4). Otherwise s should be chosen less than the
maximal space size or less than a fixed maximum for the stored
reduced, principal ideals (for instance s <= 100000).
.TP 4
.B R
is the regulator of the real quadratic congruence function field
k(X,Y) and it is computed by the optimized baby step - giant step
algorithm.

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).


.SH NOTE
The algorithm depends strongly on the maximal space. Since, there
has to be stored about 4 * s polynomials of degree  <= Grad(D)/2
and s integers.

.SH SEE ALSO
.BR qffmsregbg()
M*/

/*H
        Version 1       07.06.1994	A.Stein  
   DATE qffmsregbgv   : 941201
H*/

#include <_arith3.h>

int qffmsregbgv(m,D,s)
single m, s;
pol D;
{
	single degD;
	int R;
	bind(D);
        init(R);

	degD = lfirst( D ); 
	if ( m > 10000 ) R = qffmsregbg0(m,D,s);
	else if ( ( degD <= 8 ) || ( m > 100 ) ) R = qffmsregbg1(m,D,s);
	else if ( ( degD <= 12 ) || ( m>20 && m<100 ) )  R = qffmsregbg2(m,D,s);
	else if ( ( degD >= 20 ) && ( m <= 7 ) ) R = qffmsregbg4(m,D,s); 
	else R = qffmsregbg3(m,D,s); 	

        return( R ) ;
}
