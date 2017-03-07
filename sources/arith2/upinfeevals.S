/*M
.SH NAME
upinfeevals - univariate polynomial over the integers number field element evaluation special

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol upinfeevals(F, P, a) 
pol F, P, a;
  
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic, separable and univariate polynomial over the integer numbers.
.TP 4
.B P
is an univariate polynomial over the integer numbers.
.TP 4
.B a
is a CD-polynomial, representing an element of A (s. cdprfcl).    
.PP
upinfeevals returns an element of A, say b, where b is equal to the evaluation of P at a.

.SH SEE ALSO
cdprfcl

M*/
                    
/*H
	Version 1       23.05.89        J.Schmitt
   DATE upinfeevals   : 891101
H*/

#include<_arith2.h>

pol upinfeevals(F,P,a)
pol F,P,a;
{
	single e1,e2,i;
	pol b,a2;
	init(b,a2);
	bind(F,P,a);

	if (P==0) return(0);
	e1 = lfirst(P);
	P = lred(P);
	b = lfirst(P);
	P = lred(P);
	b = list3(1,0,b);
	while (P!=_0) {
		e2 = lfirst(P);
		P = lred(P);
		a2 =lfirst(P);
		P = lred(P);
		a2 = list3(1,0,a2);
		for (i=e2;i<e1;i++) b = nfeprodspec(F,b,a,0);
		b = cdprsum(b,a2);
		e1 = e2;
	}
	for (i=1;i<=e1;i++) b = nfeprodspec(F,b,a,0);
	return(b);
}
