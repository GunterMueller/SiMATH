/*M
.SH NAME
qffmsregbg \- 
quadratic function field over modular singles regulator,
baby step - giant step version"

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsregbg( m, D )
single m; 
pol D; 

R = qffmsregbg( m, D ); 

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k:= Z/mZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
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
qffmsreglap resp. qffmsreglapv should be prefered for larger regulators,
since they are much faster.
	
.SH SEE ALSO
.BR qffmiregbg(),
.BR qffmsregbgv(),
.BR qffmsreglap(),
.BR qffmsreglapv()
M*/

/*H
        Version 1       07.06.1991      A.Stein  
        Version 2       01.08.1991      neue Definition von s; richtige
                                        Logik bei if-else.  AS  
        Version 3       28.10.1991      Logikanpassung zu UP's. AS
        Version 4       14.08.1997      new submodule. AS
   DATE qffmsregbg    : 910715.910915.920331.9211__
H*/
#include <_arith3.h>
#define maxbs 10000

int qffmsregbg(m,D)
single m;
pol D;
{
	single s,degD;
	int R,M;
	bind(D);
        init(R,M);
	
    /* Berechne s = Min { ( m^[grad(D)/4] / 2 ) , maxbs }  */
        degD = lfirst(D);
	if ( degD % 4 ) {
		M = iexp(m,(degD/2));
		M = isqrt(M); 
	}
	else M = iexp(m,(degD/4));
	M = isquot(M,2);
	s = imin(M,maxbs);
	if ( m > 10000 ) R = qffmsregbg0(m,D,s);
	else if ( ( degD <= 8 ) || ( m > 100 ) ) R = qffmsregbg1(m,D,s);
	else if ( ( degD <= 12 ) || ( m>20 && m<100 ) )  R = qffmsregbg2(m,D,s);
	else if ( ( degD >= 20 ) && ( m <= 7 ) ) R = qffmsregbg4(m,D,s); 
	else R = qffmsregbg3(m,D,s); 	

        return( R ) ;
}
