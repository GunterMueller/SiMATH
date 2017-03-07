/*M
.SH NAME
fgetnfels - file get number field element, sparse representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel fgetnfels( F,V,pf )  
pol F; 
list V; 
FILE *pf;
        
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial Q of degree > 1. F generates a number field, say K.
.TP 4
.B V
is a list of variables, V contains one element. 
.TP 4
.B pf
points on the input file *pf.
.PP
fgetnfels reads a univariate polynomial, say P, in the variable given in V, over Q from the file *pf. The polynomial will be reduced modulo F. By success, fgetnfel returns that element (in sparse representation) as an element of K and ERROR else. 

.SH SEE ALSO
getnfels

M*/

/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nfel durch nfels ersetzt.  PS
   DATE fgetnfels     : 890501
H*/


# include <_arith2.h>

nfel fgetnfels(F,V,pf)
pol F;
list V;
FILE *pf;
{
	nfel a;

	bind(F,V);
	init(a);

	a = fgetpr(1,V,pf);
	if ( a == ERROR ) errmsgio("fgetnfels","EA009");
	else a = prrem(1,a,F);

	return(a);
}
