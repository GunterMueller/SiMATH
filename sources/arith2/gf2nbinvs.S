/*M
.SH NAME
gf2nbinvs - Galois-field of characteristic 2 element in normal basis representation inversion, special

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbinvs(G, a, NP, PN)
obj   G;   
gf2el a;  
list NP, PN; 

b = gf2nbinvs(G, a, NP, PN);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B a != 0 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
.TP 4
.B NP, PN
are  square matrices over F of dimension n in special bit representation
(see 'mamstom2'). They describe the transformation from
normal to power representation and the back transformation
(see 'gf2pbtnbtm').
.TP 4
.B b 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
b = a^(-1) in F, if a != 0
  = ERROR, otherwise.

.SH NOTE
Usually, gf2nbinvs() is much faster than gf2nbinv() by 
transforming a to the power basis representation and using
gf2inv().
 
.SH SEE ALSO
.BR gf2nbinv(),
.BR gf2inv(),
.BR gf2pbtnbtm(),
.BR gf2nbtpbtm()
.BR mamstom2(),
.BR udpm2tosb()
M*/
/*H
	Version 1	30.09.96	A.Stein
   DATE gf2nbinvs	: 961201
H*/

#include <_arith2.h>

gf2el gf2nbinvs( G, a, NP, PN )
pol   G;   
gf2el a;  
list NP, PN; 
{
    if( a )  {
	bind( G, a, NP, PN);

	/* a.) transform a in normal basis representation 
               to power basis representation.
	   b.) use gf2inv -- which is much faster --
           c.) transform back to normal basis representation; */

	a = gf2elsbbt(G, NP, a);
	a = gf2inv(G, a);
	a = gf2elsbbt(G, PN, a);
	return( a );
    }
    return( ERROR );
}
