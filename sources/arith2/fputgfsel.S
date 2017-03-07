/*M
.SH NAME
fputgfsel - file put Galois-field with single characteristic element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputgfsel(p, AL, a, V, pf)

single p; 
list AL, V; 
gfel a; 
FILE *pf;
     
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a
is an element of GF(p^n).
.TP 4
.B V
is a list of variables, V contains one element.  
.TP 4
.B pf
points on an output file.        
.PP
fputgfsel writes a to the file *pf and returns 0 by success and ERROR else.

M*/
                                      
/*H
	Version 1       03.09.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
   DATE fputgfsel     : 890501
H*/


# include <_arith2.h>

single fputgfsel(p,AL,a,V,pf)
single p;
list AL,V;
gfel a;
FILE *pf;
{
	single t;

	bind3(AL,a,V);

	t = fputpms(1,p,a,V,pf);
	if ( t == ERROR ) errmsgio("fputgfsel","EA112");
	return(t);
}
