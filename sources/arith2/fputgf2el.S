/*M
.SH NAME
fputgf2el - file put Galois-field with characteristic 2 element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputgf2el(G, a, V, pf)  
obj G; 
gf2el a; 
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
.B a
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.TP 4
.B V
is a list of variables, V contains one element.    
.TP 4
.B pf
points on an output file.
.PP
fputgf2el transforms a into sparse representation and writes it to the output file *pf.
fputgf2el returns 0 by success and ERROR else.   

M*/
              
/*H
	Version 1       11.03.1992	A.Stein
   DATE fputgf2el     : 920331
H*/


# include <_arith2.h>

single fputgf2el(G,a,V,pf)
obj G;
gf2el a;
list V;
FILE *pf;
{
	single t;

	bind(G,a,V);
	
	a = gf2eltoudpm2(G,a);
	a = dptop(1,a);
	t = fputpms(1,2,a,V,pf);
	if ( t == ERROR ) errmsgio("fputgf2el","EA112");
	return(t);
}
