/*M
.SH NAME
fgetgf2el - file get Galois-field with characteristic 2 element

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el fgetgf2el(G, V, pf)  
obj G; 
list V; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z of degree >= 1, in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B V
is a list of variables, V contains one element.
.TP 4
.B pf
points on the input file *pf.
.PP
fgetgf2el reads a univariate polynomial, say P, in the variable given in V, over Z from the file *pf. 
The coefficients of P will be reduced modulo 2. After that, P will be converted into special bit notation (s. udpm2tosb) and reduced modulo G. By success, fgetgf2el returns the polynomial as an element of GF(2^n) and ERROR else.

.SH SEE ALSO
 udpm2tosb
 getgf2el

M*/
  
/*H
	Version 1       11.03.1992	A.Stein
   DATE fgetgf2el     : 920331
H*/


# include <_arith2.h>

gf2el fgetgf2el(G,V,pf)
obj G;
list V;
FILE *pf;
{
	gf2el a;
	bind(G,V);
	init(a);

	a = fgetpms(1,2,V,pf);
	if ( a == ERROR ) {
		errmsgio("fgetgf2el","EA008");
		return(ERROR);
	}
	else {
		a = ptodp(1,a);
		return( udpm2togf2el(G,a) );
	}
}
