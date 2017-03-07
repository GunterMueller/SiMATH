/*M
.SH NAME
isnfels - is number field element, sparse representation ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isnfels(F,a)  
pol F; 
obj a;
   
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial of degree >=1 over Q. F generates a number field, say K.
.PP
isnfels returns
.TP 4
1, 
if a is the representation of an element of K as an univariate polynomial of degree < degree(F) over Q (sparse-representation), and
.TP 4
0,
else.

M*/
                     
/*H
	Version 1       18.06.1988      Pascale Serf
	Version 2       22.07.1988      nfel durch nfels ersetzt.  PS
	Version 3	18.10.1990	Fall a = 0 eingefuegt.  PS
   DATE isnfels       : 890501.910915
H*/


#include <_arith2.h>

single isnfels(F,a)
pol F;
obj a;
{
	single s = 0;

	if ( !a || ispr(1,a) && lfirst(a) < lfirst(F) ) s = 1;

	return(s);
}
