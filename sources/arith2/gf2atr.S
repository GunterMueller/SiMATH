/*M
.SH NAME
gf2atr - Galois-field with characteristic 2 absolute trace

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2el gf2atr (G, a)
obj G;
gf2el a;

tr = gf2atr (G, a);

.SH DESCRIPTION
gf2atr() computes the absolute trace tr of 
an element a of GF(2^n).
.TP 4
.B G
is an irreducible, univariate polynomial in special
bit representation (see udpm2tosb() for a description).
G is a generating polynomial for GF(2^n).
.TP 4
.B a
is an element of GF(2^n), i.e. an univariate
polynomial of degree < n in special bit 
representation.
.TP 4
.B tr
is the absolute trace of a, i.e. the trace over
GF(2).
M*/
/*H
	Version 1	21.01.1996	Georg Lay
   DATE gf2atr 	      : 960501
H*/

#include <_arith2.h>

gf2el gf2atr (G,a)
list G;
gf2el a;
 {
 single n,i;
 gf2el x;
 bind (a);
 init (x);

 x = 0;
 n = lfirst (G);

 for (i = 0; i < n; i++) {
	x = gf2sum (G,x,a);
	a = gf2squ (G,a);
	}

 return (x);
 }
