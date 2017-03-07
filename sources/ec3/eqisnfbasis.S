/*M
.SH NAME
eqisnfbasis - elliptic curve over quadratic number field with integral
coefficients, short normal form, basis 

.SH SYNOPSIS
.nf
#include<_ec3.h>

list  eqisnfbasis(E)
list   E;

.SH DESCRIPTION
eqisnfbasis() returns a basis of an elliptic curve E over a quadratic
number field K = Q(D^(1/2))
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
M*/
/*H
        Version 1       21.12.1998      S. Schmitt
   DATE eqisnfbasis     :    981230
H*/

# include <_ec3.h>
                                                                                
list eqisnfbasis(E)
list E;
{
	single r;
	list L,B;
	floating A;

	init(L,B,A);
	bind(E);

	r = ecqnfrank(E);
	L = eqisnfslip(E,r);
	A = ecqnfminnth(E);


	B = eqisnfbassp(E,L,A);
		
	return(B);
}
