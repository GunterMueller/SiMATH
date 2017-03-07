/*M
.SH NAME
gf2nbsums - Galois-field of characteristic 2 element in normal basis representation sum, special

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbsums(G, a, b, NP, PN)
obj   G;   
gf2el a, b;   
list NP, PN; 

c = gf2nbsums(G, a, b, NP, PN)

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B a, b 
are elements of F given in special bit notation
and represented with respect to the current normal basis.
.TP 4
.B NP, PN
are  square matrices over F of dimension n in special bit representation
(see 'mamstom2'). They describe the transformation from
normal to power representation and the back transformation
(see 'gf2pbtnbtm').
.TP 4
.B c 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
c = a + b in F.

.SH NOTE
gf2nbsums() transforms a and b to their power basis representation
and uses gf2sum().

.SH SEE ALSO
.BR gf2sum(),
.BR gf2pbtnbtm(),
.BR mamstom2(),
.BR udpm2tosb()
M*/
/*H
	Version 1	30.09.96	A.Stein
   DATE gf2nbsums	: 961201
H*/

#include <_arith2.h>

gf2el gf2nbsums( G, a, b, NP, PN )
obj   G;   
gf2el a, b;   
list NP, PN; 
{
    gf2el c;
    bind( c );

    if ( !a ) c = b;
    else if ( !b ) c = a;
    else {      
	bind( G, a, b, NP, PN);

	/*	a.) transform a and b in normal basis representation 
                    to power basis representation.
		b.) use gf2sum 
                c.) transform back to normal basis representation;	*/

	a = gf2elsbbt(G, NP, a);
	b = gf2elsbbt(G, NP, b);
	c = gf2sum(G, a, b);
	c = gf2elsbbt(G, PN, c);
    }
    return( c );
}
