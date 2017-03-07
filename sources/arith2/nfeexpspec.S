/*M
.SH NAME
nfeexpspec - number field element exponentiation special

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol nfeexpspec(F, a, e, M) 
pol F, a; 
single e; 
int M;

.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers.
.TP 4
.B a
is a CD-polynomial, representing an element of A (s. cdprfcl).
.TP 4
.B e
is a non-negative single.
.TP 4
.B M
is a non-negative integer.
.PP
nfeexpspec returns a CD-polynomial which represents a^e. 
Thereby, all products used for the computation, will be reduced modulo M * Z[x] (s. nfeprodspec).
 
.SH SEE ALSO
 cdprfcl
 nfeprodspec

M*/
                               
/*H
	Version 1       23.05.89        J.Schmitt
   DATE nfeexpspec    : 891101.9011__
H*/

#include<_arith2.h>

pol nfeexpspec(F,a,e,M)
pol F,a;
single e;
int M;
{
	single i;
	pol b;
	init(b);
	bind(F,a,M);

	b = list3(1,0,1);
	while ( e != 0 ) {
		i = mods(e,2);
		e = divs(e,2);			
		if (i) b = nfeprodspec(F,b,a,M);
		if (e) a = nfeprodspec(F,a,a,M);
	}
	return(b);
}
