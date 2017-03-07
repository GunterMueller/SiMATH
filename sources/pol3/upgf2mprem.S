/*M
.SH NAME
upgf2mprem - univariate polynomial over Galois-field with characteristic 2, monomial, polynomial, remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2mprem(G, a, T, P)  
obj G; 
gf2el a; 
int T; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).       
.TP 4
.B a
is an element in GF(2^n), represented as an univariate polynomial over Z/2Z of degree < n in special bit-representation, a != 0.
.TP 4
.B T 
is a positive integer number.
.TP 4
.B P
is a polynomial in the variable x over GF(2^n) of positive degree, the coefficients of P are given in special bit-representation.
.PP
upgf2mprem returns a polynomial, say R, where
.IP
R(x) = (a*x)^T mod P(x).
                         
.SH SEE ALSO
udpm2tosb

M*/
                       
/*H
	Version 1	28.04.93	J.Schmitt
   DATE upgf2mprem    : 930531
H*/

# include <_pol3.h>

pol upgf2mprem(P2,a,t,P)
pol P2;
gf2el a;
int t;
pol P;
{
	int k,r;
	single n;
	gf2el b;
	pol B,B2,X;
	bind(P2,a,t,P);
	init(k,r,b,B,B2,X);
	
	n = lfirst(P);
	
	if ( icomp(t,n) < 0 ) {
		b = gf2exp(P2,a,t);
		X = list2(t,b);
		return(X);
	}
	if ( icomp(t,2) <= 0 ) {
		b = gf2exp(P2,a,t);
		B = list2(t,b);
		B = pgf2qrem(1,P2,B,P,&X);
		return(X);
	}

	k = 2;
	while ( icomp(k,t) <= 0 ) k = ip2prod(k,1);
	k = ip2quot(k,1);
	
	X = list2(1,a);
	B = list2(1,a);
	r = idif(t,k);
	do {
		B = pgf2prod(1,P2,B,B);
		if ( pdegree(1,B) >= n ) B2 = pgf2qrem(1,P2,B,P,&B);
		k = ip2quot(k,1);
		if ( icomp(r,k) >= 0 ) {
			B = pgf2prod(1,P2,X,B);
			if ( pdegree(1,B) >= n ) B2 = pgf2qrem(1,P2,B,P,&B);
			r = idif(r,k);
		}
	}
	while ( icomp(k,1) );
	return(B);
}
