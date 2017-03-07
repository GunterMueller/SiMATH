/*M
.SH NAME
ouspidenic - order of a univariate separable polynomial over the integers denominator of the integral closure

.SH SYNOPSIS
.nf
#include<_arith2.h>

int ouspidenic(F)  
pol F;
 
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic, separable and univariate polynomial over the integer numbers, the degree of F has to be equal to or greater than 2.
.PP
ouspidenic returns the denominator of the integral closure of the polynomial order Z[X]/(F(X)), i.e. the smallest natural number, say D, for which the integral closure is contained in 1/D * Z[X]/(F(X)).
 
M*/
                                        
/*H
	Version 1	29.03.95	Wolfgang Schwarz
   DATE ouspidenic    : 951201
H*/

#include <_arith2.h>

int ouspidenic(F)
pol F;
{
	int D,a;
	list L,muell;
	bind(F);
	init(D,a,L,muell); 
         
	L = ouspibasisic(F,&muell);
	D = 1;
	while (L != _0)
		{prnumden(1,lfirst(L),&a);
		 D = ilcm(D,a);
		 L=lred(L);
		}
	return(D);
}	

