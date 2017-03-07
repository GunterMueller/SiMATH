/*M
.SH NAME
upprmsp1afes - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, algebraic function over modular single prime, transcendence degree 1, evaluation special

.SH SYNOPSIS
.nf
#include<_arith4.h>

pol upprmsp1afes(p, F, P, a) 
single p; 
pol F, P, a;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x].
.TP 4
.B P
is an univariate polynomial over (Z/pZ)[x].
.TP 4
.B a
is an element in A, represented by a CD-polynomial (s. cdprfmsp1fcl).
.PP
upprmsp1afes returns a CD-polynomial, representing P(a).

.SH SEE ALSO
cdprfmsp1fcl

M*/
        
/*H
	Version 1       10.01.90      	J.Schmitt
   DATE upprmsp1afes  : 901120
H*/

#include<_arith4.h>

pol upprmsp1afes(p,F,P,a)
single p;
pol F,P,a;
{
	single e1,e2,i;
	pol b,a2,E;
	init(b,a2,E);
	bind(F,P,a);

	if ( P == 0 ) return(0);
	E  = list2(0,1);
	e1 = lfirst(P);
	P  = lred(P);
	b  = lfirst(P);
	P  = lred(P);
	b  = list3(E,0,b);
	while ( P != _0 ) {
		e2 = lfirst(P);
		P  = lred(P);
		a2 =lfirst(P);
		P  = lred(P);
		a2 = list3(E,0,a2);
		for (i=e2;i<e1;i++) b = afmsp1prodsp(p,F,b,a,0);
		b  = cdprfmsp1sum(p,b,a2);
		e1 = e2;
	}
	for (i=1;i<=e1;i++) b = afmsp1prodsp(p,F,b,a,0);
	return(b);
}
