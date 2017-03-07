/*M
.SH NAME
nfeprodspec - number field element product special

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol nfeprodspec(F, a, b, M) 
pol F, a, b; 
int M;
  
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers.
.TP 4
.B a, b
are elements of A, represented by  CD-polynomials (s. cdprfcl).  
.TP 4
.B M
is a non negative integer number.
.PP
nfeprodspec returns an element of A, say c, where
.IP
c = a * b.
.PP
Thereby, all products used for the computation, will be reduced modulo M * Z[x].    
M*/

/*H
	Version 1       23.05.89        J.Schmitt
   DATE nfeprodspec   : 891101.9001__
H*/

#include<_arith2.h>

pol nfeprodspec(F,a,b,M)
pol F,a,b;
int M;
{
	int ap,bp,cp,N;
	pol c,Q;
	init(ap,bp,cp,N,c,Q);
	bind(F,a,b,M);

	if ((a==0)||(b==0)) return(0);
	ap = lfirst(a);
	bp = lfirst(b);
	a = lred(a);
	b = lred(b);
	cp = iprod(ap,bp);

	if (M==0) {
		c = piprod(1,a,b);
		c = piqrem(1,c,F,&Q);
	}
	else {
		N = iprod(cp,M);
		a = pitopmi(1,a,N);
		b = pitopmi(1,b,N);
		F = pitopmi(1,F,N);
		c = pmiprod(1,N,a,b);
		c = pmiqrem(1,N,c,F,&Q);
	}
	if (Q!=0) {
		c = lcomp(1,Q);
		c = cdpriquot(c,cp);
	}
	else    c = 0;
	return(c);
}
