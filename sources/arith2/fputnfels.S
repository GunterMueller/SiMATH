/*M
.SH NAME
fputnfels - file put number field element, sparse representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputnfels (F, a, V, pf)  
pol F; 
nfel a; 
list V; 
FILE *pf;
     
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree > 1. F generates a number field, say K.
.TP 4
.B a
is an element of K, represented by a univariate sparse polynomial of degree < degree(F) over Q.
.TP 4
.B V
is a list of variables, V contains one element. 
.TP 4
.B pf
points on an output file.      
.PP
fputnfels writes a to the file *pf and returns 0 by success and ERROR else.

M*/
                                   
/*H
	Version 1       16.06.1987      Pascale Serf
	Version 2       22.07.1988      nfel durch nfels ersetzt.  PS
   DATE fputnfels     : 890501
H*/


# include <_arith2.h>

single fputnfels(F,a,V,pf)
pol F;
nfel a;
list V;
FILE *pf;
{
	single t;

	bind(F,a,V);

	t = fputpr(1,a,V,pf);
	if ( t == ERROR ) errmsgio("fputnfels","EA113");

	return(t);
}
