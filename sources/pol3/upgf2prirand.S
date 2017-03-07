/*M
.SH NAME
upgf2prirand - univariate polynomial over Galois-field with characteristic 2 primitive polynomial randomize

.SH SYNOPSIS
.nf
#include <_pol3.h>

upgf2prirand(G,n,j)
pol G;
single n,j;

P = upgf2prirand(G,n,j);

.SH DESCRIPTION
upgf2prirand() returns a random monic univariate primitive Polynomial over GF(2^n)
of degree n with j coefficients (esp. non vanishing constant term).
The exponent of a polynomial f(X) over GF(2^n) is the minimal e such that f(X) 
divides X^e-1. The polynomial f(X) is primitive, if the exponent of f(X) has 
the maximal possible value 2^n-1.
.TP 4
.B G
is an irreducible, univariate polynomial in special
bit representation (see udpm2tosb() for a description).
G is a generating polynomial for GF(2^n).
.TP 4
.B n
is a single with n > 1.
.TP 4
.B j
is a single with n+2 > j > 2.
.TP 4
.B P
is a monic univariate primitive Polynomial over GF(2^n) of degree n with
j non vanishing coefficients and with P(0) not equal zero.
M*/
/*H
        Version 1       07.10.1996      Joachim Schmitt
	DATE upgf2prirand	: 961201
H*/

#include <_pol3.h>

pol upgf2prirand(G,n,j)

pol G;
single n,j;
{
        pol P,H,H2;
	single jn,i,k;
	bind(G);
	init(P,H,H2);

	i = 0;
	while(i!=1) {
		P = upgf2rand(G,n,j);
		i = upgf2pritest(G,P);
	}
	return(P);
} 
