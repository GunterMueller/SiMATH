/*M
.SH NAME
fgetgfsel - file get Galois-field with single characteristic element

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel fgetgfsel(p, AL, V, pf)  
single p; 
list AL, V; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen), and G is an irreducible, monic and univariate polynomial over Z/pZ of
degree >= 1.
.TP 4
.B V
is a list of variables, V contains one element.   
.TP 4
.B pf
points on the input file *pf.      
.PP
fgetgfsel reads a univariate polynomial, say P, in the variable given in V, over Z from the file *pf.
The polynomial will be reduced modulo G and its coefficients modulo p. By success, fgetgfsel returns the polynomial as an element of GF(p^n) and ERROR else.

.SH SEE ALSO
 gfsalgen
 getgfsel
              
M*/
                             
/*H
	Version 1       03.09.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
   DATE fgetgfsel     : 890501
H*/


# include <_arith2.h>

gfel fgetgfsel(p,AL,V,pf)
single p;
list AL,V;
FILE *pf;
{
	gfel a;
	pol G;

	bind2(AL,V);
	init2(a,G);

	a = fgetpms(1,p,V,pf);
	if ( a == ERROR ) {
		errmsgio("fgetgfsel","EA008");
		return(ERROR);
	}
	else {
		G = lfirst(AL);
		return(pmsrem(1,p,a,G));
	}
}
